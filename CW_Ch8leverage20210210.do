/* CW_Ch8leverage20210210 */
* FIL 341

/* select commands (text) you want to run and press:
on PC: control-D
on Mac: command-shift-D */

log using $data_temp/CW_Ch8a.txt, text replace nomsg

clear all
scalar faceValue = 1000
/* if the face value is not given for corporate bonds, assume $1000 */
scalar N = 11
scalar couponR = 0.11
scalar yieldTM = 0.08
/* it can be called the current interest rate on similar risk bonds or
required rate of return on similar risk investments */
scalar BVdebt = 5000000000

/************         1. Estimate the Market Value of Debt         ************/

* Present value of bond; estimates for any N

scalar PVbond_N = faceValue/(1 + yieldTM)^N
scalar couponP = faceValue * couponR
local No = N
/* local is similar to scalar, but it works here while scalar does not ;
Stata forgets quickly what is created as local 
(scalar it remembers until the memory is cleared)   */
forvalues i = 1/`No' {
scalar PVbond_N = PVbond_N + couponP/(1 + yieldTM)^`i'
}
scalar NofBonds = BVdebt / faceValue
scalar MVdebt = PVbond_N * NofBonds
scalar list MVdebt

/**************      2. Estimate the Market Value of Equity      **************/

scalar NofShares = 200000000
scalar sharePrice = 40
scalar MVequity = NofShares * sharePrice
scalar list MVequity

/**********      3. Estimate Book and Market Debt/(Debt+Equity)      **********/

scalar BVequity = 5000000000
scalar BVleverage = BVdebt / (BVdebt + BVequity)
scalar MVleverage = MVdebt / (MVdebt + MVequity)
scalar list BVleverage
scalar list MVleverage

/**********            4. Estimate After-tax Cost of Debt            **********/

scalar tax = .35
scalar ATcostDebt = yieldTM * (1 - tax)
scalar list ATcostDebt

/**********                5. Estimate Cost of Equity                **********/

scalar RFrate = 0.045
scalar beta = 1.35
scalar RPequity = 0.05
scalar costEquity = RFrate + beta * RPequity
scalar list costEquity

/**********                      6. Estimate WACC                    **********/

scalar WACC = (MVequity * costEquity + MVdebt * ATcostDebt)    ///
   / (MVequity + MVdebt)
scalar list WACC

* end saving results window in a file
log close

/******************************************************************************/
/**********                    Evaluate Alternatives                 **********/
/******************************************************************************/

* First, we need to estimate unleverage beta so we can estimate new betas 

scalar unlBeta = beta / (1 + (1 - tax) * (MVdebt / MVequity))
scalar list unlBeta

/******************************************************************************/
/**********          1. Issue $2B Stock; Repurchase $2B Debt         **********/
/******************************************************************************/

scalar yieldTM1 = 0.07
scalar changeD1 = -2000000000

* New Market Value of Debt   
scalar MVdebt1 = MVdebt + changeD1 
scalar list MVdebt1

* New Market Value of Equity     
scalar MVequity1 = MVequity - changeD 
scalar list MVequity1

* New After-tax Cost of Debt            
scalar ATcostDebt1 = yieldTM1 * (1 - tax)
scalar list ATcostDebt1

* New Cost of Equity  
scalar beta1 = unlBeta * (1 + (1 - tax) * (MVdebt1 / MVequity1))
scalar list beta1
scalar costEquity1 = RFrate + beta1 * RPequity
scalar list costEquity1

* New WACC                   
scalar WACC1 = (MVequity1 * costEquity1 + MVdebt1 * ATcostDebt1)    ///
   / (MVequity1 + MVdebt1)
scalar list WACC1

/******************************************************************************/
/**********          2. Repurchase $2B Stock; Issue $2B Debt         **********/
/******************************************************************************/

scalar yieldTM2 = 0.11
scalar changeD2 = 2000000000

* New Market Value of Debt   
scalar MVdebt2 = MVdebt + changeD2 
scalar list MVdebt2

* New Market Value of Equity     
scalar MVequity2 = MVequity - changeD2 
scalar list MVequity2

* New After-tax Cost of Debt            
scalar ATcostDebt2 = yieldTM2 * (1 - tax)
scalar list ATcostDebt2

* New Cost of Equity  
scalar beta2 = unlBeta * (1 + (1 - tax) * (MVdebt2 / MVequity2))
scalar costEquity2 = RFrate + beta2 * RPequity
scalar list costEquity2

* New WACC                   
scalar WACC2 = (MVequity2 * costEquity2 + MVdebt2 * ATcostDebt2)    ///
   / (MVequity2 + MVdebt2)
scalar list WACC2

/******************************************************************************/
/**********          3. Repurchase $4B Stock; Issue $4B Debt         **********/
/******************************************************************************/

scalar yieldTM3 = 0.15
scalar changeD3 = 4000000000

* New Market Value of Debt   
scalar MVdebt3 = MVdebt + changeD3 
scalar list MVdebt3

* New Market Value of Equity     
scalar MVequity3 = MVequity - changeD3 
scalar list MVequity3

* New After-tax Cost of Debt            
scalar ATcostDebt3 = yieldTM3 * (1 - tax)
scalar list ATcostDebt3

* New Cost of Equity  
scalar beta3 = unlBeta * (1 + (1 - tax) * (MVdebt3 / MVequity3))
scalar costEquity3 = RFrate + beta3 * RPequity
scalar list costEquity3

* New WACC                   
scalar WACC3 = (MVequity3 * costEquity3 + MVdebt3 * ATcostDebt3)    ///
   / (MVequity3 + MVdebt3)
scalar list WACC3
scalar list WACC2
scalar list WACC1
scalar list WACC





