/* Exam1Stata20210214 */
* FIL 341

/* select commands (text) you want to run and press:
on PC: control-D
on Mac: command-shift-D */


clear all
scalar faceValue = 1000
/* if the face value is not given for corporate bonds, assume $1000 */
scalar N = 20
scalar couponR = 0.043
scalar BVdebt   = 30000000
scalar BVequity = 40000000

scalar price = 986

*1. Yield
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

*2. Market value of debt

scalar NofBonds = BVdebt / faceValue
scalar MVdebt = price * NofBonds
scalar list MVdebt

*3. Market value of equity      

scalar NofShares = 1200000
scalar sharePrice = 50
scalar MVequity = NofShares * sharePrice
scalar list MVequity

*4. Market Leverage as Debt/(Debt+Equity)      

scalar MVleverage = MVdebt / (MVdebt + MVequity)
scalar list MVleverage

*5. Cost of Equity               

scalar RFrate = 0.026
scalar beta = 0.6
scalar RPequity = 0.052
scalar costEquity = RFrate + beta * RPequity
scalar list costEquity

*6. After-tax Cost of Debt & WACC          

scalar tax = .22
scalar ATcostDebt = EyieldTM * (1 - tax)
scalar list ATcostDebt
scalar WACC = (MVequity * costEquity + MVdebt * ATcostDebt)    ///
   / (MVequity + MVdebt)
scalar list WACC

*7. New beta
scalar unlBeta = beta / (1 + (1 - tax) * (MVdebt / MVequity))
scalar newMVdebt =   MVdebt -   5000000
scalar newMVequity = MVequity + 5000000
scalar newBeta = unlBeta * (1 + (1 - tax) * (newMVdebt / newMVequity))
scalar list newBeta

*8. Merged firm beta
scalar betaOC = 1.2
scalar MVassetsOC = 90000000
scalar MVassets = MVdebt + MVequity
scalar mergedBeta = (MVassets * newBeta + MVassetsOC * betaOC)     ///
   / (MVassets + MVassetsOC)
scalar list mergedBeta
