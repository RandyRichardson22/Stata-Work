clear
scalar MVDebt = 33000000
scalar RPequity = .063
scalar RFrate = .04
scalar MVDebtOC = MVDebt + 10000000
scalar MVEquity = 50000000
scalar MVEquityOC = MVEquity + 33000000
scalar betalev = 2
scalar unlBeta = betalev / (1+(MVDebtOC/MVEquityOC) * (1- tc))
scalar Tc = .2
scalar ke =
scalar WACC = ( Debt/Assets)*kd (1-tc) + ( Equity/Assets) * ke)
scalar Betalev = unlBeta(1+(Debt/ Equity) * (1-tc))
scalar Operatingleverage = (% change in operatingprofit) / (% change in sales)

*1
scalar unlBeta = betalev / (1+(MVDebtOC/MVEquityOC) * (1- Tc))
scalar list unlBeta

scalar costEquity = RFrate + unlBeta * RPequity
scalar list costEquity