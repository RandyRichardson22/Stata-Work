*CW Comp

global FIL341 ///
"/C:\Users\Ranst\OneDrive\Desktop\Stata"

clear
use $FIL341/Comp20.dta,

generate double dlc_dltt_at = (dlc+dltt)/at
summarize dlc_dltt_at, detail
* help summarize
scalar p50dlc_dltt_at = r(p1)
scalar p50dlc_dltt_at = r(p99)
generate double logAt = log(at+1)
generate double wdlc_dltt_at = dlc_dltt_at
help replace
replace wdlc_dltt_a = p1dlc_dltt_at if dlc_dltt_at < p1dlc_dltt_at
replace wdlc_dltt_a = p99dlc_dltt_at if dlc_dltt_at > p1dlc_dltt_at ///
 & !missing(dlc_dltt_at)
 * Stata treats missing observations as very large numbers