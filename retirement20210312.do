
clear all
/* All calculations in todays dollars and using real interest rates; 
assume that all cash flows are at the end of year */
scalar retAnnuity = 50000
scalar lastYear = 100
scalar firstRYear = 66
scalar firstWYear = 24
scalar rWork = 0.05
scalar rRetirement = 0.03



scalar lastWYear = firstRYear - 1
scalar nRetirement = lastYear - (firstRYear - 1)
scalar nWork = lastWYear - (firstWYear - 1)



* How much money I need before I retire to afford the retirement I want?
* PV = PMT * (1 - (1/(1+r)^n))/r

scalar savingsBRet = ///
   retAnnuity * (1 - (1/(1 + rRetirement)^nRetirement))/ rRetirement
scalar list savingsBRet
 
 
 
* How much I need to invest each year while working to afford this retirement?
* PMT = FV / (((1+r)^n - 1)/r)
   
scalar workAnnuity = savingsBRet / (((1 + rWork)^nWork - 1) / rWork)
scalar list workAnnuity




foreach i in 0.01 0.04 0.05 0.06 0.07 {
scalar workAnnuity = savingsBRet / (((1 + `i')^nWork - 1) / `i')
scalar list workAnnuity
}
