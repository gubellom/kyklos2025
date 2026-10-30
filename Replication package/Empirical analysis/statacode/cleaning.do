clear

local results $results
local datasets $datasets

use "`datasets'\ESS367.dta"


***** rename a few variables
drop age
rename (agea hinctnta gndr eduyrs)  (age income sex eduyrs)
encode cntry, gen(country)
gen agesq= age^2
rename cntry iso2
encode iso2, gen(iso)
rename inwyye year
encode name, gen(wave)


**** gen isco08 for wave 3
iscogen job08 = isco08(iscoco), from(isco88)
replace isco08=job08 if wave==1


*** iso08 by submajor groups
tostring isco08, gen(my_string_variable) format(%07.0f)
gen first_two_digits2 =  substr(my_string_variable, 4, .) 
gen first_two_digits =  substr(first_two_digits2, 1, strlen(first_two_digits2) - 3) 

gen var0=first_two_digits2
gen var1=my_string_variable
gen var2=first_two_digits

destring first_two_digits, generate(isco)


***** father levels of education
gen educf=.
replace educf=1 if eiscedf==1
replace educf=2 if eiscedf ==2 
replace educf=3 if eiscedf >=3 & eiscedf<=4
replace educf=4 if eiscedf ==5 
replace educf=5 if eiscedf >=6 & eiscedf<=7 
replace educf=. if eiscedf==8

***** mother levels of education


gen educm=.
replace educm=1 if eiscedm==1
replace educm=2 if eiscedm ==2 
replace educm=3 if eiscedm >=3 & eiscedm<=4
replace educm=4 if eiscedm ==5 
replace educm=5 if eiscedm >=6 & eiscedm<=7 
replace educm=. if eiscedm==8


***** discrimination
replace dscrgrp=0 if dscrgrp==2

***** creation of variables from different datasets
****

rename mnactic emplstatus
replace emplstatus=3 if emplstatus==4
replace emplstatus=9  if emplstatus==7

******
***married variable MARRIED
replace maritalb=1 if maritalb==2
replace maritalb=3 if maritalb==4

***** variable marsts
replace marsts=1 if marsts==2
replace marsts=3 if marsts==4

***** variable marital status (GB)
replace marstgb=1 if marstgb==2
replace marstgb=3 if marstgb==4

***** variable marital status (IE)
replace marstie=1 if marstie==2
replace marstie=3 if marstie==4 | marstie==7

***** variable marital status (FI)
replace marstfi=1 if marstfi==2
replace marstfi=3 if marstfi==4

gen maritala2=.
replace maritala2=1 if maritala==1 | maritala==2
replace maritala2=3 if maritala==3 | maritala==4 | maritala==5  | maritala==7  | maritala==8
replace maritala2=5 if maritala==6
replace maritala2=6 if maritala==9

gen married2=1 if maritalb==1 | maritala2==1 | marsts==1 | marstgb==1 | marstie==1 | marstfi==1
replace married2=3 if maritalb==3 | maritala2==2 | marsts==2 | marstgb==2 | marstie==2 | marstfi==2
replace married2=5 if maritalb==5 | maritala2==3 | marsts==3 | marstgb==3 | marstie==3 | marstfi==3
replace married2=6 if maritalb==6 | maritala2==4 | marsts==4 | marstgb==4 | marstie==4 | marstfi==4
rename married2 married

**** use marital for wave 2 and 3

gen educ=.
replace educ=1 if eisced==1
replace educ=2 if eisced ==2 
replace educ=3 if eisced >=3 & eisced<=4
replace educ=4 if eisced ==5 
replace educ=5 if eisced >=6 & eisced<=7 

replace ctzcntr=0 if ctzcntr==2
replace sex=0 if sex==2

rename (ctzcntr emplstatus married sex rlgdgr) (citizen employment maritalstatus male religion)


**** label variables 

label variable age "Age"
label variable agesq "Age (squared)"
label variable male "Male"
label variable citizen "Citizen"
label define citizen  1 "Citizen" 0 "Noncitizen" 
label variable hhmmb "Household members"
label variable religion "Religiosity"
label define domicil1  1 "A big city" 2 "Suburbs or outskirts of big city" 3 "Town or small city" 4 "Country village" 5 "Farm or home in countryside"
label values domicil domicil1
label define marital3 1 "Married" 3 "Separated" 5 "Widowed" 6 "None of these" 
label values maritalstatus marital3
label define empl3 1 "Paid work" 2 "Education" 3 "Unemployed" 5 "Permanently sick or disabled"  6 "Retired" 8 "Housework" 9 "Other"
label values employment empl3
label define quintile  1 "Income Decile 1" 2 "Income Decile 2" 3 "Income Decile 3" 4 "Income Decile 4" 5 "Income Decile 5" 6 "Income Decile 6" 7 "Income Decile 7" 8 "Income Decile 8" 9 "Income Decile 9" 10 "Income Decile 10"
label values income quintile
label variable ppltrst "Generalised Trust"
label variable income "Income"
label define leveleduc 1 "Less than lower secondary education (ISCED 0-1) " 2 "Lower secondary education completed (ISCED 2) " 3 "Upper secondary education completed (ISCED 3)" 4 "Post-secondary non-tertiary education completed (ISCED 4)" 5 "Tertiary education completed (ISCED 5-6)"
label values educ leveleduc


tabulate  maritalstatus, generate(Maritalstatus)
tabulate domicil, generate(Domicil)
tabulate employment, generate(Employment) 
tabulate educ, generate(Educ)

label variable Employment1 "Paid work"
label variable Employment2 "Education"
label variable Employment3 "Unemployed"
label variable Employment4 "Permanently sick or disabled"
label variable Employment5 "Retired"
label variable Employment6 "Housework"
label variable Employment7 "Other"
label variable Domicil1 "A big city"
label variable Domicil2 "Suburbs or outskirts of big city"
label variable Domicil3 "Town or small city"
label variable Domicil4 "Country village"
label variable Domicil5 "Farm or home in countryside"
label variable Maritalstatus1 "Married"
label variable Maritalstatus2 "Separated"
label variable Maritalstatus3 "Widowed"
label variable Maritalstatus4 "None of these"
label variable Educ1 "Less than lower secondary education (ISCED 0-1) "
label variable Educ2 "Lower secondary education completed (ISCED 2) "
label variable Educ3 "Upper secondary education completed (ISCED 3)"
label variable Educ4 "Post-secondary non-tertiary education completed (ISCED 4)"
label variable Educ5 "Tertiary education completed (ISCED 5-6)"


**** rename iso countryESS
rename iso countryESS
decode countryESS, gen(countryESS_s)

*generate the interaction term wave country 
egen intwaviso= group(wave countryESS)


************** ************** ************** **************  
************** ************** ************** ************** 
************** mental health variables  ************* *****
************** ************** ************** ************** 
************** ************** ************** ************** 

*rename health

rename health sjhealth

****** Mental health questions
rename fltdpr depre

***reverse for the index
revrs wrhpp enjlf, replace

save "`datasets'\fulldataset.dta", replace


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

***** 

* THIS CONSIDER father and if father is native consider mother
gen imm1=1 if (facntr==2 & brncntr==1) | (facntr==1 & brncntr==1 & mocntr==2) 

gen isoF=""
replace isoF=fathercountry if facntr==2
replace isoF=mothercountry if facntr==1 & mocntr==2 
replace imm1=0 if imm1==.




save "`datasets'\secondgenimm.dta", replace



