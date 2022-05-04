clear all
/* All calculations in todays dollars and using real interest rates; 
assume that all cash flows are at the end of year */
scalar retAnnuity = 50000
scalar lastYear = 100
scalar firstRYear = 66
scalar firstWYear = 24
scalar rWork = 0.06
scalar rRetirement = 0.03

*1, Start saving 10 years later

clear 
/* All calculations in todays dollars and using real interest rates; 
assume that all cash flows are at the end of year */
scalar retAnnuity = 50000
scalar lastYear = 100
scalar firstRYear = 66
scalar firstWYear = 34
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
*2, Work 10 years later
clear
scalar retAnnuity = 50000
scalar lastYear = 100
scalar firstRYear = 76
scalar firstWYear = 24
scalar rWork = 0.05
scalar rRetirement = 0.03
scalar lastWYear = firstRYear - 1
scalar nRetirement = lastYear - (firstRYear - 1)
scalar nWork = lastWYear - (firstWYear - 1)
scalar savingsBRet = ///
   retAnnuity * (1 - (1/(1 + rRetirement)^nRetirement))/ rRetirement
scalar list savingsBRet
scalar workAnnuity = savingsBRet / (((1 + rWork)^nWork - 1) / rWork)
scalar list workAnnuity
foreach i in 0.01 0.04 0.05 0.06 0.07 {
scalar workAnnuity = savingsBRet / (((1 + `i')^nWork - 1) / `i')
scalar list workAnnuity

*3, Add 1% to the rate of return while working.

clear
scalar retAnnuity = 50000
scalar lastYear = 100
scalar firstRYear = 66
scalar firstWYear = 24
scalar rWork = 0.06
scalar rRetirement = 0.03
scalar lastWYear = firstRYear - 1
scalar nRetirement = lastYear - (firstRYear - 1)
scalar nWork = lastWYear - (firstWYear - 1)
scalar savingsBRet = ///
   retAnnuity * (1 - (1/(1 + rRetirement)^nRetirement))/ rRetirement
scalar list savingsBRet

scalar workAnnuity = savingsBRet / (((1 + rWork)^nWork - 1) / rWork)
scalar list workAnnuity

foreach i in 0.01 0.04 0.05 0.06 0.07 {
scalar workAnnuity = savingsBRet / (((1 + `i')^nWork - 1) / `i')
scalar list workAnnuity
* After comparing the three variations, the savingsbRet is one of the variables that changes along with the workAnnuity. With all of the variations having the same foreach values we can get similar numbers  for some variations. Like the first and third variations, in the first one we changed our first working year to 34 and in third variation all we did was change the rate of return while working to 0.06. While the second variation doesn't affect the savingsBRet number.