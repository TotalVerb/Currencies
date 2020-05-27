using Currencies
using Test

currencies = ((:USD, 2, 840, "US Dollar"),
              (:EUR, 2, 978, "Euro"),
              (:JPY, 0, 392, "Yen"),
              (:JOD, 3, 400, "Jordanian Dinar"),
              (:CNY, 2, 156, "Yuan Renminbi"))

@testset "Basic currencies" begin
    for (s, u, c, n) in currencies
        ccy = Currency{s}()
        @test symbol(ccy) == s
        @test unit(ccy) == u
        @test name(ccy) == n
        @test code(ccy) == c
    end
end
