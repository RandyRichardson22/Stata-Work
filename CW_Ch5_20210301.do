/* CW Chapter 5 */

clear all
scalar CF0 = -100
scalar CF1 = 60
scalar CF2 = 70
scalar discountRate = .12
scalar N = 2

* NPV

scalar NPV = CF0
local No = N
forvalues i = 1/`No' {
scalar NPV = NPV + CF`i'/(1 + discountRate)^`i'
}
scalar list NPV

* IRR


if NPV == 0 { 
scalar IRR = discountRate
}

if NPV > 0 {
scalar IRR = discountRate
local eNPV = NPV
while `eNPV' > 0 {
scalar IRR = IRR + 0.00001
local No = N
scalar eNPV = CF0
forvalues i = 1/`No' {
scalar eNPV = eNPV + CF`i'/(1 + IRR)^`i'
}
local eNPV = eNPV
}
}

if NPV < 0 {
scalar IRR = discountRate
local eNPV = NPV
while `eNPV' < 0 {
scalar IRR = IRR - 0.00001
local No = N
scalar eNPV = CF0
forvalues i = 1/`No' {
scalar eNPV = eNPV + CF`i'/(1 + IRR)^`i'
}
local eNPV = eNPV
}
}

scalar list IRR


/* CW_CH5 */

clear all

scalar EBIT1 = 2000
scalar EBIT2 = 3600
scalar EBIT3 = 5200
scalar EBIT4 = 6800
scalar taxRate = .4
scalar depreciation1 = 4000
scalar depreciation2 = 3000
scalar depreciation3 = 2000
scalar depreciation4 = 1000
scalar investment0 = 15000
scalar investment2 = 2000
scalar revenue1 = 10000
scalar revenue2 = 11000
scalar revenue3 = 12000
scalar revenue4 = 13000
scalar WCrate = 0.1
scalar increaseWC0 = revenue1 * WCrate
scalar increaseWC1 = (revenue2 - revenue1) * WCrate
scalar increaseWC2 = (revenue3 - revenue2) * WCrate
scalar increaseWC3 = (revenue4 - revenue3) * WCrate
scalar increaseWC4 = (0 - revenue4) * WCrate
scalar liquidationV = investment0 + investment2 - depreciation1 ///
    - depreciation2 - depreciation3 - depreciation4

scalar CF1 = EBIT1 * (1 - taxRate) + depreciation1 - increaseWC1
scalar CF2 = EBIT2 * (1 - taxRate) + depreciation2 - investment2  - increaseWC2
scalar CF3 = EBIT3 * (1 - taxRate) + depreciation3 - increaseWC3
scalar CF4 = EBIT4 * (1 - taxRate) + depreciation4 - increaseWC4 + liquidationV


/******************************************************************************/
/********** I changed the signs to negative on this line so it would **********/
/*********** work without modifications with NPV and IRR calculations *********/
/******************************************************************************/
scalar CF0 = -investment0 - increaseWC0

forvalues i = 0/4 {
scalar list CF`i'
}





