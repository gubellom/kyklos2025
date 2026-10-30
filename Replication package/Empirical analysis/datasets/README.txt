The folder contains the cleaned datasets from Folder "Raw_data"

2a. "ESS367.dta" is the dataset with all the ESS waves appended.

2b "distance.dta" is the geographic distance dataset.

2c. "hofstede.dta" is the datasets with the Hofstede's cultural dimensions.

2d. "poliV.dta" is the cleaned V-dem dataset

2e. "countryoriginwave.dta" is the dataset with historical cultural values from the IVS including waves 1-7

2f. "countryoriginwave3.dta" is the dataset with historical cultural values from the IVS including waves 1-3

2g. "countryoriginwave47.dta" is the dataset with historical cultural values from the IVS including waves 4-7

These intermediated datasets are created in the folder Data. This folder contains the following raw data used to build the final datasets used in the analysis. The raw data are organised in five folders:

### 1a. Folder: ESS
This folder contains the three waves from the European Social Survey: "ESS3.dta," "ESS6.dta," and "ESS7.dta." The do.file "merging.do" appends the three waves to a unique file generating the final dataset "ESS367.dta," which also appears in the folder "datasets."

### 1b. Folder: Geographic distance 
This folder contains data about geographic distance. The "distance.do" file keeps information to compute the distance from the capital. It generates "distance.dta"

### 1c. Folder: Hofstede 
This folder contains the dataset with Hofstede's cultural dimensions. The "Hofstede.do" file transforms the data from .csv to .dta and assigns the different countries an ISO2 code.  It generates "hofstede.dta"

### 1d. Folder: V-Dem-CY-FullOthers_STATA_v13
This folder contains the V-Dem dataset. The "aggregatevar.do" file generates and keeps the variables of interest. It generates "poliV.dta"

### 1e. Folder: IVS second-generation immigrants 
The "country_origin.do" generates the historical values from the country of origin of second-generation immigrants used in the analysis. It also generates the dataset with social trust averaged by waves 1-3 and waves 4-7. It generates "countryoriginwave.dta", "countryoriginwave3.dta", "countryoriginwave47.dta"


