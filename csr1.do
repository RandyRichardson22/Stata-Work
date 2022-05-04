clear all
global FIL341 ///
"C:\Users\Ranst\OneDrive\Desktop\Stata"


clear 
use $FIL341/CRSPsample.dta
drop if missing(prc)
drop if prc < 2 
summarize prc ret retx vwretd, detail
duplicates report permno date 
duplicates report permno date ret prc retx vwretd
duplicates drop permno date, force
save $FIL341/CRSPsample1.dta, replace


help egen
bys permno: egen double meanret = mean(ret)
*1 =  .0590945 
/* Estimate variance and standard deviation */

generate double dev = ret - meanret
generate double sq_dev = dev^2

by permno: egen double mean_sq_dev = mean(sq_dev)

by permno: generate double variance = mean_sq_dev
by permno: generate double st_dev = variance^(1/2)
by permno: egen n = count(st_dev)
keep if n >=5
by permno: egen double mean_st_dev = mean(st_dev)
summarize mean_st_dev st_dev
*2 the mean_semivariances 's mean and standard deviation is  .0119164.0106419 
/* estimate semivariance (includes only negative deviations) */

by permno: egen double Semivariance = mean(sq_dev) if dev < 0
by permno: egen r = count(Semivariance)
keep if r >=5
by permno: egen double mean_Semivariance = mean(Semivariance)
summarize mean_Semivariance Semivariance

*3 =.935668 

by permno: egen double meanvwretd = mean(vwretd)

generate double devm = vwretd - meanvwretd
generate double sq_devm = devm^2

by permno: egen double mean_sq_devm = mean(sq_devm)
by permno: generate double variancem = mean_sq_devm 

by permno: generate double dev_devm = dev * devm
by permno: egen double correlation = mean(dev_devm)
by permno: gen double beta = correlation / variancem
summarize beta, detail
duplicates drop permno, force
summarize beta, detail
