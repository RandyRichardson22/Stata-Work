clear all
global FIL341 ///
"C:\Users\Ranst\OneDrive\Desktop\Stata"

quietly log using $FIL341/international_finance.txt, text replace
quietly log off

scalar djia1897 = 49.41
scalar djia1912 = 87.87
scalar djia1970 = 838.92
scalar djia2020 = 30606.48

scalar gold1897 = 20
scalar gold1912 = 20
scalar gold1970 = 37.375
scalar gold2020 = 1891.10

scalar n1 = 1912 - 1897
scalar n2 = 1970 - 1912
scalar n3 = 2020 - 1970

*1(FV = PV(1+i)^n,  (FV/PV)^(1/N) - 1 = i)

scalar growth1d = (djia1912 / djia1897)^(1/n1) - 1
scalar growth2d = (djia1970 / djia1912)^(1/n2) - 1
scalar growth3d = (djia2020 / djia1970)^(1/n3) - 1
quietly log on
scalar list growth1d
scalar list growth2d
scalar list growth3d

*2 first, estimate DJIA in ounces of gold


scalar djia1897g = djia1897/ gold1897
scalar djia1912g = djia1912/ gold1912
scalar djia1970g = djia1970/ gold1970
scalar djia2020g = djia2020/ gold2020
scalar list djia1897g
scalar list djia1912g
scalar list djia1970g
scalar list djia2020g

scalar growth1g = (djia1912g / djia1897g)^(1/n1) - 1
scalar growth2g = (djia1970g / djia1912g)^(1/n2) - 1
scalar growth3g = (djia2020g / djia1970g)^(1/n3) - 1
quietly log on
scalar list growth1g
scalar list growth2g
scalar list growth3g

*3 

scalar djia2020gEst = djia1897g * (1 + growth1g)^(n1+n2+n3)
scalar timesLarger1 = djia2020gEst / djia2020g
scalar list djia2020gEst
scalar list timesLarger1

*4

scalar djia2020gEst3 = djia1897g * (1 + growth3g)^(n1+n2+n3)
scalar list dija2020Est3
scalar timeSmaller3 = djia2020g / djia2020gEst3
quietly log close