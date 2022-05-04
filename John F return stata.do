clear all
global FIL341 ///
"C:\FIL341"

clear
use ${FIL341}/CRSPsample1.dta

*1
generate yyyymm = mofd(date)
format yyyymm %tm
merge m:1 yyyymm using $FIL341/treasury.dta, keepusing(gs30) nogen ///
   keep (match master) 

generate double ret_gs30 = ret - gs30/(100*12)
generate double vwretd_gs30 = vwretd - gs30/(100*12)

sort permno yyyymm
xtset permno yyyymm

generate double fret3m = (1+ret)*(1+f1.ret)*(1+f2.ret) - 1
generate double fSum3m = ret + f1.ret + f2.ret
summarize fret3m fSum3m, detail

generate double fret6m = (1+fret3m)*(1+f3.fret3m) - 1
generate double fret1y = (1+fret6m)*(1+f6.fret6m) - 1
generate double fret2y = (1+fret1y)*(1+f12.fret1y) - 1
generate double fret3y = (1+fret1y)*(1+f12.fret1y)*(1+f24.fret1y) - 1

bys permno: egen double meanfret3y = mean(fret3y)
summarize meanfret3y
* .432924 


*2

copy ///
"http://mba.tuck.dartmouth.edu/pages/faculty/ken.french/ftp/F-F_Research_Data_Factors_TXT.zip" ///
"F-F_Research_Data_5_Factors_2x3_TXT.zip", replace
unzipfile "F-F_Research_Data_5_Factors_2x3_TXT.zip", replace
pwd

clear 
import delimited using "F-F_Research_Data_Factors.txt", ///
delimiters(" ", collapse) stringc(_all) varnames(nonames)
*br

gen mdate = real(v1)
gen double mkt_rp = real(v2)
gen double smb = real(v3)
gen double hml = real(v4)
gen double rf = real(v5)
drop v1-v11
drop if missing(mdate,mkt_rp,smb,hml,rf)
save $FIL341/ffret3factors.dta, replace

merge 1:m mdate using $FIL341/CRSPsample2.dta, keepusing(mdate)
   
*ran into trouple here
generate double M_mkt_rp = mean(mkt_rp)
generate double M_smb = mean(smb)
generate double M_hml = mean(hml)
generate double M_rf = mean(rf)

Summerize M_hml,M_mkt_rp,M_rf,M_smb