## Using  the dataClean.R script

The dataClean.R script downloads data from 
the <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">UC Irvine Machine Learning Repository:Human Activity Recognition Using Smartphones Data Set</a> website and produces a clean dataset for further analysis.

The dataClean.R script performs the following:

* Downloads a zip file into the working directory named <b>UCI HAR Dataset</b>.

* Unzips the <b>UCI HAR Dataset</b>, which contains additional files and subfolders.  

* Merges relevant datasets and peforms a number of transformations to clean the data.  See the <b> CodeBook.md</b> for more detailed information about how the data were transformed.

* Produces a tab delimited *.txt file named <b>finalData.txt</b> into the working directory. 

In order for paths in the dataClean.R script to work properly, the <b>UCI HAR Dataset</b> folder structure must match the original structure in the zip file.  The unzip() function used in 
the dataClean.R script will ensure the correct folder structure.

<b>NOTE:</b>The <b>finalData.txt</b> contains headers, so when if reading the file into R using the read.table() function, make sure to set header to TRUE.








