
*CW_CH5
clear all
scalar EBIT1 = 2000
scalar EBIT2 = 3600
scalar EBIT3 = 5200
scalar EBIT4 = 6800
scalar taxrate = .4
scalar Depreciation1 = 4000
scalar Depreciation2 = 3000
scalar Depreciation3 = 2000
scalar Depreciation4 = 1000
scalar investment0 = 15000
scalar investment2 = 2000
scalar revenue1 = 10000
scalar revenue2 = 11000
scalar revenue3 = 12000
scalar revenue4 = 13000
scalar WCrate = .1
scalar increaseWCrate0 = WCrate * revenue1
scalar increaseWCrate1 = (revenue2- revenue1) * WCrate
scalar increaseWCrate2 = (revenue3- revenue2) * WCrate
scalar increaseWCrate3 = (revenue4- revenue3) * WCrate
scalar increaseWCrate4 = (0 - revenue4) * WCrate
scalar liquidationV = investment0 + investment2 - Depreciation1 - Depreciation2 - Depreciation3 - Depreciation4

scalar CF1 = EBIT1 * (1- taxrate) + Depreciation1 - increaseWCrate1
scalar CF2 = EBIT2 * (1- taxrate) + Depreciation2 - investment2 - increaseWCrate2
scalar CF3 = EBIT3 * (1- taxrate) + Depreciation3 - increaseWCrate3
scalar CF4 = EBIT4 * (1- taxrate) + Depreciation4 - increaseWCrate4 + liquidationV

scalar CF0 = investment0 + increaseWCrate0
forvalues i = 0/4 {
 scalar list CF`i'
}