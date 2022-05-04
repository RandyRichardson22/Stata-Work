
*Homework20210412
/*Using CRSP1 file that we created in class*/
clear all
global FIL341 ///
"/Users/aleksa/Desktop/FIL341/Stataquestions"

clear
use $FIL341/CRSPsample1.dta

/*Getting the risk-free rate from Treasury data file and merging with our 
CRSPsample1 file to be able to estimate risk premium*/
generate yyyymm = mofd(date)
format yyyymm %tm
merge m:1 yyyymm using $FIL341/treasury.dta, keepusing(gs30) nogen ///
   keep (match master) 

sort permno yyyymm 
by permno: egen n = count(ret) /*keeping firms with at least 5 return observations*/
keep if n >= 5
/*Estimating risk premium*/
generate double ret_gs30 = ret - gs30/(100*12)
/*1.Estimating semi-variance of risk premiums for each firm with at least 
5 observations of returns*/
bys permno: egen double meanret_gs30 = mean(ret_gs30)
generate double dev = ret_gs30 - meanret_gs30
generate double sq_dev = dev^2
by permno: egen double semivariance = mean(sq_dev) if dev < 0

duplicates drop permno, force /* limiting the sample observations to one per firm*/
summarize semivariance

/*Average semi-variance for this data set is 0.01366*/


/*2.Estimating beta for each firm using risk premiums, excluding firms with 
fewer than 10 observations of returns.*/
clear 
use $FIL341/CRSPsample1.dta
generate yyyymm = mofd(date)
format yyyymm %tm
merge m:1 yyyymm using $FIL341/treasury.dta, keepusing(gs30) nogen ///
   keep (match master) 
sort permno yyyymm 
by permno: egen n = count(ret) /*excluding firms with fewer than 10 return observations*/
drop if n < 10
/*creating risk premiums for firms and the market, and then estimating beta*/
generate double ret_gs30 = ret - gs30/(100*12)
bys permno: egen double meanret_gs30 = mean(ret_gs30)
generate double dev = ret_gs30 - meanret_gs30
generate double vwret_gs30 = vwretd - gs30/(100*12)
by permno: egen double meanvwret_gs30 = mean(vwret_gs30)
generate double devm = vwret_gs30 - meanvwret_gs30
generate double sq_devm = devm^2
by permno: egen double mean_sq_devm = mean(sq_devm)
by permno: generate double variancem = mean_sq_devm
by permno: generate double dev_devm = dev * devm
by permno: egen double correlation = mean(dev_devm)
by permno: gen double beta = correlation / variancem

duplicates drop permno, force /* limiting the sample observations to one per firm*/
summarize beta

/*Average beta for this data set is 0.90386*/
/*3.3 Month Treasury Bill from FRED*/
clear
freduse DTB3
compress /*reducing file size*/
rename *, lower /*making all variables lower case*/
generate int yyyymm = mofd(daten) /* creating yyyymm variable*/
format yyyymm %tm /* formating yyyymm variable*/
duplicates drop yyyymm, force
/*merging dtb3 variable to CRSPsample2 file and creating a new CRSPsample3 file*/
save $FIL341/3mtreasury.dta, replace

clear
use $FIL341/CRSPsample2.dta
merge m:1 yyyymm using $FIL341/3mtreasury.dta, keepusing(dtb3) nogen ///
   keep (match master)
save $FIL341/CRSPsample3.dta, replace
