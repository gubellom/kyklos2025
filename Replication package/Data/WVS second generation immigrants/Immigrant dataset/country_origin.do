cd "set directory\Data\WVS second generation immigrants\Immigrant dataset"

clear
use IVS

decode S003, gen(country)
rename S009 iso


**** aggregate countries to compare with ESS

replace iso="CY" if iso=="CY-TCC"
replace iso="GB" if iso=="GB-GBN" | iso=="GB-NIR" | iso=="NIR"
replace iso="XK" if iso=="RS-KM"


**** social trust

rename A165 TrustPeopleF
replace TrustPeopleF=0 if TrustPeopleF==2

* trust in parliament
rename E069_07 parliament

* religion in country of origin

gen religionF=1 if A006==1 | A006==2
replace religionF=0 if A006==3 | A006==4

*subjective health
rename A009 health


***** create waves

gen wave2=.
replace wave2=1 if S002EVS==1 | S002==1
replace wave2=2 if S002EVS==2 | S002==2
replace wave2=3 if S002==3
replace wave2=4 if S002EVS==3 | S002==4
replace wave2=5 if S002EVS==4 | S002==5
replace wave2=6 if S002==6
replace wave2=7 if S002EVS==6 | S002==7


******* creation of dataset for main analysis

preserve
collapse (mean) TrustPeopleF parliament religionF health (sd) TrustPeopleFsd=TrustPeopleF religionFsd=religionF parliamentsd=parliament healthsd=health, by(iso)
rename iso isoF
gen iso2=isoF
gen TrustPeopleFO=TrustPeopleF
save countryorigin.dta, replace
restore


******* only trust variable
*waves 1-3
preserve
sort iso
bysort iso: egen Trustmean=mean(TrustPeopleF) if S020<=1998
bysort iso: egen maxTrustmean= max(Trustmean)
collapse (mean) maxTrustmean parliament religionF health (sd) religionFsd=religionF parliamentsd=parliament healthsd=health, by(iso)
rename iso isoF
gen iso2=isoF
rename maxTrustmean TrustPeopleF
gen TrustPeopleFO=TrustPeopleF
save countryoriginwave3.dta, replace
restore

*waves 4-7
preserve
sort iso
bysort iso: egen Trustmean=mean(TrustPeopleF) if S020>1999
bysort iso: egen maxTrustmean= max(Trustmean)
collapse (mean) maxTrustmean parliament religionF health (sd) religionFsd=religionF parliamentsd=parliament healthsd=health, by(iso)
rename iso isoF
gen iso2=isoF
rename maxTrustmean TrustPeopleF
gen TrustPeopleFO=TrustPeopleF
save countryoriginwave47.dta, replace
restore

