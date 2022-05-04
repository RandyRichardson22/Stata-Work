clear all
global FIL341 ///
"C:\Users\Ranst\OneDrive\Desktop\Stata"
use ${FIL341}/Comp20.dta
br

drop if missing(at)
*When I tried to drop the obersations the first time it said 0 obersations were deleted for some reason.

generate double ptsk_at = pstk/at
generate double ebit_at = ebit / at
generate double ceq_at = ceq / at
generate double dcvt_at = dcvt / at
generate double dd1_at = dd1 / at

foreach `i' in pstk, ebit, dcvt, ceq, dd1 {
scalar `i'_at = `i' / at
scalar list `i'_at
}

label variable pstk_at "PSTK RATIO"
label variable ceq_at "CEQ RATIO"
label variable dd1_at "DD1 RATIO"
label variable dcvt_at "DCVT RATIO"
label variable ebit_at "EBIT RATIO"
* I didn't know for sure if this is how you create a new label that helps.