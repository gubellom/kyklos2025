
******
cd "set directory \Data\ESS\ESS merging"
**import and append all files
clear

use ESS3
append using ESS6, force
append using ESS7, force


save ESS367, replace

