clear

local results $results
local datasets $datasets

use "`datasets'\fulldataset.dta"

************** ************** ************** **************  
************** ************** ************** ************** 
************** COUNTRY OF ORIGINS  ************* *****
************** ************** ************** ************** 
************** ************** ************** ************** 

**** define country of origins of parents


replace fbrncntb="" if fbrncntb=="02" | fbrncntb=="03" | fbrncntb=="04" | fbrncntb=="06" | fbrncntb=="66" | fbrncntb=="88" | fbrncntb=="99" | fbrncntb=="77"
replace mbrncntb="" if mbrncntb=="01" | mbrncntb=="02" | mbrncntb=="03" | mbrncntb=="04" | mbrncntb=="06" | mbrncntb=="66" | mbrncntb=="88" | mbrncntb=="99" | mbrncntb=="77"
replace mbrncnt="" if mbrncnt=="01" | mbrncnt=="02" | mbrncnt=="03" | mbrncnt=="04" | mbrncnt=="06" | mbrncnt=="66" | mbrncnt=="88" | mbrncnt=="99" | mbrncnt=="77"
replace fbrncnt="" if fbrncnt=="02" | fbrncnt=="03" | fbrncnt=="04" | fbrncnt=="06" | fbrncnt=="66" | fbrncnt=="88" | fbrncnt=="99" | fbrncnt=="77"



*** Gen variables for country of origin of father and country of origin of mother

gen fathercountry=""
replace fathercountry=fbrncntb if fbrncnt==""
replace fathercountry=fbrncnt if fbrncntb==""

gen mothercountry=""
replace mothercountry=mbrncnt if mbrncntb==""
replace mothercountry=mbrncntb if mbrncnt=="" 



* consider mother and if mother is native consirer father

gen imm1=1 if (mocntr==2 & brncntr==1) | (mocntr==1 & brncntr==1 & facntr==2) 

gen isoF=""
replace isoF=mothercountry if mocntr==2
replace isoF=fathercountry if mocntr==1 & facntr==2 
replace imm1=0 if imm1==.

***** Merging with the other datasets


* WWS TRUST DATA

merge m:1 isoF using "`datasets'\countryorigin.dta"
drop if _merge!=3
drop _merge
encode isoF, gen(iso2F)


merge m:1 isoF using "`datasets'\poliV.dta"
drop if _merge!=3
drop _merge


*** geo distance
merge m:1 isoF using "`datasets'\distance.dta", keepusing(lat lon continent)
drop if _merge!=3
drop _merge

merge m:1 iso2 using "`datasets'\distance.dta", keepusing(latO lon0)
drop if _merge!=3
drop _merge
*** cultural distance from main city 
drop TrustPeopleFO
merge m:1 iso2 using "`datasets'\countryorigin.dta", keepusing(TrustPeopleFO)
drop if _merge!=3
drop _merge

****global preferences database


merge m:1 isoF using "`datasets'\Hofstede.dta", force
drop if _merge!=3
drop _merge


** GEN democracy

replace democracy=1 if democracy>=0.5
replace democracy=0 if democracy<0.5

/*
***** cultural and geographic distance

***geograpfic distance
geodist lat lon latO lon0, generate(geodistance) 

**** gen continent variable
encode continent, gen(continent2)
*/

*** consider only non-missing observations

egen miss_count = rowmiss(TrustPeopleF age agesq educ male maritalstatus domicil employment citizen religion intwaviso iso2F  dscrgrp  intwaviso  depre fltsd flteeff slprl fltlnl cldgng wrhpp enjlf isco democracy parliament e_gdppc v2pehealth religionF infantmortality  idv health )  
drop if miss_count>0 //continent2 geodistance

*** drop countries that do not appears in at least 2 waves
drop if iso2=="AT" | iso2=="IT" | iso2=="IS" | iso2=="BG" |  iso2=="CY" | iso2=="UA" 

******* GEN DEPENDENT VARIABLES

egen depreindex= rowtotal(depre fltsd flteeff slprl fltlnl cldgng wrhpp enjlf)

egen physprob= rowtotal(hltphsh hltphsd hltphsc hltphpf hltphpa hltphhc hltphhb hltphdi hltphbp hltphbn hltphal)

gen hampered=1 if physprob>0
replace hampered=0 if physprob==0

keep if imm1==1


