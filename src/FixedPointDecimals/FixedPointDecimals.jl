# This file partially based off JuliaMath/FixedPointNumbers.jl
#
# Copyright (c) 2014: Jeff Bezanson and other contributors.
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module FixedPointDecimals

export FixedDecimal

using Compat

import Base: reinterpret, zero, one, abs, sign, ==, <, <=, +, -, /, *, div,
             rem, divrem, fld, mod, fldmod, fld1, mod1, fldmod1, isinteger,
             typemin, typemax, realmin, realmax, show, convert, promote_rule,
             min, max, trunc, round, floor, ceil, eps

"""
    FixedDecimal{I <: Integer, f::Int}

A fixed-point decimal type backed by integral type `I`, with `f` digits after
the decimal point stored.
"""
immutable FixedDecimal{T <: Integer, f} <: Real
    i::T

    # internal constructor, à la FixedPointNumbers.jl
    (::Type{FixedDecimal{T, f}}){T, f}(i::Integer, ::Void) =
        new{T, f}(i % T)

    # external constructor
    (::Type{FixedDecimal{T, f}}){T, f}(x) = convert(FixedDecimal{T,f}, x)
end

const FD = FixedDecimal

floattype{T<:Union{Int8, UInt8, Int16, UInt16}, f}(::Type{FD{T, f}}) = Float64
floattype{T<:Integer, f}(::Type{FD{T, f}}) = Float64
floattype{f}(::Type{FD{BigInt, f}}) = BigFloat

reinterpret{T<:Integer, f}(::Type{FD{T, f}}, x::T) = FD{T, f}(x, nothing)

# basic operators
-{T, f}(x::FD{T, f}) = FD{T, f}(-x.i, nothing)
abs{T, f}(x::FD{T, f}) = FD{T, f}(abs(x.i), nothing)

+{T, f}(x::FD{T, f}, y::FD{T, f}) = FD{T, f}(x.i+y.i, nothing)
-{T, f}(x::FD{T, f}, y::FD{T, f}) = FD{T, f}(x.i-y.i, nothing)

function _round_to_even(quotient, remainder, powt)
    if powt == 1
        quotient
    else
        halfpowt = powt >> 1
        if remainder == halfpowt
            ifelse(iseven(quotient), quotient, quotient + one(quotient))
        elseif remainder < halfpowt
            quotient
        else
            quotient + one(quotient)
        end
    end
end

# multiplication rounds to nearest even representation
# TODO: can we use floating point to speed this up? after we build a
# correctness test suite.
function *{T, f}(x::FD{T, f}, y::FD{T, f})
    powt = T(10)^f
    quotient, remainder = fldmod(Base.widemul(x.i, y.i), powt)
    FD{T, f}(_round_to_even(quotient, remainder, powt), nothing)
end

# these functions are needed to avoid InexactError when converting from the
# integer type
*{T, f}(x::Integer, y::FD{T, f}) = FD{T, f}(T(x * y.i), nothing)
*{T, f}(x::FD{T, f}, y::Integer) = FD{T, f}(T(x.i * y), nothing)

# TODO. this is probably wrong sometimes.
/{T, f}(x::FD{T, f}, y::FD{T, f}) = FD{T, f}(x.i / y.i)

# integerification
trunc{T, f}(x::FD{T, f}) = FD{T, f}(div(x.i, T(10)^f))
floor{T, f}(x::FD{T, f}) = FD{T, f}(fld(x.i, T(10)^f))
# TODO: round with number of digits; should be easy
function round{T, f}(x::FD{T, f})
    powt = T(10)^f
    quotient, remainder = fldmod(x.i, powt)
    FD{T, f}(_round_to_even(quotient, remainder, powt))
end
function ceil{T, f}(x::FD{T, f})
    powt = T(10)^f
    quotient, remainder = fldmod(x.i, powt)
    if remainder > 0
        FD{T, f}(quotient + one(quotient))
    else
        FD{T, f}(quotient)
    end
end

for truncfn in [:trunc, :round, :floor, :ceil]
    @eval $truncfn{TI}(::Type{TI}, x::FD)::TI = $truncfn(x)
