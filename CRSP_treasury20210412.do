/* CRSP20210330 */
/* CRSP database has returns and prices for stocks, daily and monthly data; 
here we are looking at monthly data; I already changed all names to lowercase */

clear all
global FIL341 ///
"C:\Users\Ranst\OneDrive\Desktop\Stata"

clear
freduse GS30
/* U.S. Bureau of Economic Analysis, 30-Year Treasury Constant Maturity Rate,
retrieved from FRED, Federal Reserve Bank of St. Louis; 
https://fred.stlouisfed.org/series/GS30    , April 12, 2021.   */
br
compress   // reduces file size when that can be done without losing information
help int   // check all numeric types
rename *, lower    // all variable names converted to lower case 

generate int datenx = daten
generate int yyyymmn = mofd(daten)

generate int yyyymm = mofd(daten)
format yyyymm %tm
help format

generate int yearn = year(daten)
generate byte monthn = month(daten)
generate byte dayn = day(daten)

* the following does not work:
*generate byte yearym = year(yyyymm)
*dropyearym
generate byte yearym = year(yyyymm)

drop yearym

save $FIL341/treasury.dta, replace


clear 
use $FIL341/CRSPsample1.dta
br
generate yyyymm = mofd(date)
format yyyymm %tm

* add 30-year T-bond rates from $FIL341/treasury.dta to this file
merge m:1 yyyymm using $FIL341/treasury.dta, keepusing(gs30) nogen ///
   keep (match master) 
help merge

* Estimate risk premium for stocks and CRSP value-weighted index
generate double ret_gs30 = ret - gs30/(100*12)
generate double vwretd_gs30 = vwretd - gs30/(100*12)

/* let Stata know that we have panel data with permno and yyyymm uniquely
identifying each observation
this allows us to use lead and lag values */
sort permno yyyymm
xtset permno yyyymm
/* panel data: many firms, a number of months for each firm 
(includes time series (one firm for a number of months) 
and crossectional data (many firms for one month)) */

generate double fret3m = (1+ret)*(1+f1.ret)*(1+f2.ret) - 1
generate double fret6m = (1+fret3m)*(1+f3.fret3m) - 1
generate double fret1y = (1+fret6m)*(1+f6.fret6m) - 1
generate double fret2y = (1+fret1y)*(1+f12.fret1y) - 1
generate double fret3y = (1+fret1y)*(1+f12.fret1y)*(1+f24.fret1y) - 1

generate double ret3m = (1+ret)*(1+l1.ret)*(1+l2.ret) - 1
generate double ret6m = (1+ret3m)*(1+l3.ret3m) - 1 
generate double ret1y = (1+ret6m)*(1+l6.ret6m) - 1 

generate long mdate = year(date) * 100 + month(date)

save $FIL341/CRSPsample2.dta, replace

/*************            Fama & French 3-factor model            *************/
/*********      similar to the CAPM--to estimate required return      *********/
/*************         3 Factors (mkt_rf, smb, hml, & rf)         *************/
copy ///
"http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/F-F_Research_Data_Factors_TXT.zip" ///
"F-F_Research_Data_Factors_TXT.zip", replace
unzipfile "F-F_Research_Data_Factors_TXT.zip", replace
pwd

clear 
import delimited using "F-F_Research_Data_Factors.txt", ///
delimiters(" ", collapse) stringc(_all) varnames(nonames)
br
gen long mdate = real(v1)
gen double mkt_rf = real(v2)
gen double smb = real(v3)
gen double hml = real(v4)
gen double rf = real(v5)
drop v1-v11
drop if missing(mdate)
* save $FIL341/ffret3factors.dta, replace