****standardise all the depression symptoms
global symptoms depre fltsd flteeff slprl fltlnl cldgng wrhpp enjlf

foreach x in $symptoms{

egen m_`x'= mean(`x')
egen sd_`x'=sd(`x')
gen `x'_s= (`x'-m_`x')/sd_`x'	
	
}

****standardise depression index
egen mdepreindex= mean(depreindex)
egen sddepreindex=sd(depreindex)
gen depreindex_s= (depreindex-mdepreindex)/sddepreindex

****** standardise trust variables
*** second generation immigrant trust in country of origin
egen mTrustPeopleF= mean(TrustPeopleF)
egen sdTrustPeopleF=sd(TrustPeopleF)
gen TrustF= (TrustPeopleF-mTrustPeopleF)/sdTrustPeopleF
rename TrustPeopleF TrustPeopleF_NonSD
rename TrustF TrustPeopleF


*******regression results with mother plus father

*name variables
label variable depreindex_s "Depression Index"
label variable TrustPeopleF "Social trust (CO)"





***** Main results 1
areg depreindex_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_B3_mother.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) replace ctitle((1)) 
areg depre_s c.TrustPeopleF age agesq i.male  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_B3_mother.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((2)) 
areg flteeff_s c.TrustPeopleF age agesq i.male  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_B3_mother.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((3)) 
areg slprl_s c.TrustPeopleF age agesq i.male   if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_B3_mother.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((4)) 
areg fltlnl_s c.TrustPeopleF age agesq i.male  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_B3_mother.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((5)) 
areg fltsd_s c.TrustPeopleF age agesq i.male  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_B3_mother.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((6)) 
areg cldgng_s c.TrustPeopleF age agesq i.male  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_B3_mother.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((7)) 
areg wrhpp_s c.TrustPeopleF age agesq i.male  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_B3_mother.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((8)) 
areg enjlf_s c.TrustPeopleF age agesq i.male  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_B3_mother.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((9)) 




***** define global variables

global individualcontrols i.educ i.maritalstatus i.domicil i.employment religion i.isco i.citizen i.dscrgrp i.hampered 
global aggregatecontrols  i.democracy parliament e_gdppc v2pehealth religionF infantmortality  idv health

***** Main results

areg depreindex_s c.TrustPeopleF age agesq i.male  if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_B2.xls", tex label addtext(Country-Wave FE, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) replace ctitle((1)) 
areg depreindex_s TrustPeopleF age agesq i.male  $individualcontrols if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_B2.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, ) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((2))
areg depreindex_s TrustPeopleF age agesq i.male   $aggregatecontrols if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_B2.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, NO, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((3))  
areg depreindex_s TrustPeopleF age agesq i.male  $individualcontrols $aggregatecontrols if imm1==1, absorb(intwaviso) vce(cluster iso2F)
outreg2 using "`results'\TABLE_B2.xls", tex label addtext(Country-Wave FE, YES, Individual Controls, YES, Country-of-origin Controls, YES,) nocons adjr2  keep(TrustPeopleF age agesq i.male) sortvar(TrustPeopleF age agesq i.male) dec(3) append ctitle((4)) 




******* intergenerational transmission of trust

**** binscatter
** standardise trust individual variables
*** second generation immigrant trust in country of origin
egen mppltrst= mean(ppltrst)
egen sdppltrst=sd(ppltrst)
gen Tppltrst= (ppltrst-mppltrst)/sdppltrst
rename ppltrst ppltrst_NonSD
rename Tppltrst ppltrst


**regression intergenerational transmission of trust using the binscatters
reg ppltrst TrustPeopleF if imm1==1, vce(cluster iso2F)
areg ppltrst TrustPeopleF if imm1==1, absorb(intwaviso) vce(cluster iso2F)

binsreg ppltrst TrustPeopleF, reghdfeopt(intwaviso) vce(cluster iso2F) xtitle("Social trust (country of origin)", size(large)) ytitle("Individual social trust", size(large)) polyreg(1) dotsplotopt(mcolor(green) msize(medlarge)) polyregplotopt(lcolor(dkorange) lwidth(thick)) randcut(1) at(mean) graphregion(color(white)) plotregion(color(white) margin(small))
graph export "`results'\FIGURE_B1_binscattermother.pdf", replace

*** GEN TABULAR FOR TABLE B.1

tab iso2F

