*test for sample size

clear
estimates clear
local results $results
local datasets $datasets


use "`datasets'\cleaned_dataWave13.dta"
drop TrustPeopleF
merge m:1 isoF using "`datasets'\countryorigin.dta"
drop if _merge!=3
drop _merge

****** standardise second generation immigrants's trust in country of origin for waves 1-7
egen mTrustPeopleF13= mean(TrustPeopleF)
egen sdTrustPeopleF13=sd(TrustPeopleF)
gen TrustF13= (TrustPeopleF-mTrustPeopleF13)/sdTrustPeopleF13
rename TrustPeopleF TrustPeopleF_NonSD13
rename TrustF13 TrustPeopleF

label variable TrustPeopleF "Social trust (CO)"

***** Main results 1
areg depreindex_s TrustPeopleF age agesq i.male  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_D2.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) replace ctitle((1)) 
areg depre_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_D2.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((2)) 
areg flteeff_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_D2.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((3)) 
areg slprl_s c.TrustPeopleF age agesq i.male  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_D2.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((4)) 
areg fltlnl_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_D2.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((5)) 
areg fltsd_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_D2.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((6)) 
areg cldgng_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_D2.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((7)) 
areg wrhpp_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_D2.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((8)) 
areg enjlf_s c.TrustPeopleF age agesq i.male  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_D2.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((9)) 