end

# conversions and promotions
convert{T, f}(::Type{FD{T, f}}, x::Integer) =
    FD{T, f}(round(T, Base.widemul(T(x), T(10)^f)), nothing)

# TODO. this is very, very incorrect.
convert{T, f}(::Type{FD{T, f}}, x::AbstractFloat) =
    FD{T, f}(round(T, T(10)^f * x), nothing)
convert{T, f}(::Type{FD{T, f}}, x::Rational) =
    FD{T, f}(numerator(x)) / FD{T, f}(denominator(x))
function convert{T, f, U, g}(::Type{FD{T, f}}, x::FD{U, g})
    if f ≥ g
        FD{T, f}(convert(T, Base.widemul(T(10)^(f-g), x.i)), nothing)
    else
        sf = T(10)^(g - f)
        q, r = divrem(x.i, sf)
        if r ≠ 0
            throw(InexactError())
        else
            FD{T, f}(convert(T, q))
        end
    end
end

for remfn in [:rem, :mod, :mod1, :min, :max]
    @eval $remfn{T <: FD}(x::T, y::T) = T($remfn(x.i, y.i), nothing)
end
for divfn in [:div, :fld, :fld1]
    @eval $divfn{T <: FD}(x::T, y::T) = $divfn(x.i, y.i)
end

# TODO.
# rem{T, f}(x::Integer, ::Type{FD{T, f}}) = error("not implemented")
# rem{T, f}(x::Real, ::Type{FD{T, f}}) = error("not implemented")

float(x::FD) = convert(floattype(x), x)

convert{TF <: AbstractFloat, T, f}(::Type{TF}, x::FD{T, f})::TF =
    x.i / TF(10)^f

convert{T, f}(::Type{Bool}, x::FD{T, f}) = x.i ≠ 0

function convert{TI <: Integer, T, f}(::Type{TI}, x::FD{T, f})::TI
    isinteger(x) || throw(InexactError())
    div(x.i, T(10)^f)
end

convert{TR<:Rational,T,f}(::Type{TR}, x::FD{T, f})::TR =
    x.i // T(10)^f

promote_rule{T, f, TI <: Integer}(::Type{FD{T, f}}, ::Type{TI}) = FD{T, f}
promote_rule{T, f, TF <: AbstractFloat}(::Type{FD{T, f}}, ::Type{TF}) = TF
promote_rule{T, f, TR}(::Type{FD{T, f}}, ::Type{Rational{TR}}) = Rational{TR}

# comparison
=={T <: FD}(x::T, y::T) = x.i == y.i
 <{T <: FD}(x::T, y::T) = x.i  < y.i
<={T <: FD}(x::T, y::T) = x.i <= y.i

# predicates and traits
isinteger{T, f}(x::FD{T, f}) = rem(x.i, T(10)^f) == 0
typemin{T, f}(::Type{FD{T, f}}) = FD{T, f}(typemin(T), nothing)
typemax{T, f}(::Type{FD{T, f}}) = FD{T, f}(typemax(T), nothing)
realmin{T <: FD}(::Type{T}) = typemin(T)
realmax{T <: FD}(::Type{T}) = typemax(T)
eps{T <: FD}(::Type{T}) = T(1, nothing)
eps(x::FD) = eps(typeof(x))

# printing
function show{T}(io::IO, x::FD{T, 0})
    iscompact = get(io, :compact, false)
    if !iscompact
        print(io, FD{T, f}, '(')
    end
    print(io, x.i)
    if !iscompact
        print(io, ')')
    end
end
function show{T, f}(io::IO, x::FD{T, f})
    iscompact = get(io, :compact, false)
    integer, fractional = divrem(x.i, T(10)^f)
    if !iscompact
        print(io, FD{T, f}, '(')
    end
    fractionchars = lpad(abs(fractional), f, "0")
    if iscompact
        fractionchars = rstrip(fractionchars, '0')
        if isempty(fractionchars)
            fractionchars = "0"
        end
    end
    print(io, integer, '.', fractionchars)
    if !iscompact
        print(io, ')')
    end
end

end
