clear all

local results $results
local datasets $datasets


use "`datasets'\cleaned_data.dta"

*name variables
label variable depreindex_s "Depression Index"
label variable TrustPeopleF "Social trust (CO)"
label variable DMTrustPeopleF "Social trust (CO)"
label variable TrustPeopleFsd "Social trust SD (CO)"
label variable geodistance "Geographical distance (CO)"
label variable DMcult_distance "Cultural distance (CO)"
label variable e_gdppc "GDP per capita (CO)"
label variable democracy "Democracy (CO)"
label variable religionF "Religiosity (CO)"
label variable idv "Individualism (CO)"
label variable v2pehealth "Health inequality (CO)"
label variable infantmortality "Infant mortality (CO)"
label variable health "Subjective health (CO)"
label variable parliament "Trust in parliament (CO)"




**** define table with aggregate variables one by one
   
areg depreindex_s TrustPeopleF  e_gdppc  age agesq i.male  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C5.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF e_gdppc democracy religionF idv v2pehealth infantmortality health parliament age agesq i.male) sortvar(TrustPeopleF e_gdppc democracy religionF idv v2pehealth infantmortality health parliament age agesq i.male) dec(3) replace ctitle((1))
areg depreindex_s TrustPeopleF  democracy  age agesq i.male  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C5.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF e_gdppc democracy religionF idv v2pehealth infantmortality health parliament age agesq i.male) sortvar(TrustPeopleF e_gdppc democracy religionF idv v2pehealth infantmortality health parliament age agesq i.male) dec(3) append ctitle((2))
areg depreindex_s TrustPeopleF  religionF  age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C5.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF e_gdppc democracy religionF idv v2pehealth infantmortality health parliament age agesq i.male) sortvar(TrustPeopleF e_gdppc democracy religionF idv v2pehealth infantmortality health parliament age agesq i.male) dec(3) append ctitle((3))
areg depreindex_s TrustPeopleF  idv  age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C5.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF e_gdppc democracy religionF idv v2pehealth infantmortality health parliament age agesq i.male) sortvar(TrustPeopleF e_gdppc democracy religionF idv v2pehealth infantmortality health parliament age agesq i.male) dec(3) append ctitle((4))
areg depreindex_s TrustPeopleF  v2pehealth  age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C5.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF e_gdppc democracy religionF idv v2pehealth infantmortality health parliament age agesq i.male) sortvar(TrustPeopleF e_gdppc democracy religionF idv v2pehealth infantmortality health parliament age agesq i.male) dec(3) append ctitle((5))
areg depreindex_s TrustPeopleF  infantmortality  age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C5.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF e_gdppc democracy religionF idv v2pehealth infantmortality health parliament age agesq i.male) sortvar(TrustPeopleF e_gdppc democracy religionF idv v2pehealth infantmortality health parliament age agesq i.male) dec(3) append ctitle((6))
areg depreindex_s TrustPeopleF  health  age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C5.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF e_gdppc democracy religionF idv v2pehealth infantmortality health parliament age agesq i.male) sortvar(TrustPeopleF e_gdppc democracy religionF idv v2pehealth infantmortality health parliament age agesq i.male) dec(3) append ctitle((7))
areg depreindex_s TrustPeopleF  parliament  age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C5.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF e_gdppc democracy religionF idv v2pehealth infantmortality health parliament age agesq i.male) sortvar(TrustPeopleF e_gdppc democracy religionF idv v2pehealth infantmortality health parliament age agesq i.male) dec(3) append ctitle((8))




******* Geographical analysis without controls
areg depreindex_s DMTrustPeopleF age agesq i.male i.continent2 if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_3.xls", tex label nocons adjr2  keep(DMTrustPeopleF TrustPeopleFsd ) sortvar(DMTrustPeopleF TrustPeopleFsd geodistance DMcult_distance c.DMTrustPeopleF#c.DMcult_distance)  dec(3) replace ctitle((1))
areg depreindex_s DMTrustPeopleF TrustPeopleFsd age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_3.xls", tex label nocons adjr2  keep(DMTrustPeopleF TrustPeopleFsd ) sortvar(DMTrustPeopleF TrustPeopleFsd geodistance DMcult_distance c.DMTrustPeopleF#c.DMcult_distance)  dec(3) append ctitle((2)) 
areg depreindex_s DMTrustPeopleF geodistance age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_3.xls", tex label  nocons adjr2  keep(DMTrustPeopleF geodistance ) sortvar(DMTrustPeopleF TrustPeopleFsd geodistance DMcult_distance c.DMTrustPeopleF#c.DMcult_distance)  dec(3) append ctitle((3)) 
areg depreindex_s DMTrustPeopleF c.DMTrustPeopleF#c.DMcult_distance DMcult_distance age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_3.xls", tex label  nocons adjr2  keep(DMTrustPeopleF c.DMTrustPeopleF#c.DMcult_distance) sortvar(DMTrustPeopleF TrustPeopleFsd geodistance DMcult_distance c.DMTrustPeopleF#c.DMcult_distance)  dec(3) append ctitle((4)) 





