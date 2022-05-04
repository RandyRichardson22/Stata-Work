clear all
global FIL341 ///
"C:\Users\Ranst\OneDrive\Desktop\Stata"\
quietly log using $FIL341/international_Finance20210419, text replace
quietly log off

scalar receivablesForeign = 2300000
scalar futuresEXP = 0.97
scalar forwardEXP = 0.96

scalar expectedEXP1 = .98
scalar expectedEXP2 = .91
scalar expectedEXP3 = .86
scalar Probability01 = .45
scalar Probability02 = .35
scalar Probability03 = .2
scalar StrikePrice = .93
scalar CoptionPremium = .12
scalar PoptionPremium = .03

******Est receivables in dollars in one year for each strategy********

*Futures

scalar receivablesFutures = receivablesForeign * futuresEXP

quietly log on
scalar list receivablesFutures
quietly log off
*2231000

*Forward

scalar receivablesForward = receivablesForeign * forwardEXP

quietly log on
scalar list receivablesForward
quietly log off
*2208000

*No Hedging
scalar expectedER = Probability01 * expectedEXP1 + Probability02 * expectedEXP2 + expectedEXP3 * Probability03
scalar receivablesNoHedging = receivablesForeign * expectedER

quietly log on
scalar list receivablesNoHedging
quietly log off
*2142450

*Options
scalar expectedER1options = expectedER1
scalar expectedER2options = strikePrice
scalar expectedER3options = strikePrice

scalar expectedERoptions = probability1 * expectedER1options + (probability2 * expectedER2options - PoptionPremium) + (probability3 *expectedER3 - PoptionPremium)

scalar receivablesOptions = receivablesForeign * expectedERoptions

quietly log on
scalar list receivablesOptions
quietly log off
*2020550

quietly log close


*The main disadvantage of hedging is it costs more to hedge. Hedging can be thought of as an insurance policy against downside risk. Just like insurance, hedging requires a premium the owner must pay. The main advantage of hedging is the decreased downside risk that hedging provides. Just like insurance, hedging can limit the downside losses to the owner.