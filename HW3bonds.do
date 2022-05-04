clear all
*1
scalar faceValue = 1000
scalar N = 20
scalar couponR = 0.034
scalar price = 873
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
clear all 
scalar faceValue = 1000
scalar N = 2
scalar couponR = 0.033
scalar price = 980
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

*3
scalar faceValue = 1000
scalar N = 100
scalar couponR = 0.04
scalar yieldTM = 0.032
scalar PVofFaceV = faceValue/(1 + yieldTM)^N
scalar couponP = faceValue * couponR
scalar PVbond_N = PVofFaceV
local No = N
forvalues i = 1/`No' {
scalar PVbond_N = PVbond_N + couponP/(1 + yieldTM)^`i'
}
scalar list PVbond_N

*4
scalar faceValue = 1000
scalar N = 5
scalar couponR = 0.063
scalar yieldTM = 0.08
scalar PVofFaceV = faceValue/(1 + yieldTM)^N
scalar couponP = faceValue * couponR
scalar PVbond_N = PVofFaceV
local No = N
forvalues i = 1/`No' {
scalar PVbond_N = PVbond_N + couponP/(1 + yieldTM)^`i'
}
scalar list PVbond_N
