clear all
global FIL341 ///
"C:\Users\Ranst\OneDrive\Desktop\Stata"
use $FIL341/CRSPsample1.dta
br
*Part1 
generate yyyymm = mofd(date)
format yyyymm %tm
sort permno yyyymm
xtset permno yyyymm
generate double ret3m = (1+ret)*(1+l1.ret)*(1+l2.ret) - 1
generate double ret6m = (1+ret3m)*(1+l3.ret3m) - 1 
generate double ret1y = (1+ret6m)*(1+l6.ret6m) - 1
generate double ret3y = (1+ret1y)*(1+l12.ret1y)*(1+l24.ret1y) - 1
summarize ret3y, detail
scalar avg_ret3y = r(mean)
scalar list avg_ret3y
* .43264373

*Part2
copy ///
"http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/F-F_Research_Data_Factors_TXT.zip" ///
"F-F_Research_Data_5_Factors_2x3_TXT.zip", replace
unzipfile "F-F_Research_Data_5_Factors_2x3_TXT.zip", replace
pwd

clear 
import delimited using "F-F_Research_Data_Factors.txt", ///
delimiters(" ", collapse) stringc(_all) varnames(nonames)
br

gen long mdate = real(v1)
gen double mkt_rf = real(v2)
gen double smb = real(v3)
gen double hml = real(v4)
gen double rmw = real(v5)
gen double cma = real(v6)
gen double rf = real(v7)
drop v1-v11
drop if missing(mdate, mkt_rf, smb, hml, rmw, cma, rf)
save $FIL341/ffret3factors.dta, replace
*The first time I ran these I got the means I reported below, but the 2nd time it says no observations were recorded and I can't figure out why
merge 1:m mdate using $FIL341/CRSPsample2.dta, nogen ///
   keep (match using)
     
summarize mkt_rf smb hml rmw cma, detail
* The means I calculated were .2797196, .4061453, .4328803, .5062086 and .4488891