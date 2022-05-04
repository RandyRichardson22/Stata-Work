* CW_Compustat_20210221

 global data_st "/Users/macbook2019/Documents/Data_Programs/DataStata"
/* this statement creates a global macro; differently from local macros,
Stata remembers global macros until they are deleted or Stata is closed;
Whenever I will write $data_st or ${data_st}, Stata will substitute the 
text between quotation marks */
pwd
global FIL341 ///
"C:\Users\Ranst\OneDrive\Desktop\Stata"

clear
use ${FIL341}/Comp20.dta
br

summarize at ceq dcvt dd1 dd2 dlc dltt mkvalt ebit ppent ///
pstk sale, detail

drop if at == 0

generate double dlc_dltt_at = (dlc+dltt)/at
br
label variable dlc_dltt_at "Book Leverage"
summarize dlc_dltt_at, detail
help summarize
scalar p50dlc_dltt_at = r(p50)
scalar list p50dlc_dltt_at

generate double MVat = at - ceq + mkvalt
generate double dlc_dltt_MVat = (dlc+dltt)/MVat
generate double ebit_at = ebit / at
generate double logAt = log(at+1)

summarize dlc_dltt_MVat, detail

reg dlc_dltt_at logAt ebit_at
reg dlc_dltt_at logAt ebit_at, cluster(gvkey)



