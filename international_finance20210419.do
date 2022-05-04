/* international_finance20210419.do */

clear all
global FIL341 ///
"/Users/macbook2019/Documents/ISUclasses/IntermediateFinance/Stata341"

quietly log using $FIL341/international_finance.txt, text replace
* quietly--suppresses output

quietly log off

scalar receivablesForeign = 6000000
scalar futuresER = 1.03
scalar forwardER = 1.02

scalar expectedER1 = 1.1
scalar expectedER2 = 0.97
scalar probability1 = .4

scalar strikePrice = 0.99
scalar optionPremium = 0.04

/******************************************************************************/
/******   Estimate receivables in dollars in one year for each strategy  ******/
/******************************************************************************/

* Futures
scalar receivablesFutures = receivablesForeign * futuresER

quietly log on  
scalar list receivablesFutures
quietly log off

* Forward
scalar receivablesForward = receivablesForeign * forwardER

quietly log on
scalar list receivablesForward
quietly log off

* No Hedging
scalar probability2 = 1 - probability1
scalar expectedER = probability1 * expectedER1 + probability2 * expectedER2
scalar receivablesNoHedging = receivablesForeign * expectedER
quietly log on
scalar list receivablesNoHedging
quietly log off

* Options (for receivables use put option (option to sell))
scalar expectedER1options = expectedER1
* when selling (put) want higher prices; the price is higher in spot market
scalar expectedER2options = strikePrice
* when selling (put) want higher prices; the price is higher using option

scalar expectedERoptions = probability1 * expectedER1options ///
    + probability2 * expectedER2options - optionPremium
scalar receivablesOptions = receivablesForeign * expectedERoptions
quietly log on
scalar list receivablesOptions
quietly log off

quietly log close
