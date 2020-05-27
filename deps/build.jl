using JSON3

const src = "https://pkgstore.datahub.io/core/country-codes/country-codes_json/data/471a2e653140ecdd7243cdcacfd66608/country-codes_json.json"

inpnam = joinpath(@__DIR__, "..", "data", "country-codes.json")
outnam = joinpath(@__DIR__, "currency-data.jl")

# First, check if currency-data.jl already exists
isfile(outnam) && return

# Only download the file from datahub.io if not already present
if !isfile(inpnam)
    println("Downloading currency data: ", src)
    download(src, inpnam)
end

const country_list = open(io -> JSON3.read(io), inpnam)

const currency_list = Dict{String,Tuple{Int,Int,String}}()

const SymCurr = Symbol("ISO4217-currency_alphabetic_code")
const SymUnit = Symbol("ISO4217-currency_minor_unit")
const SymName = Symbol("ISO4217-currency_name")
const SymCode = Symbol("ISO4217-currency_numeric_code")

function genfile(io)
    for country in country_list
        (abbrlist = country[SymCurr]) === nothing && continue
        (unitlist = country[SymUnit]) === nothing && continue
        (namelist = country[SymName]) === nothing && continue
        (codelist = country[SymCode]) === nothing && continue
        currencies = split(abbrlist, ',')
        units = split(string(unitlist), ',')
        names = split(namelist, ',')
        codes = split(string(codelist), ',')

        for (curr, unit, code, name) in zip(currencies, units, codes, names)
            length(curr) != 3 && continue
            haskey(currency_list, curr) && continue
            currency_list[curr] = (parse(Int, unit), parse(Int, code), string(name))
        end
    end
    println(io, "const _currency_data = Dict(")
    for (curr, val) in currency_list
        println(io, "    :$curr => (Currency{:$curr}(), $(val[1]), $(lpad(val[2], 4)), \"$(val[3])\"),")
    end
    println(io, ")\n")
end

open(io -> genfile(io), outnam, "w")

