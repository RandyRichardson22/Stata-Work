*HW1CH4a
*This work will be turned in for the quiz

clear

*1
scalar Beta = .63
scalar ATcost = 3.75
scalar MVassets = 70000000
scalar MVdebt = 33000000
scalar tax = .25
scalar RPequity = 7.3
scalar RFrate = 3
scalar MVequity = MVassets - MVdebt
scalar list MVequity

scalar unlBeta = (Beta / (1+(1-tax) * (MVdebt/MVequity)))
scalar businessRisk = unlBeta/Beta
scalar list businessRisk

*2
scalar costEquity = RFrate + Beta * RPequity
scalar list costEquity

*3
scalar MvEquity = 70000000
scalar MVDebt = 33000000
scalar WACC = ( MvEquity* costEquity +MVDebt * ATcost) / (MvEquity + MVDebt)
scalar list WACC

*4
scalar MVVDebt =70000000
scalar MVEquity = 103000000
scalar Tax = .29
scalar beta = 1.5

scalar UNLbeta = (beta/(1+ (1-Tax) * (MVVDebt / MVEquity)))
scalar list UNLbeta


