clear

local results $results
local datasets $datasets


use "`datasets'\cleaned_dataWave13.dta"

*name variables
label variable depreindex_s "Depression Index"
label variable TrustPeopleF "Social trust (CO)"


***** Main results 

areg depreindex_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_D1_depressionWave13.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) replace ctitle((1)) 
areg depre_s TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_D1_depressionWave13.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((2))
areg flteeff_s TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_D1_depressionWave13.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((3)) 
areg slprl_s TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_D1_depressionWave13.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((4)) 
areg fltlnl_s TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_D1_depressionWave13.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((5)) 
areg fltsd_s TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_D1_depressionWave13.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((6)) 
areg cldgng_s TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_D1_depressionWave13.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((7)) 
areg wrhpp_s TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_D1_depressionWave13.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((8)) 
areg enjlf_s TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_D1_depressionWave13.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((9)) 

