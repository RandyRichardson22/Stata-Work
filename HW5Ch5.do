clear all
scalar Revenue1 = 4000
scalar Revenue2 = 5000
scalar COGS1 = 2500
scalar COGS2 = 3000
scalar Depreciation1 = 500
scalar Depreciation2 = 400
scalar EBIT1 = 1000
scalar EBIT2 = 1600
scalar investment0 = 3000
scalar WCrate = .06
scalar taxRate = .14

*1
scalar increaseWC2 = (0 - Revenue2) * WCrate
scalar liquidationV = investment0 - Depreciation1 - Depreciation2
scalar CF2 = EBIT2 * (1 - taxRate) + Depreciation2 - increaseWC2 + liquidationV
scalar list CF2


*2
scalar revenue1 = 4000
scalar WCrate = 0.06
scalar investment0 = 3000
scalar WCrate = .14
scalar COGS1 = 2500
scalar COGS2 = 3000
scalar EBIT1 = 1000
scalar increaseWC0 = revenue1 * WCrate
scalar CF0 = investment0 + increaseWC0 
scalar list CF0

	answer = 3240



*3
clear all
scalar CF0 = -25
scalar CF1 = 13
scalar CF2 = 0
scalar CF3 = 15
scalar CF4 = 16
scalar discountRate = .10
scalar N = 4
scalar NPV = CF0
local No = N
forvalues i = 1/`No' {
scalar NPV = NPV + CF`i'/(1 + discountRate)^`i'
}
scalar list NPV

*4
clear all
scalar CF0 = -17
scalar CF1 = 14
scalar CF2 = 13
scalar CF3 = 12
scalar discountRate = 0.11
scalar N = 3

scalar NPV = CF0
local No = N
forvalues i = 1/`No' {
scalar NPV = NPV + CF`i'/(1 + discountRate)^`i'
}
scalar list NPV

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
