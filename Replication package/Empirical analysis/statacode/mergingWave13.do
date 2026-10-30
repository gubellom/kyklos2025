clear
estimates clear
local results $results
local datasets $datasets

use "`datasets'\secondgenimm.dta"



* WWS TRUST DATA

merge m:1 isoF using "`datasets'\countryoriginwave3.dta"
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


** gen democracy var
replace democracy=1 if democracy>=0.5
replace democracy=0 if democracy<0.5


***** cultural and geographic distance

***geograpfic distance
geodist lat lon latO lon0, generate(geodistance) 


**** gen continent variable
encode continent, gen(continent2)


*** consider only non-missing observations

egen miss_count = rowmiss(TrustPeopleF age agesq educ male maritalstatus domicil employment citizen religion intwaviso iso2F  dscrgrp  intwaviso  depre fltsd flteeff slprl fltlnl cldgng wrhpp enjlf isco democracy parliament e_gdppc v2pehealth religionF infantmortality  idv health  continent2 geodistance)  
drop if miss_count>0 

*** drop countries that do not appears in at least 2 waves
drop if iso2=="AL" | iso2=="IT" | iso2=="IS" | iso2=="BG" |  iso2=="CY" | iso2=="UA" 

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

****** standardise trust variable
egen mTrustPeopleF= mean(TrustPeopleF)
egen sdTrustPeopleF=sd(TrustPeopleF)
gen TrustF= (TrustPeopleF-mTrustPeopleF)/sdTrustPeopleF
rename TrustPeopleF TrustPeopleF_NonSD
rename TrustF TrustPeopleF


save "`datasets'\cleaned_dataWave13.dta", replace

