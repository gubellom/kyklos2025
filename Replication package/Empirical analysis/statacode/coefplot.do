clear
estimates clear

local results $results
local datasets $datasets


use "`datasets'\cleaned_dataWave13.dta"
append using "`datasets'\cleaned_dataWave47.dta", generate(new1)
append using "`datasets'\cleaned_data.dta", generate(new2)

gen dataset=1 if new2==1 // original
replace dataset=2 if new1==0 // wave 1--3
replace dataset=3 if new1==1 // wave 4--7

*name variables
label variable depreindex_s "Depression Index"
label variable TrustPeopleF "Social trust (CO)"

global depvar depreindex_s depre_s flteeff_s slprl_s fltlnl_s fltsd_s cldgng_s wrhpp_s enjlf_s
sort dataset

****** PLOT coefficients ******

******* plot coefficient for social trust in country of origin by removing one country per time

*CES-D8 scale
levelsof dataset, local(levels_a)             
foreach i of local levels_a { 
gen TrustPeopleF_`i'= TrustPeopleF if dataset==`i'       
areg depreindex_s TrustPeopleF_`i'  age agesq i.male  if imm1==1 & dataset==`i',absorb(intwaviso) vce(cluster iso2F)
estimate store coeff`i'
}
label variable TrustPeopleF_1 "All waves"
label variable TrustPeopleF_2 "Waves 1-3"
label variable TrustPeopleF_3 "Waves 4-7"
coefplot (coeff*,  color(midblue%90) ciopts(color(midblue%90)) msymbol(O) msize(medium)), drop(_cons) level(99) horizontal  xline(0,  lpattern(solid) lcolor(red)) keep(TrustPeopleF_*) legend(off) title("CES-D8 scale")
graph save "`results'\waves_depreindex_s'.gph", replace
drop TrustPeopleF_*

*felt depressed
levelsof dataset, local(levels_b)             
foreach i of local levels_b { 
gen TrustPeopleF_`i'= TrustPeopleF if dataset==`i'       
areg depre_s TrustPeopleF_`i'  age agesq i.male  if imm1==1 & dataset==`i',absorb(intwaviso) vce(cluster iso2F)
estimate store coeff`i'
}
label variable TrustPeopleF_1 "All waves"
label variable TrustPeopleF_2 "Waves 1-3"
label variable TrustPeopleF_3 "Waves 4-7"
coefplot (coeff*,  color(midblue%90) ciopts(color(midblue%90)) msymbol(O) msize(medium)), drop(_cons) level(99) horizontal  xline(0,  lpattern(solid) lcolor(red)) keep(TrustPeopleF_*) legend(off) title("Felt depressed") 
graph save "`results'\waves_depre_s.gph", replace
drop TrustPeopleF_*

* Felt everything did as effort
levelsof dataset, local(levels_c)             
foreach i of local levels_c { 
gen TrustPeopleF_`i'= TrustPeopleF if dataset==`i'       
areg flteeff_s TrustPeopleF_`i'  age agesq i.male  if imm1==1 & dataset==`i',absorb(intwaviso) vce(cluster iso2F)
estimate store coeff`i'
}
label variable TrustPeopleF_1 "All waves"
label variable TrustPeopleF_2 "Waves 1-3"
label variable TrustPeopleF_3 "Waves 4-7"
coefplot (coeff*,  color(midblue%90) ciopts(color(midblue%90)) msymbol(O) msize(medium)), drop(_cons) level(95) horizontal  xline(0,  lpattern(solid) lcolor(red)) keep(TrustPeopleF_*) legend(off) title("Felt everything did as effort") 
graph save "`results'\waves_flteeff_s.gph", replace
drop TrustPeopleF_*

* Sleep was restless
levelsof dataset, local(levels_d)             
foreach i of local levels_d { 
gen TrustPeopleF_`i'= TrustPeopleF if dataset==`i'       
areg slprl_s TrustPeopleF_`i'  age agesq i.male  if imm1==1 & dataset==`i',absorb(intwaviso) vce(cluster iso2F)
estimate store coeff`i'
}
label variable TrustPeopleF_1 "All waves"
label variable TrustPeopleF_2 "Waves 1-3"
label variable TrustPeopleF_3 "Waves 4-7"
coefplot (coeff*,  color(midblue%90) ciopts(color(midblue%90)) msymbol(O) msize(medium)), drop(_cons) level(95) horizontal  xline(0,  lpattern(solid) lcolor(red)) keep(TrustPeopleF_*) legend(off) title("Sleep was restless")
graph save "`results'\waves_slprl_s.gph", replace
drop TrustPeopleF_*


* Felt lonely
levelsof dataset, local(levels_e)             
foreach i of local levels_e { 
gen TrustPeopleF_`i'= TrustPeopleF if dataset==`i'       
areg fltlnl_s TrustPeopleF_`i'  age agesq i.male  if imm1==1 & dataset==`i',absorb(intwaviso) vce(cluster iso2F)
estimate store coeff`i'
}
label variable TrustPeopleF_1 "All waves"
label variable TrustPeopleF_2 "Waves 1-3"
label variable TrustPeopleF_3 "Waves 4-7"
coefplot (coeff*,  color(midblue%90) ciopts(color(midblue%90)) msymbol(O) msize(medium)), drop(_cons) level(95) horizontal  xline(0,  lpattern(solid) lcolor(red)) keep(TrustPeopleF_*) legend(off) title("Felt lonely")  
graph save "`results'\waves_fltlnl_s.gph", replace
drop TrustPeopleF_*

* Felt sad
levelsof dataset, local(levels_f)             
foreach i of local levels_f { 
gen TrustPeopleF_`i'= TrustPeopleF if dataset==`i'       
areg fltsd_s TrustPeopleF_`i'  age agesq i.male  if imm1==1 & dataset==`i',absorb(intwaviso) vce(cluster iso2F)
estimate store coeff`i'
}
label variable TrustPeopleF_1 "All waves"
label variable TrustPeopleF_2 "Waves 1-3"
label variable TrustPeopleF_3 "Waves 4-7"
coefplot (coeff*,  color(midblue%90) ciopts(color(midblue%90)) msymbol(O) msize(medium)), drop(_cons) level(99) horizontal  xline(0,  lpattern(solid) lcolor(red)) keep(TrustPeopleF_*) legend(off) title("Felt sad") 
graph save "`results'\waves_fltsd_s.gph", replace
drop TrustPeopleF_*

* Could not get going
levelsof dataset, local(levels_g)             
foreach i of local levels_g { 
gen TrustPeopleF_`i'= TrustPeopleF if dataset==`i'       
areg cldgng_s TrustPeopleF_`i'  age agesq i.male  if imm1==1 & dataset==`i',absorb(intwaviso) vce(cluster iso2F)
estimate store coeff`i'
}
label variable TrustPeopleF_1 "All waves"
label variable TrustPeopleF_2 "Waves 1-3"
label variable TrustPeopleF_3 "Waves 4-7"
coefplot (coeff*,  color(midblue%90) ciopts(color(midblue%90)) msymbol(O) msize(medium)), drop(_cons) level(99) horizontal  xline(0,  lpattern(solid) lcolor(red)) keep(TrustPeopleF_*) legend(off) title("Could not get going") 
graph save "`results'\waves_cldgng_s.gph", replace
drop TrustPeopleF_*


* Were unhappy
levelsof dataset, local(levels_h)             
foreach i of local levels_h { 
gen TrustPeopleF_`i'= TrustPeopleF if dataset==`i'       
areg wrhpp_s TrustPeopleF_`i'  age agesq i.male  if imm1==1 & dataset==`i',absorb(intwaviso) vce(cluster iso2F)
estimate store coeff`i'
}
label variable TrustPeopleF_1 "All waves"
label variable TrustPeopleF_2 "Waves 1-3"
label variable TrustPeopleF_3 "Waves 4-7"
coefplot (coeff*,  color(midblue%90) ciopts(color(midblue%90)) msymbol(O) msize(medium)), drop(_cons) level(99) horizontal  xline(0,  lpattern(solid) lcolor(red)) keep(TrustPeopleF_*) legend(off) title("Were unhappy") 
graph save "`results'\waves_wrhpp_s.gph", replace
drop TrustPeopleF_*

* Were unhappy
levelsof dataset, local(levels_i)             
foreach i of local levels_i { 
gen TrustPeopleF_`i'= TrustPeopleF if dataset==`i'       
areg enjlf_s TrustPeopleF_`i'  age agesq i.male  if imm1==1 & dataset==`i',absorb(intwaviso) vce(cluster iso2F)
estimate store coeff`i'
}
label variable TrustPeopleF_1 "All waves"
label variable TrustPeopleF_2 "Waves 1-3"
label variable TrustPeopleF_3 "Waves 4-7"
coefplot (coeff*,  color(midblue%90) ciopts(color(midblue%90)) msymbol(O) msize(medium)), drop(_cons) level(99) horizontal  xline(0,  lpattern(solid) lcolor(red)) keep(TrustPeopleF_*) legend(off) title("Did not enjoy life")  
graph save "`results'\waves_enjlf_s.gph", replace
drop TrustPeopleF_*


graph combine "`results'\waves_depreindex_s'.gph" "`results'\waves_depre_s.gph" "`results'\waves_flteeff_s.gph" "`results'\waves_slprl_s.gph" "`results'\waves_fltsd_s.gph" "`results'\waves_cldgng_s.gph"  "`results'\waves_wrhpp_s.gph" "`results'\waves_enjlf_s.gph", graphregion(color(white)) plotregion(color(white) margin(small)) rows(4) cols(2) 
graph export "`results'\FIGURE_D2.pdf", replace


