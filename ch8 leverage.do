scalar faceValue = 1000
scalar N = 11
scalar couponR = .11
scalar yieldTM = .08

scalar PVofFaceV = faceValue / (1 + yieldTM)^N
scalar list PVofFaceV

scalar PVofFaceV = faceValue / (1 + yieldTM)^N 
scalar couponP = faceValue * couponR

scalar PVbond_N = PVofFaceV
local No = N

forvalues i = 1/`No' {
scalar PVbond_N = PVbond_N + couponP /(1 + yieldTM)^`i'
}
scalar list PVbond_N

*1 Estimate the Market Value of Debt
scalar MVdebt = (5000000 * PVbond_N) 
scalar list MVdebt

*2 Estimate the Market Value of Equity
scalar Oshares = 200000000
scalar Sprice = 40 
scalar MVequity = Oshares * Sprice
scalar list MVequity

*3 Estimate the book and market debt rations
scalar Mdebtratio = MVdebt / (MVdebt + MVequity)
scalar list Mdebtratio

scalar debt = 5000000000
scalar equity = 5000000000
scalar Bdebtratio = debt / (debt + equity)
scalar list Bdebtratio

*4 Estimate the after-tax cost of debt
scalar yieldTM = .08
scalar tax = .35

scalar ATcostdebt = yieldTM * (1 - tax)
scalar list ATcostdebt

*5 Estimate the Cost of Equity 
scalar RFrate = 4.5
scalar Beta = 1.35
scalar RPequity = 5

scalar costEquity = RFrate + Beta * RPequity
scalar list costEquity

*6 Estimate the Cost of Capital
scalar WACC = (MVequity * costEquity + MVdebt * ATcostdebt) ///
   /(MVequity + MVdebt)
scalar list WACC 


