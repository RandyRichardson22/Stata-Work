global FIL341 ///
"C:\Users\Ranst\OneDrive\Desktop\Stata"

clear all
use ${FIL341}/Comp20.dta
*br

**Drop observations with missing ceq values.**
drop if missing(ceq)

**Drop observations when ceq is zero or negative.**
drop if ceq == 0 
drop if ceq < 0 


**Drop observations with negative sale values.**
drop if sale < 0
summarize at sale, detail


generate double dlc_dltt_at = (dlc+dltt)/at
summarize dlc_dltt_at, detail
scalar p1dlc_dltt_at = r(p1)
scalar p99dlc_dltt_at = r(p99)
generate double wdlc_dltt_at = dlc_dltt_at
replace wdlc_dltt_at = p1dlc_dltt_at if dlc_dltt_at < p1dlc_dltt_at
replace wdlc_dltt_at = p99dlc_dltt_at if dlc_dltt_at < p99dlc_dltt_at ///
& !missing(dlc_dltt_at)

clear

generate double ebit_at = (dlc+ebit)/at
summarize ebit_at, detail
scalar p1ebit_at = r(p1)
scalar p99ebit_at = r(p99)
generate double webit_at = ebit_at
replace webit_at = p1ebit_at if ebit_at < p1ebit_at
replace webit_at = p99ebit_at if ebit_at > p99ebit_at ///
   & !missing(ebit_at)

generate double ppent_at = (dlc+ppent)/at
summarize ppent_at, detail
scalar p1ppent_at = r(p1)
scalar p99ppent_at = r(p99)
generate double wppent_at = ppent_at
replace wppent_at = p1ppent_at if ppent_at < p1ppent_at
replace wppent_at = p99ppent_at if ppent_at > p99ppent_at ///
   & !missing(ppent_at)
   
generate double logSale = (dlc+sale)/at
summarize logSale, detail
scalar p1logSale = r(p1)
scalar p99logSale = r(p99)
generate double wlogSale = logSale
replace wlogSale = p1logSale if logSale < p1logSale
replace wlogSale = p99logSale if logSale > p99logSale ///
   & !missing(logSale)

generate double logAt = (dlc+at)/at
summarize logAt, detail
scalar p1logAt = r(p1)
scalar p99logAt = r(p99)
generate double wlogAt = logAt
   
reg dlc_dltt_at logAt ebit_at logSale ppent_at,cluster(gvkey)
 * Compared to Jeremy's, we have pretty much similar numbers but our regession was one of the minor changes. I decided to use the root MSE as one of the more important pieces of information to look for. As the MSE is a great measure used for determing how far the regession line moves from each data point to another. Compared to Jeremy's and mines I noticed that Jeremy's data has a slight decrease in the regession for his data compared to mines since my information was higher. But we had the same number of observations and generated pretty much the same stuff. 
   
 


