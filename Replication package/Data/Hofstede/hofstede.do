cd "set directory \Data\Hofstede"
clear
import excel "directory\Hofstede.xls", sheet("6 dimensions for website") firstrow


kountry country, from(other) stuck marker
rename _ISO3N_ tio3n
kountry tio3n, from(iso3n) to(iso2c)
rename _ISO2C_ iso2FH
keep if iso2FH!=""


save Hofstede.dta, replace