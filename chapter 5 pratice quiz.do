clear all
*1
scalar Revenue1 = 4000
scalar Revenue2 = 5000
scalar COGS1 = 2500
scalar COGS2 = 3000
scalar Depreciation1 = 500
scalar Depreciation2 = 400
scalar EBIT1 = 1000
scalar EBIT2 = 1600
scalar investment0 = 3000
scalar taxRate = .14
scalar WCrate = .06
scalar increaseWC1 = (Revenue2 - Revenue1) * WCrate
scalar list increaseWC1
scalar CF1 = EBIT1 * (1 - taxRate) + Depreciation1 - increaseWC1
scalar list CF1

*2
scalar liquidationV = investment0 - Depreciation1 - Depreciation2
scalar list liquidationV

*3
clear all
scalar CF0 = -25
scalar CF1 = 13
scalar CF2 = 15
scalar CF3 = 16
scalar N = 3
scalar discountRate = .09
scalar NPV = CF0
local No = N
forvalues i = 1/`No' {
scalar NPV = NPV + CF`i'/(1 + discountRate)^`i'
}
scalar list NPV
 
 *4
clear all
scalar CF0 = -42
scalar CF1 = 14
scalar CF2 = 13
scalar CF3 = 13
scalar CF4 = 15
scalar CF5 = 16
scalar discountRate = 0.11
scalar N = 5

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


