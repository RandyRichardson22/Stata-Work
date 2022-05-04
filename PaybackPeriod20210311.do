/* PaybackPeriod20210311 */

clear all
scalar CF0 = -100
scalar CF1 = 60
scalar CF2 = 70
scalar N = 2

* estimate cumulative cash flows
local No = N
scalar CCF0 = CF0
forvalues i = 1/`No' {
local j = `i' - 1
scalar CCF`i' = CCF`j' + CF`i'
scalar lastCCF = CCF`i'
}

* if last CCF is not negative, estimate payback period
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




* Try with alternative numbers
clear all
scalar CF0 = -150
scalar CF1 = 60
scalar CF2 = 70
scalar CF3 = 80
scalar N = 3

* estimate cumulative cash flows
local No = N
scalar CCF0 = CF0
forvalues i = 1/`No' {
local j = `i' - 1
scalar CCF`i' = CCF`j' + CF`i'
scalar lastCCF = CCF`i'
}

* if last CCF is not negative, estimate payback period
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

scalar retAnnuity = 5000
scalar lastYear = 100
scalar firstRYear = 66
scalar firstWYear = 24
scalar rWork = .05
scalar rRetirement = .03

scalar lastWyear = firstRYear - 1
scalar nRetirement = lastYear - (firstRYear -1)
scalar nWork = lastWyear - (firstWYear -1)

*How much money I need before I retire to afford the retirement I want?
*PV = PMT * (1/(1+R)^n))/rRetirement
scalar savingsBRet = ///
	retAnnuity * (1- (1/(1+rRetirement)^nRetirement))/ rRetirement
scalar list savingsBRet

*How much I need to invest each year while working to affrod this retirement?
*PMT = FV / (((1+R)^N-1)/r)

scalar workAnnuity = savingsBRet / (((1+rWork)^nWork -1) / rWork)
scalar list workAnnuity

