clear
*1
scalar MVEquity = 70000000
scalar MVEquityOC = MVEquity +5000000
scalar MVDebt = 33000000
scalar MVDebtOC = MVDebt - 5000000
scalar unlBeta = 1.63
scalar Tax = .25
scalar RPequity = .073
scalar Rfrate = .03
scalar newBeta = unlBeta * (1+(1-Tax) * (MVDebtOC/ MVEquityOC))
scalar list newBeta
clear

*2
clear
scalar Beta = 2
scalar MVequity = 1000000
scalar MVDebt = 600000
scalar BetaOC = .8
scalar MVequityOC = 2000000
scalar MVDebtOC = 500000
scalar MVassets = 1600000
scalar MVassetsOC = 2500000
scalar mergedBeta = ((MVassets *Beta) + (MVassetsOC * BetaOC)) / (MVassets + MVassetsOC)
scalar list mergedBeta

*3
clear
scalar Beta = .63
scalar MVequity = 14000000
scalar MVDebt = 6600000
scalar BetaOC = 1.3
scalar MVEquityOC = 18000000
scalar MVassets = 14000000 + 6600000
scalar MVassetsOC = 24000000
scalar mergedBeta = (( MVassets * Beta) + ( MVassetsOC *BetaOC)) / (MVassets + MVassetsOC)
scalar list mergedBeta

*4
clear
scalar Beta = .63
scalar MVEquity = 37000000
scalar MVEquityOC = MVEquity + 1700000
scalar MVassets = 70000000
scalar MVDebt = 33000000
scalar MVDebtOC = MVDebt - 1700000
scalar RPequity = .073
scalar Rfrate = .03
scalar tax = .25
scalar costEquity = Rfrate +Beta * RPequity
scalar list costEquity

freduse LREM25TTCHQ156S
br 
twoway line LREM25TTCHQ156S daten
freduse LREM25TTUSM156S
br
twoway line LREM25TTUSM156S daten 

 *coment, As you can see the U.S has a sharp decline for its employment rate while Switzerland also has a decline but not a sharp decline as the U.S does. The U.S in my words has a sharp decline at the end is probably due to COVID19 and Americans and many people around the world losing the jobs. Another thing to note is that the U.S has a more stable employment rate while the Switzerland is more unstable before their employment rate drop. Both of the graphs show that both countries have a drop off and that during the 90s they each had more stable rates. 

 

