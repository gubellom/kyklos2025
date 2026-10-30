cd "set directory Data\V-Dem-CY-FullOthers_STATA_v13"
clear
use V-Dem-CY-Full+Others-v13

gen democracy=1 if e_chga_demo==1
replace democracy=0 if e_chga_demo==0

renam e_peinfmor infantmortality 

global t v2pehealth e_gdppc infantmortality democracy country_name country_text_id year 
keep $t

keep if  year>=1950 & year<=1990

kountry country_text_id, from(iso3c) to(iso2c)
rename _ISO2C_ iso2
rename iso2 isoF

collapse v2pehealth e_gdppc infantmortality democracy, by(isoF)

save poliV.dta, replace
