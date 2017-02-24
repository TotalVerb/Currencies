const SFD2 = FixedDecimal{Int16, 2}
const SFD4 = FixedDecimal{Int16, 4}
const FD2 = FixedDecimal{Int, 2}
const FD4 = FixedDecimal{Int, 4}
const WFD2 = FixedDecimal{Int128, 2}
const WFD4 = FixedDecimal{Int128, 4}

const keyvalues = [typemin(FD2),
                   FD2(-0.01),
                   FD2(0),
                   FD2(0.01),
                   FD2(1),
                   typemax(FD2)]

@testset "conversion" begin
    @testset for x in keyvalues
        @testset for T in [Rational{Int128}, WFD2, WFD4]
            @test convert(FD2, convert(T, x)) == x
        end
        if 0 ≤ abs(x) < 100
            @testset for T in [SFD2, SFD4, FD4]
                @test convert(FD2, convert(T, x)) == x
            end
        end
    end
end

@testset "comparison" begin
    for (i, x) in enumerate(keyvalues)
        @test x == x
        for y in keyvalues[i+1:end]
            @test x ≠ y
            @test x < y
            @test x ≤ y
            @test y ≠ x
            @test y > x
            @test y ≥ x
        end
    end
end

@testset "zero, one" begin
    @test FD2(0) == zero(FD2)
    @test FD2(42.42) + FD2(0) == FD2(42.42)
    @test FD2(1) == one(FD2)
    @test FD2(42.42) * FD2(1) == FD2(42.42)
end

@testset "eps" begin
    @test eps(FD2) == FD2(0.01)
    @test eps(FD2(1.11)) == FD2(0.01)
    for x in keyvalues
        if x ≠ typemax(FD2)
            @test x + eps(x) > x
        end
        if x ≠ typemin(FD2)
            @test x - eps(x) < x
        end
    end
end

@testset "addition" begin
    @test FD2(0) + FD2(0) == FD2(0)
    @test FD2(1.11) + FD2(2.22) == FD2(3.33)
    @test FD2(0.01) + FD2(0.01) == FD2(0.02)
    @test typemax(FD2) + eps(FD2) == typemin(FD2)
end

@testset "subtraction" begin
    for x in keyvalues
        @test x - x == 0
        for y in keyvalues
            @test x + y - y == x
            @test y + x - y == x
        end
    end
end

@testset "multiplication" begin
    for x in keyvalues
        @test 1 * x == x * 1 == x
        @test one(x) * x == x * one(x) == x
        @test (-1) * x == x * (-1) == -x
        @test 2 * x == x + x == (one(x) + one(x)) * x
    end
end

@testset "division by 1" begin
    @testset for x in keyvalues
        @test x / one(x) == x
        @test x / -one(x) == -x
    end
end

@testset "division by 2" begin
    # even targets
    for x in FD2[-0.02, 0, 0.02, 1.00]
        for y in [2x-eps(x), 2x, 2x+eps(x)]
            @test y / 2 == y / 2one(y) == x == y * FD2(0.5)
        end
    end

    # odd targets
    for x in FD2[-0.01, 0.01, 1.01]
        y = 2x
        @test y / 2 == y / 2one(x) == x == y * FD2(0.5)
    end
end

@testset "abs, sign" begin
    for x in keyvalues
        @test sign(x)^2 ∈ [0, 1]
        @test abs(abs(x)) == abs(x)
        @test abs(x) * sign(x) == x
        @test abs(x) == abs(-x)
        if x ≠ typemin(x)
            @test abs(x) ≥ 0
            @test sign(x) == -sign(-x)
        end
        @test (abs(x) == 0) === (x == 0)
    end
end

@testset "trunc" begin
    @test trunc(Int, FD2(0.99)) === 0
    @test trunc(Int, FD2(-0.99)) === 0
    @test trunc(Int, FD2(1)) === 1
    @test trunc(Int, FD2(-1)) === -1
    @test trunc(typemax(FD2)) ≤ typemax(FD2)
    @test trunc(Int, typemax(FD2)) ≤ typemax(FD2)
    @test trunc(typemin(FD2)) ≥ typemin(FD2)
    @test trunc(Int, typemin(FD2)) ≥ typemin(FD2)
    @test trunc(eps(FD2)) == 0
    @test trunc(-eps(FD2)) == 0
end

@testset "show" begin
    @testset "compact" begin
        @test sprint(showcompact, FD2(1.00)) == "1.0"
        @test sprint(showcompact, FD2(1.23)) == "1.23"
        @test sprint(showcompact, FD2(42.40)) == "42.4"
        @test sprint(showcompact, FD2(-42.40)) == "-42.4"
        @test sprint(showcompact, FD2(-0.01)) == "-0.01"
        @test sprint(showcompact, FD2(0)) == "0.0"
        for x in keyvalues
            if 0 ≤ abs(x) < 1000
                @test eval(parse(string(x))) == x
            end
        end

        @test string(typemin(FixedDecimal{Int64, 2})) ==
              "FixedDecimal{Int64,2}(-92233720368547758.08)"
        @test string(typemax(FixedDecimal{Int64, 2})) ==
              "FixedDecimal{Int64,2}(92233720368547758.07)"
        @test string(typemin(FixedDecimal{Int32, 2})) ==
              "FixedDecimal{Int32,2}(-21474836.48)"
        @test string(typemax(FixedDecimal{Int32, 2})) ==
              "FixedDecimal{Int32,2}(21474836.47)"
    end
end
