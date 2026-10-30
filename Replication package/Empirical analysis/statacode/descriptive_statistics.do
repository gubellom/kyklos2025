clear

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
label variable dscrgrp "Discriminated"
label variable hampered "Physically ill"


label variable health "Subjective health (CO)"
label variable democracy "Democracy (CO)"
label variable e_gdppc "GDP per-capita (CO)" 
label variable v2pehealth "Health Equality (CO)"
label variable religionF "Religiosity (CO)"
label variable infantmortality "Infant mortality per 1000 live births (CO)" 
label variable idv "Individualism (CO)" 






*** GEN TABULAR FOR TABLE A.3

tab iso2F


**** binscatter
** standardisisation
egen mppltrst= mean(ppltrst)
egen sdppltrst=sd(ppltrst)
gen Tppltrst= (ppltrst-mppltrst)/sdppltrst
rename ppltrst ppltrst_NonSD
rename Tppltrst ppltrst


**regression intergenerational transmission of trust using the binscatters
reg ppltrst TrustPeopleF if imm1==1, vce(cluster iso2F)
areg ppltrst TrustPeopleF if imm1==1, absorb(intwaviso) vce(cluster iso2F)


binsreg ppltrst TrustPeopleF, reghdfeopt(intwaviso) vce(cluster iso2F) xtitle("Social trust (country of origin)", size(large)) ytitle("Individual social trust", size(large)) polyreg(1) dotsplotopt(mcolor(green) msize(medlarge)) polyregplotopt(lcolor(dkorange) lwidth(thick)) randcut(1) at(mean) graphregion(color(white)) plotregion(color(white) margin(small))
graph export "`results'\FIGURE_3.pdf", replace

** regression between country of origin and depression index

collapse depreindex_s ppltrst TrustPeopleF, by(iso2)

generate pos = 3
replace pos = 9 if iso2=="NL" | iso2=="SK" | iso2=="PT" | iso2=="GB"
graph twoway (lfit depreindex_s TrustPeopleF, lcolor(orange%80) lwidth(thick)) (scatter depreindex_s TrustPeopleF, mlabv(pos) mlabel(iso2) mlabsize(small) msize(medsmall) mcolor(midblue%80) mlabcolor(black)), graphregion(color(white)) plotregion(color(white)) ytitle("Average depression (CES-D8 scale)" "among second-generation immigrants", size(medlarge)) xtitle("Average social trust in the country of origin" "among second-generation immigrants", size(medlarge)) legend(off) note("(b)", size(medlarge))
graph save "`results'\depression_co.gph", replace
graph export "`results'\depression_co.pdf", replace


drop pos
generate pos = 3
replace pos = 9 if iso2=="DE" | iso2=="SK" | iso2=="GB"
graph twoway (lfit depreindex_s ppltrst, lcolor(orange%80) lwidth(thick)) (scatter depreindex_s ppltrst, mlabv(pos) mlabel(iso2) mlabsize(small) msize(medsmall) mcolor(midblue%80) mlabcolor(black)), graphregion(color(white)) plotregion(color(white)) ytitle("Average depression (CES-D8 scale)" "among second-generation immigrants", size(medlarge)) xtitle("Average individual social trust" "among second-generation immigrants", size(medlarge)) legend(off) note("(a)", size(medlarge))
graph save "`results'\depression.gph", replace
graph export "`results'\depression.pdf", replace

graph combine "`results'\depression.gph" "`results'\depression_co.gph", graphregion(color(white)) plotregion(color(white) margin(small)) cols(2)
graph export "`results'\FIGURE_4.pdf", replace

reg depreindex_s TrustPeopleF
reg depreindex_s ppltrst




