/* CRSP20210330 */
/* CRSP database has returns and prices for stocks, daily and monthly data; 
here we are looking at monthly data; I already changed all names to lowercase */

clear all
global FIL341 ///
"C:\Users\Ranst\OneDrive\Desktop\Stata"

/*
global data_st "~/Documents/Data_Programs/DataStata"	
clear 
use $data_st/crsp_msf.dta
generate year = year(date)
keep if year > 1999
keep if !missing(prc) & !missing(ret)
keep permno ncusip comnam date prc ret retx vwretd
keep if permno > 39999 & permno < 60000
save $FIL341/CRSPsample.dta, replace
*/

clear 
use $FIL341/CRSPsample.dta
summarize prc ret retx vwretd, detail
generate double price = abs(prc)


duplicates report permno date 
duplicates report permno date ret prc retx vwretd
duplicates drop permno date, force

save $FIL341/CRSPsample1.dta, replace


/* Estimate mean monthly return for each firm (permno) */

help egen
bys permno: egen double meanret = mean(ret)

/* Estimate variance and standard deviation */

generate double dev = ret - meanret
generate double sq_dev = dev^2

by permno: egen double mean_sq_dev = mean(sq_dev)

by permno: egen n = count(mean_sq_dev)
keep if n > 11

by permno: generate double variance = mean_sq_dev 
* by permno: generate double variance_s = mean_sq_dev * n /(n-1)
by permno: generate double st_dev = variance^(1/2)

/* estimate semivariance (includes only negative deviations) */

by permno: egen double semivariance = mean(sq_dev) if dev < 0

summarize variance semivariance

/* estimate covariance between firm and market return */

by permno: egen double meanvwretd = mean(vwretd)

generate double devm = vwretd - meanvwretd
generate double sq_devm = devm^2

by permno: egen double mean_sq_devm = mean(sq_devm)
by permno: generate double variancem = mean_sq_devm 

by permno: generate double dev_devm = dev * devm
by permno: egen double correlation = mean(dev_devm)

/* Estimate beta for each firm (correlation with market divided by market
variance */
by permno: gen double beta = correlation / variancem

summarize beta, detail

duplicates drop permno, force
summarize beta, detail


clear 
use $FIL341/CRSPsample1.dta

br
generate yyyymm = mofd(date)
format yyyymm %tm
sort permno yyyymm
xtset permno yyyymm


generate double fret3m = (1+ret)*(1+f1.ret)*(1+f2.ret) - 1

generate double ret3m = (1+ret)*(1+l1.ret)*(1+l2.ret) - 1
generate double ret6m = (1+ret3m)*(1+l3.ret3m) - 1 
generate double ret1y = (1+ret6m)*(1+l6.ret6m) - 1 




