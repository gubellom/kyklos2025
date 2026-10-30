*clear
version 18


***generates paths
global statacode "Set directory in folder: Empirical analysis\statacode"
global results "Set directory in folder:  Empirical analysis\results"
global datasets "Set directory in folder: Empirical analysis\datasets"


local statacode $statacode
local results $results
local datasets $datasets

** Run do files
do "`statacode'\cleaning.do"
do "`statacode'\merging.do"
do "`statacode'\fulldataset.do"

***** main analysis
do "`statacode'\main_analysis.do"
do "`statacode'\robustness.do"
do "`statacode'\descriptive_statistics.do"
do "`statacode'\bootstrapping.do"

*** robustness checks: splitting by waves

* split waves 1 -3
do "`statacode'\mergingWave13.do"
* split waves 4-7 
do "`statacode'\mergingWave47.do"

***
* robustness  waves 1-3
do "`statacode'\robustnessWave13.do"
do "`statacode'\coefplot.do"
do "`statacode'\sample_size.do"


* robustness waves 4-7
do "`statacode'\robustnessWave47.do"



****robustness (Mother + father)
do "`statacode'\mother_plus_father.do"


