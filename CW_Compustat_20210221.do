* CW_Compustat_20210221

global data_st "C:\Users\Ranst\OneDrive\Desktop\Stata"
/* this statement creates a global macro; differently from local macros,
Stata remembers global macros until they are deleted or Stata is closed;
Whenever I will write $data_st or ${data_st}, Stata will substitute the 
text between quotation marks */
global FIL341 ///
"C:\Users\Ranst\OneDrive\Desktop\Stata"

clear
use $data_st/compustat1.dta
keep gvkey datadate fyear at ceq dcvt dd1 dd2 dlc dltt mkvalt ebit ppent ///
pstk sale sich naicsh
keep if !missing(at) & !missing(dlc) & !missing(dltt)
keep if fyear > 1999
/* will keep only these variables */

set seed 1000
generate double un = runiform()   // creates random values between 0 and 1
/* double will record the most precise values */
summarize un, detail

keep if un < 0.20
save $FIL341/Comp20.dta, replace

