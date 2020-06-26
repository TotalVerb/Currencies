const _currency_data = Dict(
    :KYD => (2,  136, "Cayman Islands Dollar"),
    :PYG => (0,  600, "Guarani"),
    :AWG => (2,  533, "Aruban Florin"),
    :LAK => (2,  418, "Lao Kip"),
    :TRY => (2,  949, "Turkish Lira"),
    :UYU => (2,  858, "Peso Uruguayo"),
    :NGN => (2,  566, "Naira"),
    :QAR => (2,  634, "Qatari Rial"),
    :EUR => (2,  978, "Euro"),
    :TTD => (2,  780, "Trinidad and Tobago Dollar"),
    :UAH => (2,  980, "Hryvnia"),
    :XPF => (0,  953, "CFP Franc"),
    :JPY => (0,  392, "Yen"),
    :THB => (2,  764, "Baht"),
    :BHD => (3,   48, "Bahraini Dinar"),
    :PEN => (2,  604, "Sol"),
    :SOS => (2,  706, "Somali Shilling"),
    :TJS => (2,  972, "Somoni"),
    :SHP => (2,  654, "Saint Helena Pound"),
    :AOA => (2,  973, "Kwanza"),
    :SGD => (2,  702, "Singapore Dollar"),
    :CHF => (2,  756, "Swiss Franc"),
    :IDR => (2,  360, "Rupiah"),
    :SDG => (2,  938, "Sudanese Pound"),
    :IQD => (3,  368, "Iraqi Dinar"),
    :EGP => (2,  818, "Egyptian Pound"),
    :SLL => (2,  694, "Leone"),
    :UZS => (2,  860, "Uzbekistan Sum"),
    :MAD => (2,  504, "Moroccan Dirham"),
    :MYR => (2,  458, "Malaysian Ringgit"),
    :MMK => (2,  104, "Kyat"),
    :DZD => (2,   12, "Algerian Dinar"),
    :CAD => (2,  124, "Canadian Dollar"),
    :HKD => (2,  344, "Hong Kong Dollar"),
    :MWK => (2,  454, "Malawi Kwacha"),
    :INR => (2,  356, "Indian Rupee"),
    :TZS => (2,  834, "Tanzanian Shilling"),
    :BTN => (2,   64, "Ngultrum"),
    :LRD => (2,  430, "Liberian Dollar"),
    :DKK => (2,  208, "Danish Krone"),
    :NAD => (2,  516, "Namibia Dollar"),
    :PKR => (2,  586, "Pakistan Rupee"),
    :JMD => (2,  388, "Jamaican Dollar"),
    :XOF => (0,  952, "CFA Franc BCEAO"),
    :COP => (2,  170, "Colombian Peso"),
    :HNL => (2,  340, "Lempira"),
    :KWD => (3,  414, "Kuwaiti Dinar"),
    :GHS => (2,  936, "Ghana Cedi"),
    :BAM => (2,  977, "Convertible Mark"),
    :CUC => (2,  931, "Peso Convertible"),
    :MXN => (2,  484, "Mexican Peso"),
    :TND => (3,  788, "Tunisian Dinar"),
    :MZN => (2,  943, "Mozambique Metical"),
    :BOB => (2,   68, "Boliviano"),
    :DOP => (2,  214, "Dominican Peso"),
    :ZMW => (2,  967, "Zambian Kwacha"),
    :MVR => (2,  462, "Rufiyaa"),
    :BSD => (2,   44, "Bahamian Dollar"),
    :KPW => (2,  408, "North Korean Won"),
    :HUF => (2,  348, "Forint"),
    :BIF => (0,  108, "Burundi Franc"),
    :GNF => (0,  324, "Guinean Franc"),
    :PAB => (2,  590, "Balboa"),
    :VEF => (2,  937, "Bolívar"),
    :BZD => (2,   84, "Belize Dollar"),
    :HTG => (2,  332, "Gourde"),
    :SAR => (2,  682, "Saudi Riyal"),
    :GYD => (2,  328, "Guyana Dollar"),
    :GMD => (2,  270, "Dalasi"),
    :ALL => (2,    8, "Lek"),
    :ZAR => (2,  710, "Rand"),
    :PHP => (2,  608, "Philippine Piso"),
    :MRO => (2,  478, "Ouguiya"),
    :AZN => (2,  944, "Azerbaijan Manat"),
    :AED => (2,  784, "UAE Dirham"),
    :ETB => (2,  230, "Ethiopian Birr"),
    :AUD => (2,   36, "Australian Dollar"),
    :HRK => (2,  191, "Kuna"),
    :VND => (0,  704, "Dong"),
    :MDL => (2,  498, "Moldovan Leu"),
    :GTQ => (2,  320, "Quetzal"),
    :GEL => (2,  981, "Lari"),
    :CZK => (2,  203, "Czech Koruna"),
    :MOP => (2,  446, "Pataca"),
    :PLN => (2,  985, "Zloty"),
    :SSP => (2,  728, "South Sudanese Pound"),
    :AFN => (2,  971, "Afghani"),
    :SYP => (2,  760, "Syrian Pound"),
    :STD => (2,  678, "Dobra"),
    :USD => (2,  840, "US Dollar"),
    :BND => (2,   96, "Brunei Dollar"),
    :CVE => (2,  132, "Cabo Verde Escudo"),
    :ARS => (2,   32, "Argentine Peso"),
    :CDF => (2,  976, "Congolese Franc"),
    :PGK => (2,  598, "Kina"),
    :RUB => (2,  643, "Russian Ruble"),
    :MNT => (2,  496, "Tugrik"),
    :RWF => (0,  646, "Rwanda Franc"),
    :SZL => (2,  748, "Lilangeni"),
    :GBP => (2,  826, "Pound Sterling"),
    :WST => (2,  882, "Tala"),
    :BYN => (2,  933, "Belarusian Ruble"),
    :BGN => (2,  975, "Bulgarian Lev"),
    :JOD => (3,  400, "Jordanian Dinar"),
    :YER => (2,  886, "Yemeni Rial"),
    :ZWL => (2,  932, "Zimbabwe Dollar"),
    :LYD => (3,  434, "Libyan Dinar"),
    :TMT => (2,  934, "Turkmenistan New Manat"),
    :FJD => (2,  242, "Fiji Dollar"),
    :KHR => (2,  116, "Riel"),
    :BMD => (2,   60, "Bermudian Dollar"),
    :KZT => (2,  398, "Tenge"),
    :XCD => (2,  951, "East Caribbean Dollar"),
    :NPR => (2,  524, "Nepalese Rupee"),
    :OMR => (3,  512, "Rial Omani"),
    :CLP => (0,  152, "Chilean Peso"),
    :ERN => (2,  232, "Nakfa"),
    :TOP => (2,  776, "Pa’anga"),
    :CUP => (2,  192, "Cuban Peso"),
    :LBP => (2,  422, "Lebanese Pound"),
    :SCR => (2,  690, "Seychelles Rupee"),
    :NOK => (2,  578, "Norwegian Krone"),
    :RON => (2,  946, "Romanian Leu"),
    :MUR => (2,  480, "Mauritius Rupee"),
    :BDT => (2,   50, "Taka"),
    :MGA => (2,  969, "Malagasy Ariary"),
    :SBD => (2,   90, "Solomon Islands Dollar"),
    :ISK => (0,  352, "Iceland Krona"),
    :GIP => (2,  292, "Gibraltar Pound"),
    :KES => (2,  404, "Kenyan Shilling"),
    :BWP => (2,   72, "Pula"),
    :BBD => (2,   52, "Barbados Dollar"),
    :KMF => (0,  174, "Comorian Franc"),
    :XAF => (0,  950, "CFA Franc BEAC"),
    :AMD => (2,   51, "Armenian Dram"),
    :CNY => (2,  156, "Yuan Renminbi"),
    :KRW => (0,  410, "Won"),
    :SEK => (2,  752, "Swedish Krona"),
    :BRL => (2,  986, "Brazilian Real"),
    :CRC => (2,  188, "Costa Rican Colon"),
    :SVC => (2,  222, "El Salvador Colon"),
    :IRR => (2,  364, "Iranian Rial"),
    :NZD => (2,  554, "New Zealand Dollar"),
    :SRD => (2,  968, "Surinam Dollar"),
    :NIO => (2,  558, "Cordoba Oro"),
    :MKD => (2,  807, "Denar"),
    :KGS => (2,  417, "Som"),
    :DJF => (0,  262, "Djibouti Franc"),
    :UGX => (0,  800, "Uganda Shilling"),
    :VUV => (0,  548, "Vatu"),
    :LKR => (2,  144, "Sri Lanka Rupee"),
    :RSD => (2,  941, "Serbian Dinar"),
    :ILS => (2,  376, "New Israeli Sheqel"),
    :ANG => (2,  532, "Netherlands Antillean Guilder"),
    :LSL => (2,  426, "Loti"),
)

