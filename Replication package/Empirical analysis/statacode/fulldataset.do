
clear

local results $results
local datasets $datasets

use "`datasets'\fulldataset.dta"



******* GEN DEPENDENT VARIABLES

egen depreindex= rowtotal(depre fltsd flteeff slprl fltlnl cldgng wrhpp enjlf)
egen physprob= rowtotal(hltphsh hltphsd hltphsc hltphpf hltphpa hltphhc hltphhb hltphdi hltphbp hltphbn hltphal)

gen hampered=1 if physprob>0
replace hampered=0 if physprob==0

****standardise depression index
egen mdepreindex= mean(depreindex)
egen sddepreindex=sd(depreindex)
gen depreindex_s= (depreindex-mdepreindex)/sddepreindex


*name variables
label variable depreindex "CES-D8 scale"

* gen indicator of full sample size
gen fullsample=1

* gen indicator for native
gen native=1 if (facntr==1 & brncntr==1  & mocntr==1) 
replace native=0 if native==.

* first gen immigrant
gen firstgen=1 if (facntr==2 & brncntr==1) | (facntr==1 & brncntr==1 & mocntr==2) 
replace firstgen=0 if firstgen==.



keep iso2 year depreindex age agesq educ male maritalstatus domicil employment citizen religion dscrgrp depre fltsd flteeff slprl fltlnl cldgng wrhpp enjlf isco hampered native firstgen depreindex fullsample Employment* Domicil* Maritalstatus* Educ* idno

append using "`datasets'\cleaned_data.dta",  generate(newv) keep(depreindex iso2 year age agesq educ male maritalstatus domicil employment citizen religion dscrgrp depre fltsd flteeff slprl fltlnl cldgng wrhpp enjlf isco hampered imm1 Employment* Domicil* Maritalstatus* Educ* idno)

gen data=.
replace data=1 if native==1 //native
replace data=3 if firstgen==1 //first gen
replace data=2 if imm1==1 // second gen


**** summary all the individual data
preserve
keep if fullsample==1
replace depreindex=. if (missing(depre) | missing(fltsd) | missing(flteeff) | missing(slprl) | missing(fltlnl) | missing(cldgng) | missing(wrhpp) | missing(enjlf)) 
sum depreindex age agesq male citizen religion dscrgrp depre fltsd flteeff slprl fltlnl cldgng wrhpp enjlf isco hampered Employment* Domicil* Maritalstatus* Educ*
outreg2 using "`results'\TABLE_A1.xls", tex label sum(log) keep(depreindex age agesq male citizen religion dscrgrp depre fltsd flteeff slprl fltlnl cldgng wrhpp enjlf isco hampered Employment* Domicil* Maritalstatus* Educ*) sortvar(depreindex depre fltsd flteeff slprl fltlnl cldgng wrhpp enjlf age agesq male isco hampered  citizen religion dscrgrp Employment* Domicil* Maritalstatus* Educ*) eqkeep(N mean sd) replace
restore

preserve
keep if data==1
replace depreindex=. if (missing(depre) | missing(fltsd) | missing(flteeff) | missing(slprl) | missing(fltlnl) | missing(cldgng) | missing(wrhpp) | missing(enjlf)) 
sum depreindex age agesq male citizen religion dscrgrp depre fltsd flteeff slprl fltlnl cldgng wrhpp enjlf isco hampered Employment* Domicil* Maritalstatus* Educ*
outreg2 using "`results'\TABLE_A1.xls", tex label sum(log) keep(depreindex age agesq male citizen religion dscrgrp depre fltsd flteeff slprl fltlnl cldgng wrhpp enjlf isco hampered Employment* Domicil* Maritalstatus* Educ*) sortvar(depreindex depre fltsd flteeff slprl fltlnl cldgng wrhpp enjlf age agesq male isco hampered  citizen religion dscrgrp Employment* Domicil* Maritalstatus* Educ*) eqkeep(N mean sd) append
restore

preserve
keep if data==2
replace depreindex=. if (missing(depre) | missing(fltsd) | missing(flteeff) | missing(slprl) | missing(fltlnl) | missing(cldgng) | missing(wrhpp) | missing(enjlf)) 
sum depreindex age agesq male citizen religion dscrgrp depre fltsd flteeff slprl fltlnl cldgng wrhpp enjlf isco hampered Employment* Domicil* Maritalstatus* Educ*
outreg2 using "`results'\TABLE_A1.xls", tex label sum(log) keep(depreindex age agesq male citizen religion dscrgrp depre fltsd flteeff slprl fltlnl cldgng wrhpp enjlf isco hampered Employment* Domicil* Maritalstatus* Educ*) sortvar(depreindex depre fltsd flteeff slprl fltlnl cldgng wrhpp enjlf age agesq male isco hampered  citizen religion dscrgrp Employment* Domicil* Maritalstatus* Educ*) eqkeep(N mean sd) append
restore

****** compare differences by country

