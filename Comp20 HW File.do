pwd
global FIL341 ///
"C:\Users\Ranst\OneDrive\Desktop\Stata"

clear 
use ${FIL341}/Comp20.dta
br

summarize at ceq dcvt dd1 dd2 dlc dltt mkvalt ebit ppent ///
pstk sale, detail

drop if ceq <= 0
drop if ceq ==0
drop if sale < sale

generate double dlc_dltt_at = (dlc+dltt)/at
br
label variable dlc_dltt_at "Highest Precision" 
summarize dlc_dltt_at, detail
help summarize
scalar p50dlc_dltt_at = r(p50)
scalar list p50dlc_dltt_at

generate double MVat = at - ceq + mkvalt
generate double dlc_dltt_MVat = (dlc+dltt)/MVat
generate double ebit_at = ebit / at
generate double logAt = log(at+1)
generate double dlc_dltt_ppent= (dlc+dltt)/ppent
summarize dlc_dltt_MVat, detail
summarize dlc_dltt_ppent,detail

reg dlc_dltt_at logAt ebit_at
reg dlc_dltt_ppent logPpent ebit_ppent,cluster(sale,ppent)
