clear
*1
scalar faceValue = 1000
scalar N = 20
scalar couponR = 0.043
scalar price = 986
scalar Beta = 0.6
scalar Tax = .22
scalar RPrate = .052
scalar couponP = faceValue * couponR

if price == faceValue { 
scalar EyieldTM = couponR
}

if price < faceValue {
scalar EyieldTM = couponR
local dif = faceValue - price
while `dif' > 0 {
scalar EyieldTM = EyieldTM + 0.00001

scalar PVbond_N = faceValue/(1 + EyieldTM)^N
local No = N

forvalues i = 1/`No' {
scalar PVbond_N = PVbond_N + couponP/(1 + EyieldTM)^`i'
}

local dif = PVbond_N - price
}
}

if price > /* changed sign */ faceValue {
scalar EyieldTM = couponR
local dif = faceValue - price
while `dif' < 0 /* changed sign */ {
scalar EyieldTM = EyieldTM - /* changed sign */ 0.00001

scalar PVbond_N = faceValue/(1 + EyieldTM)^N
local No = N

forvalues i = 1/`No' {
scalar PVbond_N = PVbond_N + couponP/(1 + EyieldTM)^`i'
}

local dif = PVbond_N - price
}
}
scalar list EyieldTM

*2
scalar MVdebt = (5000000 * PVbond_N) 
scalar list MVdebt

*3
scalar Oshares = 200000000
scalar Sprice = 50 
scalar MVequity = Oshares * Sprice
scalar list MVequity

*4

*5
scalar RFrrate = 0.026
scalar beta = .06
 scalar RPrate = 0.052

 scalar costEquity = RFrrate + beta * RPrate

. scalar list costEquity

*6

*7

*8

