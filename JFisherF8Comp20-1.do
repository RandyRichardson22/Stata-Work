

** Comp20 HW 2.24.2021 **

/* global FIL341 ///
"/Users/jeremyfischer/Documents/College/Stata" */
global FIL341 ///
"/Users/macbook2019/Documents/ISUclasses/IntermediateFinance/Stata341"


clear
use ${FIL341}/Comp20.dta
*br

**Drop observations with missing ceq values.**
/* drop if ceq == . */
drop if missing(ceq)
/* keep if !missing(ceq) */

**Drop observations when ceq is zero or negative.**
drop if ceq == 0 
drop if ceq < 0 
/* drop if ceq <= 0 */
/* drop if ceq == 0 | ceq < 0 */

**Drop observations with negative sale values.**
drop if sale < 0
summarize at sale, detail

/* Estimate the ratio of ppent and at (use the type that records the variable 
with highest precision), create a label for this variable. */
generate double ppent_at = ppent/at
label variable ppent_at "PPENT Ratio"
*br

**Use the same log transformation for sale as we used for at in class (use the type that records the variable with highest precision).**
generate double logSale = log(sale+1)

**Get detailed summary of the two variables you just created.**
summarize ppent_at logSale, detail

**Regress dlc_dltt_at  on the two variables we created during the last class logAt ebit_at (you will need to create these variables again) and the two new variables (all variables in one regression). Run the regression in a way that is appropriate when we have more than one observation per firm.**
generate double ebit_at = ebit / at
generate double logAt = log(at+1)
generate double dlc_dltt_at = (dlc+dltt)/at

reg dlc_dltt_at logAt ebit_at logSale ppent_at,cluster(gvkey)
* use cluster(gvkey) when you have more than one observation per firm









