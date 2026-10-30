cd "set directory \Data\Geographic Distance"
clear
use geo_cepii

*** distance from the capital
keep if maincity==1
keep iso2 lat lon langoff_1 continent  

gen isoF=iso2
gen latO=lat
gen lon0=lon

save distance.dta, replace