Currency(:KYD)
Currency(:PYG)
Currency(:AWG)
Currency(:LAK)
Currency(:TRY)
Currency(:UYU)
Currency(:NGN)
Currency(:QAR)
Currency(:EUR)
Currency(:TTD)
Currency(:UAH)
Currency(:XPF)
Currency(:JPY)
Currency(:THB)
Currency(:BHD)
Currency(:PEN)
Currency(:SOS)
Currency(:TJS)
Currency(:SHP)
Currency(:AOA)
Currency(:SGD)
Currency(:CHF)
Currency(:IDR)
Currency(:SDG)
Currency(:IQD)
Currency(:EGP)
Currency(:SLL)
Currency(:UZS)
Currency(:MAD)
Currency(:MYR)
Currency(:MMK)
Currency(:DZD)
Currency(:CAD)
Currency(:HKD)
Currency(:MWK)
Currency(:INR)
Currency(:TZS)
Currency(:BTN)
Currency(:LRD)
Currency(:DKK)
Currency(:NAD)
Currency(:PKR)
Currency(:JMD)
Currency(:XOF)
Currency(:COP)
Currency(:HNL)
Currency(:KWD)
Currency(:GHS)
Currency(:BAM)
Currency(:CUC)
Currency(:MXN)
Currency(:TND)
Currency(:MZN)
Currency(:BOB)
Currency(:DOP)
Currency(:ZMW)
Currency(:MVR)
Currency(:BSD)
Currency(:KPW)
Currency(:HUF)
Currency(:BIF)
Currency(:GNF)
Currency(:PAB)
Currency(:VEF)
Currency(:BZD)
Currency(:HTG)
Currency(:SAR)
Currency(:GYD)
Currency(:GMD)
Currency(:ALL)
Currency(:ZAR)
Currency(:PHP)
Currency(:MRO)
Currency(:AZN)
Currency(:AED)
Currency(:ETB)
Currency(:AUD)
Currency(:HRK)
Currency(:VND)
Currency(:MDL)
Currency(:GTQ)
Currency(:GEL)
Currency(:CZK)
Currency(:MOP)
Currency(:PLN)
Currency(:SSP)
Currency(:AFN)
Currency(:SYP)
Currency(:STD)
Currency(:USD)
Currency(:BND)
Currency(:CVE)
Currency(:ARS)
Currency(:CDF)
Currency(:PGK)
Currency(:RUB)
Currency(:MNT)
Currency(:RWF)
Currency(:SZL)
Currency(:GBP)
Currency(:WST)
Currency(:BYN)
Currency(:BGN)
Currency(:JOD)
Currency(:YER)
Currency(:ZWL)
Currency(:LYD)
Currency(:TMT)
Currency(:FJD)
Currency(:KHR)
Currency(:BMD)
Currency(:KZT)
Currency(:XCD)
Currency(:NPR)
Currency(:OMR)
Currency(:CLP)
Currency(:ERN)
Currency(:TOP)
Currency(:CUP)
Currency(:LBP)
Currency(:SCR)
Currency(:NOK)
Currency(:RON)
Currency(:MUR)
Currency(:BDT)
Currency(:MGA)
Currency(:SBD)
Currency(:ISK)
Currency(:GIP)
Currency(:KES)
Currency(:BWP)
Currency(:BBD)
Currency(:KMF)
Currency(:XAF)
Currency(:AMD)
Currency(:CNY)
Currency(:KRW)
Currency(:SEK)
Currency(:BRL)
Currency(:CRC)
Currency(:SVC)
Currency(:IRR)
Currency(:NZD)
Currency(:SRD)
Currency(:NIO)
Currency(:MKD)
Currency(:KGS)
Currency(:DJF)
Currency(:UGX)
Currency(:VUV)
Currency(:LKR)
Currency(:RSD)
Currency(:ILS)
Currency(:ANG)
Currency(:LSL)
