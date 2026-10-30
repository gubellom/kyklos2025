# Replication: Inherited Social Trust and Depression Among Second-generation Immigrants
Stata Replication package for: "Inherited Social Trust and Depression Among Second-generation Immigrants", (Gubello, 2025)

Stata version: 18.

All the data sources are publicly available and cited in the main paper. Data must be downloaded to replicate the code. The package contains this README.txt file and four main folders:


## 1. FOLDER "Data" 

This folder contains information on how to download/clean the different raw data used to build the final datasets used in the analysis. The raw data are organised in five folders. Each folder do files to generated the intermediate datasets and README file explaining on how to download the raw data. A summary of the content of each folder can be found below:

### 1a. Folder: ESS
This folder contains the three waves from the European Social Survey: "ESS3.dta," "ESS6.dta," and "ESS7.dta." The do.file "merging.do" appends the three waves to a unique file generating the final dataset "ESS367.dta," which also appears in the folder "datasets."

### 1b. Folder: Geographic distance 
This folder contains data about geographic distance. The "distance.do" file keeps information to compute the distance from the capital.

### 1c. Folder: Hofstede 
This folder contains the dataset with Hofstede's cultural dimensions. The "Hofstede.do" file transforms the data from .csv to .dta and assigns the different countries an ISO2 code.

### 1d. Folder: V-Dem-CY-FullOthers_STATA_v13
This folder contains the V-Dem dataset. The "aggregatevar.do" file generates and keeps the variables of interest.

### 1e. Folder: IVS second-generation immigrants 
The "country_origin.do" generates the historical values from the country of origin of second-generation immigrants used in the analysis. It also generates the dataset with social trust averaged by waves 1-3 and waves 4-7



## 2. FOLDER "datasets"

The folder contains the cleaned datasets from Folder "Data"

2a. "ESS367.dta" is the dataset with all the ESS waves appended.

2b "distance.dta" is the geographic distance dataset.

2c. "hofstede.dta" is the datasets with the Hofstede's cultural dimensions.

2d. "poliV.dta" is the cleaned V-dem dataset

2e. "countryoriginwave.dta" is the dataset with historical cultural values from the IVS including waves 1-7

2f. "countryoriginwave3.dta" is the dataset with historical cultural values from the IVS including waves 1-3

2g. "countryoriginwave47.dta" is the dataset with historical cultural values from the IVS including waves 4-7

## 3. FOLDER "statacode" 

3a. "0Main.do" file, is the file that can run all the other do files.

3b. "cleaning.do" do file cleaning the ESS dataset

3c. "merging.do" merges the datasets from external sources to generate the second-generation immigrants dataset for the main analysis

3d. "fulldataset.do" generates results for: TABLE A1, FIGURE A2, TABLE A2, FIGURE A1, FIGURE 1, FIGURE A3.

3e. "descriptive_statistics.do" generates results for: FIGURE 4, FIGURE 3, TABLE A3.

3f. "bootstrapping.do" generates results for: TABLE 4, FIGURE D1.

3g. "mergingWave13.do" merges the datasets from external sources to generate the second-generation immigrants dataset with social trust from waves 1-3 from the IVS

3h. "mergingWave47.do"  merges the datasets from external sources to generate the second-generation immigrants dataset with social trust from waves 4-7 from the IVS

3i. "robustnessWave13.do" creates TABLE D1 (PANEL A)

3l. "coefplot.do" creates FIGURE D2

3m. "sample_size.do" creates TABLE D2

3n. "robustnessWave47.do" creates TABLE D1 (PANEL B)

3o. "mother_plus_father.do" creates TABLE B2, TABLE B3, TABLE B1, FIGURE B1.

3p. "robustness.do" creates TABLE C5, TABLE 3, FIGURE 5, TABLE C6 (PANEL A and PANEL B), TABLE C1

3q. "main_analysis.do" creates TABLE 1, TABLE 2, TABLE C2, TABLE C4, TABLE C3


## 4. FOLDER "results"

After setting the correct directories, the code will save the exported results in this folder.


