# Currencies.jl

[![Build Status](https://travis-ci.org/JuliaFinance/Currencies.jl.svg?branch=master)](https://travis-ci.org/JuliaFinance/Currencies.jl)
[![Build status](https://ci.appveyor.com/api/projects/status/chnj7xc6r0deux92/branch/master?svg=true)](https://ci.appveyor.com/project/EricForgy/currencies-jl/branch/master)

This is a core package for the JuliaFinance ecosytem. 

It provides bare singleton types based on standard ISO 4167 currency codes to be used primarily for dispatch in other JuliaFinance packages together with five methods:

- `symbol`: The symbol of the currency.
- `currency`: The singleton type instance for a particular currency symbol
- `name`: The full name of the currency.
- `code`: The ISO 4167 code for the currency.
- `unit`: The minor unit, i.e. number of decimal places, for the currency.

For example:

```julia
julia> using Currencies

julia> typeof(currency(:USD))
Currency{:USD}

julia> for ccy in currency.([:USD, :EUR, :JPY, :IQD])
            println("Currency: $(Currencies.symbol(ccy))")
            println("Name: $(Currencies.name(ccy))")
            println("Code: $(Currencies.code(ccy))")
            println("Minor Unit: $(Currencies.unit(ccy))\n")
        end

Currency: USD
Name: US Dollar
Code: 840
Minor Unit: 2

Currency: EUR
Name: Euro
Code: 978
Minor Unit: 2

Currency: JPY
Name: Yen
Code: 392
Minor Unit: 0

Currency: IQD
Name: Iraqi Dinar
Code: 368
Minor Unit: 3
```

If all you need is a list of currencies with names, ISO 4167 codes and minor units, e.g. for building a dropdown menu in a user interface, then this lightweight package is what you want.

## [Instruments.jl](https://github.com/JuliaFinance/Instruments.jl)

When a currency is thought of as a financial instrument (as opposed to a mere label), we choose to refer to it as "Cash" as it would appear in a balance sheet. [Instruments.jl](https://github.com/JuliaFinance/Instruments.jl) implements a `Cash` instrument together with `Position` that allows for basic algebraic manipulations of `Cash` and other financial instrument positions, e.g.

```julia
julia> import Instruments: USD, JPY

julia> 10USD
10.00USD

julia> 10JPY
10JPY

julia> 10USD+20USD
30.00USD

julia> 10USD+10JPY
ERROR: Can't add Positions of different Instruments USD, JPY
```

If you need currencies as a financial instrument with corresponding currency positions, you want [Instruments.jl](https://github.com/JuliaFinance/Instruments.jl).

## Data Source

Data for this package was obtained from https://datahub.io/core/country-codes.

