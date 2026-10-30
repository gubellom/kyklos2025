clear

local results $results
local datasets $datasets


use "`datasets'\cleaned_data.dta"

*name variables
label variable depreindex_s "Depression Index"
label variable TrustPeopleF "Social Trust (CO)"
label variable iso2F "Country-of-origin"


***** define global variables

global individualcontrols i.educ i.maritalstatus i.domicil i.employment religion i.citizen i.isco i.dscrgrp i.hampered 
global aggregatecontrols  democracy parliament e_gdppc v2pehealth religionF infantmortality  idv health 


***** GENERATE RESULTS FOR TABLE 4 and Figure D1 

areg depreindex_s c.TrustPeopleF age agesq i.male if imm1==1, absorb(intwaviso) vce(cluster iso2F)
boottest TrustPeopleF, cluster(iso2F) bootcluster(iso2F) boottype(wild) weighttype(webb) nograph level(95) nonull seed(1) reps(999999) 
summclust depreindex_s TrustPeopleF age agesq , fevar(male intwaviso)  cluster(iso2F) table addmeans jack rho(1) regtable
randcmd ((TrustPeopleF) areg depreindex_s TrustPeopleF age agesq i.male  if imm1==1, absorb(intwaviso) cluster(iso2F)), treatvars(TrustPeopleF) reps(10000) seed(1)