// Keep only the specified countries
keep if iso2=="BE" | iso2=="CH" | iso2=="CZ" | iso2=="DE" | iso2=="DK" | iso2=="EE" | iso2=="ES" | iso2=="FI" | iso2=="FR" | iso2=="GB" | iso2=="HU" | iso2=="IE" | iso2=="IL" | iso2=="LT" | iso2=="NL" | iso2=="NO" | iso2=="PL" | iso2=="PT" | iso2=="RU" | iso2=="SE" | iso2=="SI" | iso2=="SK"

gen deprenfullnative= depreindex  if fullsample==1 | data==3
gen deprenative= depreindex  if data==1
gen deprefull= depreindex  if fullsample==1 
gen depreimm= depreindex if data==2 
gen deprenfirst= depreindex  if data==3

label variable deprenfirst "First generation immigrants"
label variable deprenfullnative "Native + first generation immigrants"
label variable deprefull "Full sample"
label variable depreimm "Second-generation immigrants"
label variable deprenative "Natives"

**** consider depression indeces only if they answer all the questions

replace deprefull=. if (missing(depre) | missing(fltsd) | missing(flteeff) | missing(slprl) | missing(fltlnl) | missing(cldgng) | missing(wrhpp) | missing(enjlf)) & (fullsample==1 )
replace depreimm=. if missing(depre) | missing(fltsd) | missing(flteeff) | missing(slprl) | missing(fltlnl) | missing(cldgng) | missing(wrhpp) | missing(enjlf) & (depreimm==1)

// Generate mean and confidence intervals by immigrants for each country
ciplot deprenative depreimm, by(iso2) mlcolor(blue cranberry) mcolor(blue cranberry) msymbol(smtriangle smdiamond) msize(medsmall medsmall)  inclusive  ///
lcolor(orange red) ///
    graphregion(color(white)) ///
    title("") ///
    ytitle("Mean CES-D8 scale") xtitle("") ///
	subtitle("") ///
	note("") ///
   	legend(position(bottom) row(1))
graph export "`results'\FIGURE_A2_IMMIGRANTS.pdf", replace

	
// Generate mean and confidence intervals by fullsample for each country
ciplot deprefull depreimm, by(iso2) mlcolor(blue cranberry) mcolor(blue cranberry) msymbol(smtriangle smdiamond) msize(medsmall medsmall)  inclusive  ///
lcolor(orange red) ///
    graphregion(color(white)) ///
    title("") ///
    ytitle("Mean CES-D8 scale") xtitle("") ///
	subtitle("") ///
	note("") ///
   	legend(position(bottom) row(1))
graph export "`results'\FIGURE_A2_FULL_SAMPLE.pdf", replace


****************************
keep if data==1 | data==2

sort iso2
by iso2: egen avg_depreindex_s= mean(depreindex) if data==1
by iso2: egen avgd= max(avg_depreindex)

keep if data==2
merge m:m idno using "`datasets'\cleaned_data.dta", keepusing(TrustPeopleF)
drop if _merge!=3
drop _merge


*********** descriptive statistics aggregate variables CO
clear all

local results $results
local datasets $datasets


use "`datasets'\cleaned_data.dta"


label variable TrustPeopleF "Social trust (CO)"
label variable e_gdppc "GDP per capita (CO)"
label variable democracy "Democracy (CO)"
label variable religionF "Religiosity (CO)"
label variable idv "Individualism (CO)"
label variable v2pehealth "Health inequality (CO)"
label variable infantmortality "Infant mortality (CO)"
label variable health "Subjective health (CO)"
label variable parliament "Trust in parliament (CO)"


*** summaries

sum TrustPeopleF democracy parliament e_gdppc v2pehealth religionF infantmortality  idv health
outreg2 using "`results'\TABLE_A2.xls", tex label sum(log) keep(TrustPeopleF democracy parliament e_gdppc v2pehealth religionF infantmortality  idv health) sortvar(TrustPeopleF democracy parliament e_gdppc v2pehealth religionF infantmortality  idv health) eqkeep(N mean sd max min) 


******** depressive symptoms by wave

label define wavey  1 "2006-2007" 2 "2012-2013" 3 "2014-2015" 
label values wave wavey
graph bar depreindex, over(wave) ytitle("Average CES-D8 Depression Scale") 
graph export "`results'\FIGURE_A1.pdf", replace


******** depressive symptoms by wave

graph bar depreindex, over(iso2, sort(1) descending label(angle(0) labsize(medium))) ytitle("Average CES-D8 Depression Scale", size(medlarge))bar(1, color(midblue%70))
graph export "`results'\FIGURE_1.pdf", replace



****** social trust country of origin bars
graph hbar TrustPeopleF , over(isoF, sort(1) descending label(angle(0) labsize(tiny))) ///
    ytitle("Average social trust (country of origin)", size(small)) ysize(8)
graph export "`results'\FIGURE_A3.pdf", replace



