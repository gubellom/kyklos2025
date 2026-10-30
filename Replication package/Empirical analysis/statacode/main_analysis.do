clear

local results $results
local datasets $datasets


use "`datasets'\cleaned_data.dta"

*name variables
label variable depreindex_s "Depression Index"
label variable TrustPeopleF "Social trust (CO)"

label variable pdi "Power distance (CO)"
label variable mas "Masculinity (CO)"
label variable uai "Uncertainty avoidance (CO)"
label variable ltowvs "Long-term orientation (CO)"
label variable ivr "Indulgence (CO)"
label variable dscrgrp "Discriminated"
label variable hampered "Physically ill"
label variable e_gdppc "GDP per capita (CO)"
label variable democracy "Democracy (CO)"
label variable religionF "Religiosity (CO)"
label variable idv "Individualism (CO)"
label variable v2pehealth "Health inequality (CO)"
label variable infantmortality "Infant mortality (CO)"
label variable health "Subjective health (CO)"
label variable parliament "Trust in parliament (CO)"


***** define global variables

global individualcontrols i.educ i.maritalstatus i.domicil i.employment religion i.citizen i.isco i.dscrgrp i.hampered 
global aggregatecontrols  democracy parliament e_gdppc v2pehealth religionF infantmortality  idv health 
global hofstede pdi mas uai ltowvs ivr

***** Main results 1
areg depreindex_s c.TrustPeopleF age agesq i.male  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE1.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) replace ctitle((1)) 
areg depre_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE1.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((2)) 
areg flteeff_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE1.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((3)) 
areg slprl_s c.TrustPeopleF age agesq i.male  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE1.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((4)) 
areg fltlnl_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE1.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((5)) 
areg fltsd_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE1.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((6)) 
areg cldgng_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE1.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((7)) 
areg wrhpp_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE1.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((8)) 
areg enjlf_s c.TrustPeopleF age agesq i.male  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE1.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((9)) 


***** Main results 2

areg depreindex_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_2.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) replace ctitle((1)) 
areg depreindex_s TrustPeopleF age agesq i.male  $individualcontrols if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_2.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, ) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((2)) 
areg depreindex_s TrustPeopleF age agesq i.male  $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_2.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, NO, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((3)) 
areg depreindex_s TrustPeopleF age agesq i.male  $individualcontrols $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_2.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((4)) 

***** Main results 3

areg depre_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_depre.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) replace ctitle((1)) 
areg depre_s TrustPeopleF age agesq i.male $individualcontrols if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_depre.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, ) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((2)) 
areg depre_s TrustPeopleF age agesq i.male $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_depre.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, NO, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((3)) 
areg depre_s TrustPeopleF age agesq i.male $individualcontrols $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_depre.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((4)) 

areg fltlnl_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_lonely.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) replace ctitle((1)) 
areg fltlnl_s TrustPeopleF age agesq i.male $individualcontrols if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_lonely.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, ) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((2)) 
areg fltlnl_s TrustPeopleF age agesq i.male $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_lonely.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, NO, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((3)) 
areg fltlnl_s TrustPeopleF age agesq i.male $individualcontrols $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_lonely.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((4)) 

areg fltsd_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_sad.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) replace ctitle((1)) 
areg fltsd_s TrustPeopleF age agesq i.male  $individualcontrols if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_sad.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, ) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((2)) 
areg fltsd_s TrustPeopleF age agesq i.male  $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_sad.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, NO, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((3)) 
areg fltsd_s TrustPeopleF age agesq i.male  $individualcontrols $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_sad.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((4)) 

areg cldgng_s c.TrustPeopleF age agesq i.male  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_going.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) replace ctitle((1)) 
areg cldgng_s TrustPeopleF age agesq i.male  $individualcontrols if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_going.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, ) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((2)) 
areg cldgng_s TrustPeopleF age agesq i.male  $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_going.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, NO, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((3)) 
areg cldgng_s TrustPeopleF age agesq i.male  $individualcontrols $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_going.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((4)) 

areg wrhpp_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_unhappy.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) replace ctitle((1)) 
areg wrhpp_s TrustPeopleF age agesq i.male   $individualcontrols if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_unhappy.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, ) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((2)) 
areg wrhpp_s TrustPeopleF age agesq i.male   $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_unhappy.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, NO, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((3)) 
areg wrhpp_s TrustPeopleF age agesq i.male  $individualcontrols $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_unhappy.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((4)) 

