clear all
scalar retAnnuity = 5000
scalar lastYear = 100
scalar firstRYear = 66
scalar firstWYear = 24
scalar rWork = 0.05
scalar rRetirement = 0.03

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