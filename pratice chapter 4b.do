scalar MVDebt = 33000000
scalar RPequity = 6.3
scalar RFrate = 4
scalar MVDebtOC = MVDebt - 10000000
scalar MVEquity = 50000000
scalar MVEquityOC = MVEquity + 10000000
scalar beta = 2
scalar Tax = .02
scalar unlBeta = beta / (1+(1-Tax) * (MVDebt/ MVEquity ))
scalar betalev = unlBeta * (1+(1-Tax) * (MVDebtOC/ MVEquityOC ))

*1
scalar betalev = unlBeta * (1+(1-Tax) * (MVDebtOC / MVEquityOC ))
scalar list betalev

scalar costEquity = RFrate + betalev * RPequity
scalar list costEquity

*2
clear
scalar MVEquity = 50000000
scalar MVEquityOC = 20000000
scalar MVDebtOC = 80000000
scalar MVassets = 83000000
scalar MVassetsOC = 60000000
scalar beta = 2
scalar betaOC = 1.2
scalar mergedBeta = (MVassets *beta +MVassetsOC *betaOC)/ (MVassets +MVassetsOC)
scalar list mergedBeta

*3
clear
scalar unlBeta = 1
scalar MVEquity = 60000000
scalar MVEquityOC = MVEquity - 20000000
scalar MVDebt = 50000000
scalar MVDebtOC= MVDebt + 20000000 
scalar Tax = .28

scalar newBeta = unlBeta * (1+(1-Tax) * (MVDebtOC/ MVEquityOC))
scalar list newBeta