areg enjlf_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_life.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) replace ctitle((1)) 
areg enjlf_s TrustPeopleF age agesq i.male  $individualcontrols if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_life.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, ) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((2)) 
areg enjlf_s TrustPeopleF age agesq i.male  $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_life.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, NO, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((3)) 
areg enjlf_s TrustPeopleF age agesq i.male  $individualcontrols $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C2_life.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((4)) 




**** Main results in footnote (we add the other Hostede dimensions)
areg depreindex_s TrustPeopleF age agesq i.male  $individualcontrols $aggregatecontrols $hofstede if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C4_Hostede.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) replace ctitle((1)) 
areg depre_s TrustPeopleF age agesq i.male $individualcontrols $aggregatecontrols  $hofstede if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C4_Hostede.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((2)) 
areg flteeff_s TrustPeopleF age agesq i.male $individualcontrols $aggregatecontrols  $hofstede if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C4_Hostede.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((3)) 
areg slprl_s TrustPeopleF age agesq i.male $individualcontrols $aggregatecontrols  $hofstede if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C4_Hostede.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((4)) 
areg fltlnl_s TrustPeopleF age agesq i.male $individualcontrols $aggregatecontrols  $hofstede if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C4_Hostede.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((5)) 
areg fltsd_s TrustPeopleF age agesq i.male  $individualcontrols $aggregatecontrols  $hofstede if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C4_Hostede.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((6)) 
areg cldgng_s TrustPeopleF age agesq i.male  $individualcontrols $aggregatecontrols  $hofstede if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C4_Hostede.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((7)) 
areg wrhpp_s TrustPeopleF age agesq i.male  $individualcontrols $aggregatecontrols  $hofstede if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C4_Hostede.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((8)) 
areg enjlf_s TrustPeopleF age agesq i.male  $individualcontrols $aggregatecontrols  $hofstede if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C4_Hostede.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((9)) 


**** Create table showing all coefficients
areg depreindex_s TrustPeopleF age agesq i.male  $individualcontrols $aggregatecontrols if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C3.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2 drop(i.isco) sortvar(TrustPeopleF age agesq i.male $individualcontrols democracy parliament e_gdppc v2pehealth religionF infantmortality  idv health ) dec(3) replace ctitle((1)) 
areg depre_s TrustPeopleF age agesq i.male $individualcontrols $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C3.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2 drop(i.isco) sortvar(TrustPeopleF age agesq i.male $individualcontrols democracy parliament e_gdppc v2pehealth religionF infantmortality  idv health )  dec(3) append ctitle((2)) 
areg flteeff_s TrustPeopleF age agesq i.male $individualcontrols $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C3.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2 drop(i.isco) sortvar(TrustPeopleF age agesq i.male $individualcontrols democracy parliament e_gdppc v2pehealth religionF infantmortality  idv health ) dec(3) append ctitle((3)) 
areg slprl_s TrustPeopleF age agesq i.male $individualcontrols $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C3.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2 drop(i.isco) sortvar(TrustPeopleF age agesq i.male $individualcontrols democracy parliament e_gdppc v2pehealth religionF infantmortality  idv health )  dec(3) append ctitle((4)) 
areg fltlnl_s TrustPeopleF age agesq i.male $individualcontrols $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C3.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2 drop(i.isco) sortvar(TrustPeopleF age agesq i.male $individualcontrols democracy parliament e_gdppc v2pehealth religionF infantmortality  idv health )  dec(3) append ctitle((5)) 
areg fltsd_s TrustPeopleF age agesq i.male  $individualcontrols $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C3.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2 drop(i.isco) sortvar(TrustPeopleF age agesq i.male $individualcontrols democracy parliament e_gdppc v2pehealth religionF infantmortality  idv health )  dec(3) append ctitle((6)) 
areg cldgng_s TrustPeopleF age agesq i.male  $individualcontrols $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C3.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2 drop(i.isco) sortvar(TrustPeopleF age agesq i.male $individualcontrols democracy parliament e_gdppc v2pehealth religionF infantmortality  idv health )  dec(3) append ctitle((7)) 
areg wrhpp_s TrustPeopleF age agesq i.male  $individualcontrols $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C3.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2 drop(i.isco) sortvar(TrustPeopleF age agesq i.male $individualcontrols democracy parliament e_gdppc v2pehealth religionF infantmortality  idv health )  append ctitle((8)) 
areg enjlf_s TrustPeopleF age agesq i.male  $individualcontrols $aggregatecontrols  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C3.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2 drop(i.isco) sortvar(TrustPeopleF age agesq i.male $individualcontrols democracy parliament e_gdppc v2pehealth religionF infantmortality  idv health ) dec(3) append ctitle((9)) 


 