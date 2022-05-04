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
clear all
scalar CF0 = -35
scalar CF1 = 13
scalar CF2 = 15
scalar CF3 = 16
scalar N = 3

local No = N
scalar CCF0 = CF0
forvalues i = 1/`No' {
local j = `i' - 1
scalar CCF`i' = CCF`j' + CF`i'
scalar lastCCF = CCF`i'
}

if lastCCF >= 0 {
local i = 0
local dif = CCF0
while `dif' < 0 {
local i = `i' + 1
local dif = CCF`i'
}
local j = `i' - 1
scalar payback = `j' + (abs(CCF`j')/CF`i')
}
scalar list payback

*3
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

*4
scalar valueFirm = 14791000000
scalar BVdebt = 6600000000
scalar price = 30
scalar shares = 300000000

scalar valueFirmEq = valueFirm - BVdebt
scalar list valueFirmEq
scalar valueShare = valueFirmEq / shares
scalar list valueShare
scalar overpricing = (price - valueShare) / valueShare
scalar list overpricing

*5
= 11k

*6
clear all
use ${FIL341}/Comp20.dta
*br

**Drop observations with missing ceq values.**
drop if missing(ppent)

**Drop observations when ceq is zero or negative.**
drop if ceq == 0 
drop if ceq < 0 


**Drop observations with negative sale values.**
drop if sale < 0
summarize at sale, detail


generate double dlc_dltt_at = (dlc+dltt)/at
ratio dltt_at
summarize dlc_dltt_at, detail
scalar p1dlc_dltt_at = r(p1)
scalar p99dlc_dltt_at = r(p99)
generate double wdlc_dltt_at = dlc_dltt_at
replace wdlc_dltt_at = p1dlc_dltt_at if dlc_dltt_at < p1dlc_dltt_at
replace wdlc_dltt_at = p99dlc_dltt_at if dlc_dltt_at < p99dlc_dltt_at ///
& !missing(dlc_dltt_at)

clear

generate double ebit_at = (dlc+ebit)/at
summarize ebit_at, detail
scalar p1ebit_at = r(p1)
scalar p99ebit_at = r(p99)
generate double webit_at = ebit_at
replace webit_at = p1ebit_at if ebit_at < p1ebit_at
replace webit_at = p99ebit_at if ebit_at > p99ebit_at ///
   & !missing(ebit_at)

generate double ppent_at = (dlc+ppent)/at
summarize ppent_at, detail
scalar p1ppent_at = r(p1)
scalar p99ppent_at = r(p99)
generate double wppent_at = ppent_at
replace wppent_at = p1ppent_at if ppent_at < p1ppent_at
replace wppent_at = p99ppent_at if ppent_at > p99ppent_at ///
   & !missing(ppent_at)
   
generate double logSale = (dlc+sale)/at
summarize logSale, detail
scalar p1logSale = r(p1)
scalar p99logSale = r(p99)
generate double wlogSale = logSale
replace wlogSale = p1logSale if logSale < p1logSale
replace wlogSale = p99logSale if logSale > p99logSale ///
   & !missing(logSale)

generate double logAt = (dlc+at)/at
summarize logAt, detail
scalar p1logAt = r(p1)
scalar p99logAt = r(p99)
generate double wlogAt = logAt
   
reg dlc_dltt_at logAt ebit_at logSale ppent_at,cluster(gvkey)
=.57

