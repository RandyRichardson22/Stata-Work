/* CW_BondsDebt20210203 */
* FIL 341

/* select commands (text) you want to run and press:
on PC: control-D
on Mac: command-shift-D */

clear all
scalar faceValue = 1000
/* this is typical for corporate bonds; if the face value is not give, assume
$1000 */

scalar N = 2
scalar couponR = 0.042
scalar yieldTM = 0.051
/* it can be called the current interest rate on similar risk bonds or
required rate of return on similar risk investments */

/********************        Estimate Bond Price within short way : 1-4yrs lines 22-28          *********************/

* Present value of the face value
scalar PVofFaceV = faceValue/(1 + yieldTM)^N

* Present value of all coupon payments
scalar couponP = faceValue * couponR
scalar PVofCouponP = couponP/(1 + yieldTM)^1 + couponP/(1 + yieldTM)^2
scalar PVbond = PVofFaceV + PVofCouponP
scalar list PVbond

* alternative way to estimate PVofCouponP; estimates for any N

scalar PVbond_N = PVofFaceV
local No = N
/* local is similar to scalar, but it works here while scalar does not ;
Stata forgets quickly what is created as local 
(scalar it remembers until the memory is cleared)   */
forvalues i = 1/`No' {
scalar PVbond_N = PVbond_N + couponP/(1 + yieldTM)^`i'
}
scalar list PVbond_N

/********************      Estimate Yield to Maturity      ********************/

/* The yield to maturity on a bond is the discount rate that makes the present 
value of all cash flows equal to the price of that bond */
clear all
scalar faceValue = 1000
scalar N = 2
scalar couponR = 0.042
scalar price = 1000
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