*********** Create plots for leave-one-country-out robustness check

******* plot coefficient for social trust in country of origin by removing one country per time
sort iso2F
levelsof iso2F, local(levels3)             
foreach i of local levels3 { 
gen TrustPeopleF_`i'= TrustPeopleF if iso2F !=`i'       
quietly eststo: areg depreindex_s TrustPeopleF_`i' age agesq i.male  i.continent2  if imm1==1 & iso2F !=`i',absorb(intwaviso) vce(cluster iso2F)
estimate store coeff`i'
}

**** generate labels
label variable TrustPeopleF_4 "AR"
label variable TrustPeopleF_5 "AT"
label variable TrustPeopleF_6 "AU"
label variable TrustPeopleF_9 "BD"
label variable TrustPeopleF_10 "BE"
label variable TrustPeopleF_12 "BG"
label variable TrustPeopleF_14 "BR"
label variable TrustPeopleF_16 "CA"
label variable TrustPeopleF_17 "CH"
label variable TrustPeopleF_18 "CL"
label variable TrustPeopleF_19 "CN"
label variable TrustPeopleF_20 "CO"
label variable TrustPeopleF_22 "CZ"
label variable TrustPeopleF_23 "DE"
label variable TrustPeopleF_24 "DK"
label variable TrustPeopleF_27 "EC"
label variable TrustPeopleF_28 "EE"
label variable TrustPeopleF_30 "ES"
label variable TrustPeopleF_32 "FI"
label variable TrustPeopleF_33 "FR"
label variable TrustPeopleF_34 "GB"
label variable TrustPeopleF_37 "GR"
label variable TrustPeopleF_42 "HU"
label variable TrustPeopleF_43 "ID"
label variable TrustPeopleF_44 "IE"
label variable TrustPeopleF_46 "IN"
label variable TrustPeopleF_48 "IR"
label variable TrustPeopleF_50 "IT"
label variable TrustPeopleF_52 "JP"
label variable TrustPeopleF_55 "KR"
label variable TrustPeopleF_59 "LT"
label variable TrustPeopleF_60 "LU"
label variable TrustPeopleF_61 "LV"
label variable TrustPeopleF_63 "MA"
label variable TrustPeopleF_71 "MT"
label variable TrustPeopleF_73 "MX"
label variable TrustPeopleF_74 "MY"
label variable TrustPeopleF_77 "NL"
label variable TrustPeopleF_78 "NO"
label variable TrustPeopleF_79 "NZ"
label variable TrustPeopleF_80 "PE"
label variable TrustPeopleF_81 "PH"
label variable TrustPeopleF_82 "PK"
label variable TrustPeopleF_83 "PL"
label variable TrustPeopleF_86 "PT"
label variable TrustPeopleF_87 "RO"
label variable TrustPeopleF_89 "RU"
label variable TrustPeopleF_92 "SE"
label variable TrustPeopleF_93 "SG"
label variable TrustPeopleF_94 "SI"
label variable TrustPeopleF_97 "TH"
label variable TrustPeopleF_100 "TR"
label variable TrustPeopleF_101 "TT"
label variable TrustPeopleF_102 "TW"
label variable TrustPeopleF_106 "US"
label variable TrustPeopleF_107 "UY"
label variable TrustPeopleF_109 "VE"
label variable TrustPeopleF_110 "VN"



coefplot (coeff*,  color(midblue%90) ciopts(color(midblue%90)) msymbol(O) msize(medium)), drop(_cons) level(95) vertical  yline(0,  lpattern(solid) lcolor(red)) keep(TrustPeopleF_*) legend(off) title("Leave-one-country-out estimations (country of origin)") ytitle("Coefficients with s.e.") ylabel(-0.10(.05)0.01) xlabel(, labsize(small) angle(vertical))
graph save "`results'\outlier_country_TrustPeopleFdepression.gph", replace
drop TrustPeopleF_*


*** reset the memory
clear all

local results $results
local datasets $datasets

use "`datasets'\cleaned_data.dta"


*name variables
label variable depreindex_s "Depression index"
label variable TrustPeopleF "Social trust (CO)"
label variable TrustPeopleFsd "SD Social trust (CO)"
label variable DMTrustPeopleF "Social trust (CO)"
label variable DMcult_distance "Cultural distance"
label variable geodistance "Geographical distance"

*name aggregate variables
label variable e_gdppc "GDP per capita (CO)"
label variable democracy "democracy (CO)"
label variable religionF "Religiosity (CO)"
label variable idv "Individualism (CO)"
label variable v2pehealth "Health inequality (CO)"
label variable infantmortality "Infant mortality (CO)"
label variable health "Subjective health (CO)"
label variable parliament "Trust in parliament (CO)"


******* plot coefficient for social trust in country of residence by removing one country per time (no controls)
encode iso2, gen(iso2R)

sort iso2R
levelsof iso2R, local(levels2)             
foreach i of local levels2 { 
gen TrustPeopleF_`i'= TrustPeopleF if iso2R !=`i'       
quietly eststo: areg depreindex_s TrustPeopleF_`i' age agesq i.male  i.continent2 if imm1==1 & iso2R !=`i',absorb(intwaviso) vce(cluster iso2F)
estimate store coeff`i'
}


**** generate labels
label variable TrustPeopleF_1 "BE"
label variable TrustPeopleF_2 "CH"
label variable TrustPeopleF_3 "CZ"
label variable TrustPeopleF_4 "DE"
label variable TrustPeopleF_5 "DK"
label variable TrustPeopleF_6 "EE"
label variable TrustPeopleF_7 "ES"
label variable TrustPeopleF_8 "FI"
label variable TrustPeopleF_9 "FR"
label variable TrustPeopleF_10 "GB"
label variable TrustPeopleF_11 "HU"
label variable TrustPeopleF_12 "IE"
label variable TrustPeopleF_13 "IL"
label variable TrustPeopleF_14 "LT"
label variable TrustPeopleF_15 "NL"
label variable TrustPeopleF_16 "NO"
label variable TrustPeopleF_17 "PL"
label variable TrustPeopleF_18 "PT"
label variable TrustPeopleF_19 "RU"
label variable TrustPeopleF_20 "SE"
label variable TrustPeopleF_21 "SI"
label variable TrustPeopleF_22 "SK"



coefplot (coeff*,  color(midblue%90) ciopts(color(midblue%90)) msymbol(O) msize(medium)), drop(_cons) level(95) vertical  yline(0,  lpattern(solid) lcolor(red)) keep(TrustPeopleF_*) legend(off) title("Leave-one-country-out estimations (country of residence)") ytitle("Coefficients with s.e.") ylabel(-0.10(.05)0.01) xlabel(, labsize(medium))
graph save "`results'\outlier_countryresidence.gph", replace
drop TrustPeopleF_*


graph combine  "`results'\outlier_country_TrustPeopleFdepression.gph" "`results'\outlier_countryresidence.gph", rows(2) graphregion(color(white)) plotregion(color(white) margin(small)) 
graph export "`results'\FIGURE_5.pdf", replace





***** ordered probit 

oprobit depre c.TrustPeopleF age agesq i.male i.intwaviso if imm1==1, vce(cluster iso2F)
outreg2 using "`results'\TABLE_C6_A.xls", tex label addtext(Country-Wave FE, YES,) nocons  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) replace ctitle((1)) 
oprobit flteeff c.TrustPeopleF age agesq i.male i.intwaviso  if imm1==1, vce(cluster iso2F)
outreg2 using "`results'\TABLE_C6_A.xls", tex label addtext(Country-Wave FE, YES,) nocons  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((2)) 
oprobit slprl c.TrustPeopleF age agesq i.male  i.intwaviso  if imm1==1,  vce(cluster iso2F)
outreg2 using "`results'\TABLE_C6_A.xls", tex label addtext(Country-Wave FE, YES,) nocons  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((3)) 
oprobit fltlnl c.TrustPeopleF age agesq i.male i.intwaviso  if imm1==1,  vce(cluster iso2F)
outreg2 using "`results'\TABLE_C6_A.xls", tex label addtext(Country-Wave FE, YES,) nocons  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((4)) 
oprobit fltsd c.TrustPeopleF age agesq i.male i.intwaviso  if imm1==1, vce(cluster iso2F)
outreg2 using "`results'\TABLE_C6_A.xls", tex label addtext(Country-Wave FE, YES,) nocons  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((5)) 
oprobit cldgng c.TrustPeopleF age agesq i.male i.intwaviso  if imm1==1,  vce(cluster iso2F)
outreg2 using "`results'\TABLE_C6_A.xls", tex label addtext(Country-Wave FE, YES,) nocons  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((6)) 
oprobit wrhpp c.TrustPeopleF age agesq i.male i.intwaviso  if imm1==1, vce(cluster iso2F)
outreg2 using "`results'\TABLE_C6_A.xls", tex label addtext(Country-Wave FE, YES,) nocons  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((7)) 
oprobit enjlf c.TrustPeopleF age agesq i.male i.intwaviso  if imm1==1,  vce(cluster iso2F)
outreg2 using "`results'\TABLE_C6_A.xls", tex label addtext(Country-Wave FE, YES,) nocons keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((8)) 


*** ordered logit
ologit depre c.TrustPeopleF age agesq i.male i.intwaviso if imm1==1, vce(cluster iso2F)
outreg2 using "`results'\TABLE_C6_B.xls", tex label addtext(Country-Wave FE, YES,) nocons  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) replace ctitle((1)) 
ologit flteeff c.TrustPeopleF age agesq i.male i.intwaviso  if imm1==1, vce(cluster iso2F)
outreg2 using "`results'\TABLE_C6_B.xls", tex label addtext(Country-Wave FE, YES,) nocons  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((2)) 
ologit slprl c.TrustPeopleF age agesq i.male  i.intwaviso  if imm1==1,  vce(cluster iso2F)
outreg2 using "`results'\TABLE_C6_B.xls", tex label addtext(Country-Wave FE, YES,) nocons  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((3)) 
ologit fltlnl c.TrustPeopleF age agesq i.male i.intwaviso  if imm1==1,  vce(cluster iso2F)
outreg2 using "`results'\TABLE_C6_B.xls", tex label addtext(Country-Wave FE, YES,) nocons  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((4)) 
ologit fltsd c.TrustPeopleF age agesq i.male i.intwaviso  if imm1==1, vce(cluster iso2F)
outreg2 using "`results'\TABLE_C6_B.xls", tex label addtext(Country-Wave FE, YES,) nocons  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((5)) 
ologit cldgng c.TrustPeopleF age agesq i.male i.intwaviso  if imm1==1,  vce(cluster iso2F)
outreg2 using "`results'\TABLE_C6_B.xls", tex label addtext(Country-Wave FE, YES,) nocons  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((6)) 
ologit wrhpp c.TrustPeopleF age agesq i.male i.intwaviso  if imm1==1, vce(cluster iso2F)
outreg2 using "`results'\TABLE_C6_B.xls", tex label addtext(Country-Wave FE, YES,) nocons  keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((7)) 
ologit enjlf c.TrustPeopleF age agesq i.male i.intwaviso  if imm1==1,  vce(cluster iso2F)
outreg2 using "`results'\TABLE_C6_B.xls", tex label addtext(Country-Wave FE, YES,) nocons keep(TrustPeopleF) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((8)) 



