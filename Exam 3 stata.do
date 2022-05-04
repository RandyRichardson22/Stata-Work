*1.
clear all
global FIL341 ///
"C:\Users\Ranst\OneDrive\Desktop\Stata"


clear 
use $FIL341/CRSPsample.dta

duplicates report permno date 
duplicates report permno date
duplicates drop permno date, force

drop ncusip, comnam
drop if missing(prc)
drop if prc < 2

scalar div = ret - retx
scalar list div

foreach x of global variables {
summarize `x', detail
scalar p5`x' = r(p5)
scalar p95`x' = r(p95)
generate double w`x' = `x'
replace w`x' = p5`x' if `x' < p5`x'
replace w`x' = p95`x' if `x' > p95`x' ///
   & !missing(`x')
}

*2
merge m:1 yyyymm using $FIL341/CRSPsample, keepusing(gs30) nogen ///
   keep (match master) 

duplicates report permno date 
duplicates report permno date
duplicates drop permno date, force
generate int datenx = daten
generate yyyymm = mofd(date)
format yyyymm %tm
*Was very confused on what to do.
*3
by permno: egen n = count(price)
keep if n >= 5
bys permno: egen double meanprice = mean(price)
generate double dev = price - meanprice
generate double sq_dev = dev^2
by permno: egen double mean_sq_dev = mean(sq_dev)
by permno: generate double variance = mean_sq_dev 
by permno: generate double st_dev = variance^(1/2)
summarize st_dev
scalar avg_st_dev = r(mean)
scalar list avg_st_dev
by permno: egen double semivariance = mean(sq_dev) if dev < 0
summarize semivariance
scalar avg_semivariance = r(mean)
scalar list avg_semivariance

