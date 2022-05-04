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

generate yyyymm = mofd(date)
format yyyymm %tm

sort permno yyyymm
xtset permno yyyymm

generate double fret3m = (1+ret)*(1+f1.ret)*(1+f2.ret) - 1

generate double ret3m = (1+ret)*(1+l1.ret)*(1+l2.ret) - 1
generate double ret6m = (1+ret3m)*(1+l3.ret3m) - 1 
generate double ret1y = (1+ret6m)*(1+l6.ret6m) - 1 

