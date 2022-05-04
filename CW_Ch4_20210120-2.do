/* CW_Ch4 Cost of Capital 
aaa */
* FIL 341

/* select commands (text) you want to run and press:
on PC: control-D
on Mac: command-shift-D */

clear
/* deletes all variables from memory */
help clear
/* the last statement gives us information about command clear 
in later programs you do not need to write help clear */

/* First, we enter the variables from the first paragraph
of CW_Ch4_capital_cost; I skipped some variables that we 
do not use in these calculations */
scalar beta = 1.82
help scalar

scalar MVequity = 52000000
scalar MVassets = 91000000
scalar yieldTM = 6.096
scalar tax = .22
scalar RFrate = 3.6
scalar RPequity = 6.7

* a
* use CAPM; remember Risk premium is Return minus Risk-free rate
scalar costEquity = RFrate + beta * RPequity
scalar list costEquity

* b
scalar returnEquity = RFrate + beta * RPequity
scalar list returnEquity

* c
/* Unleveraged beta is what the company beta would be 
if it had no debt at all 
Business risk shows what percent of systematic risk comes 
from assets (remaining is from debt) */
scalar MVdebt = MVassets - MVequity
scalar unlBeta = beta / (1 + (1 - tax) * (MVdebt / MVequity))
scalar businessRisk = unlBeta / beta
scalar list businessRisk

* d
scalar ATcostDebt = yieldTM * (1 - tax)
scalar list ATcostDebt

* e
/* weighted average */
scalar WACC = (MVequity * costEquity + MVdebt * ATcostDebt)    ///
   / (MVequity + MVdebt)
scalar list WACC

*f
scalar newMVdebt = MVdebt + 10000000
scalar newMVequity = MVequity - 10000000
scalar newBeta = unlBeta * (1 + (1 - tax) * (newMVdebt / newMVequity))
scalar list  newBeta

*g 
scalar betaOC = 1.25
scalar MVassetsOC = 52000000
scalar mergedBeta = (MVassets * beta + MVassetsOC * betaOC)        ///
   / (MVassets + MVassetsOC)
scalar list mergedBeta





