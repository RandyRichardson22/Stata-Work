* Chapter 5 homeowork
clear all
scalar CF0 = -100
scalar CF1 = 60
scalar CF2 = 70
scalar discountRate = .12
scalar N = 2

*NPV

scalar NPV  = CF0
local No = N
forvalues i = 1/`No' {
scalar NPV = NPV + CF`i' /(1 + discountRate)^`i'
}
scalar list NPV

*IRR

if NPV == 0 { 
scalar IRR = discountRate
}

if NPV > 0 {
scalar IRR = discountRate
local eNPV = NPV
while `eNPV' > 0 {
scalar IRR = IRR + 0.00001
local No = N
scalar eNPV =CF0
forvalues i = 1/`No' {
scalar eNPV = eNPV + CF`i'/(1 + IRR)^`i'
}

local eNPV = eNPV
}
}

if NPV < 0 {
scalar IRR = discountRate
local eNPV = NPV
while `eNPV' >= 0 {
scalar IRR = IRR - 0.00001
local No = N
scalar eNPV =CF0
forvalues i = 1/`No' {
scalar eNPV = eNPV + CF`i'/(1 + IRR)^`i'
}

local eNPV = eNPV
}
}
scalar list IRR