************************************************************************
************************************************************************
************************************************************************


***only wave2 and 3 with income variable


***** define global variables

global individualcontrols i.educ i.maritalstatus i.domicil i.employment religion i.citizen i.isco i.dscrgrp i.hampered 
global aggregatecontrols  democracy parliament e_gdppc v2pehealth religionF infantmortality  idv health 

replace income=. if missing(income)

preserve
gen higheduc=1 if eiscedf>=6 |  edulvlfb>=500
replace higheduc=0 if higheduc==.


areg higheduc TrustPeopleF age agesq i.male if imm1==1 & (iso2!="RU" | iso2!="SK"), absorb(intwaviso) vce(cluster iso2F)

restore

preserve
drop if wave==1
** do not consider RU and Sk because they do not have observations in both waves

***** Main results

areg depreindex_s TrustPeopleF age agesq i.male if imm1==1 & income!=. & (iso2!="RU" | iso2!="SK"), absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C1.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male income) sortvar(TrustPeopleF age agesq i.male income) dec(3) replace ctitle((1)) 
areg depreindex_s TrustPeopleF age agesq i.male income $individualcontrols if imm1==1 & income!=. & (iso2!="RU" | iso2!="SK"), absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C1.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, ) nocons adjr2  keep(TrustPeopleF age agesq i.male income) sortvar(TrustPeopleF age agesq i.male income) dec(3) append ctitle((2)) 
areg depreindex_s TrustPeopleF age agesq i.male $aggregatecontrols if imm1==1 & income!=. & (iso2!="RU" | iso2!="SK"), absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C1.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male income) sortvar(TrustPeopleF age agesq i.male income) dec(3) append ctitle((3)) 
areg depreindex_s TrustPeopleF age agesq i.male income $individualcontrols $aggregatecontrols if imm1==1 & income!=. & (iso2!="RU" | iso2!="SK"), absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_C1.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male income) sortvar(TrustPeopleF age agesq i.male income) dec(3) append ctitle((4)) 

restore


