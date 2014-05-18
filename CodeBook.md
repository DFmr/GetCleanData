# CodeBook for finalData.txt
## Introduction

The finalData.txt was produced from the <a href="http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones">UC Irvine Machine Learning Repository:Human Activity Recognition Using Smartphones Data Set</a> website.  The data was created as a project for Coursera's <b> Getting and Cleaning Data</b> course.

The overall goal of the project was to create a clean dataset.  Specifically, the purpose of the assignment was to:

* download the data;
* merge separate training and testing datasets;
* provide human, readable variable names;
* extract only measurements for the mean and standard deviation;
* summarize the mean of these meaurements for each subject and activity group; 
* provide a script and clean dataset;
* provide README.md and CodeBook.md for the above work.

## Background on the Data

The data comes from the <b>Irvine Machine Learning Repository</b> webiste on <b>Human Activity Recognition Using Smartphones</b>.  

The data concerns an experiment whereby 30 subjects performed six tasks (i.e. walking, walking upstairs, walking downstairs, standing, lying, and sitting) while wearing a Samsung Galaxy S II smartphone on their  waist.  The study captured measurements from the device to see how smartphones might be used to determine the wearer's daily physical activity.  The study uses the device's accelerometer and gyroscope  to obtain meaures of linear acceleration and angular velocity, each for 3-axial planes (i.e., x,y,z).

The study randomly split the data into study and test datasets.

## Data Transformations

The sections below discuss the data transformations performed on the raw data download.  The <b>run_analysis.R script</b> performs the data transformations and creates the final dataset.  Information on running the <b>run_analysis.R script</b> can be found in the <b>README.md</b>.

### Merging of Data

The data came in a zip file named <b>UCI HAR Dataset</b>.  The file was downloaded and unzipped in the R script.  The unzipped folder contained text files with the measurement names (<b>feature.txt</b>), the six activity names and associated 1-6 code (<b>activity.txt</b>).

Data  for the  training and test datasets were contained in two separate subfolder -- <b>test</b> and <b>train</b>. Each file contained a text files with the <b>subject_train or test</b>, the activity <b>Y_train or test</b>, and the measurements <b>X_train or test</b>.

The script combined these datasets into one dataframe.  First, the script bound (or appended) the subject number, activity, and measuremnt columns for both the test and training sets.  The script then appended test and training dataframe rows to create a single dataframe with both test and training records.  Finally, the script merged <b>activity.txt</b> with this single dataframe using the activity code.  This last merge provided a column with text names for each of the six activities.

### Renaming Variables

The variables contained a number of symbols that are illegal for some R operations, and are difficult to read.  The script renames these variables by removing the following symbols: "()","_", and ",".  The script also made the variables names in all lowercase.

Comparing the description of variables in the data set (found in<b> feature.info.txt</b>) showed that some of the variables had extra "body" strings (i.e., they read "bodybody").   The extra "body" string was removed.  

The activity descriptions also included the text code "laying".  From the description of experiment, it sounded like "lying" would be a more appropriate description.  The script changes the text "laying" into "lying".

### Selection of Measurement

The assignment asked for variables of the mean and standardard deviation of each measurement. To select these variables, the script selects column names with the string "mean" and "std".  This selected columns that took the mean and standard deviation of accelerometer and gyroscope measurements on the x,y, and  z axials.  

The selection also included measurements for meanFreq().  These were not included in the final set of variables because they were interperted as a measure used to obtain mean, not a measurement of mean itself.  Variables containing the term "mean" in the angle() variables were also removed -- these were interpeted as calculations based on the mean measurements, but not mean measurements themselves.  In total, 66 measurements were selected.  These are summarized im the finalDataset section below.

### Summarizing Data

The 66 mean and standard deviation measurements were then averaged by subject and activity using the aggregate() in R.

## finalDataset

The script writes the data above into a tab delimited text file named <b>finalData.txt</b>.  The file contains 180 observations and 69 variables.  The variables are described below.

### Variables

The variables in the <b>finalData.txt</b> are:

<ol>
<li><b>actvity</b>: character field with activity of the user (i.e. "walking", "walking upstairs","walking downstairs","sitting","standing","lying")
<li><b>subject</b>: integer field with subject number (1-30)
<li><b>actvitycode</b>: integer with a numeric code for each activity (i.e.,1="walking", 2="walking upstairs",3="walking downstairs",4="sitting",5="standing",6="lying")
<li><b>tbodyaccmeanx:</b>: numeric field describing mean time signal body accleration on x-axis
<li><b>tbodyaccmeany:</b>: numeric field describing mean time signal body accleration on y-axis
<li><b>tbodyaccmeanz:</b>: numeric field describing mean time signal body accleration on z-axis
<li><b>tgravityaccmeanx:</b>: numeric field describing mean time signal gravity accleration on x-axis
<li><b>tgravityaccmeany:</b>: numeric field describing mean time signal gravity accleration on y-axis
<li><b>tgravityaccmeanz:</b>: numeric field describing mean time signal gravity accleration on z-axis
<li><b>tbodyaccjerkmeanx:</b>: numeric field describing mean time signal body accleration jerk on x-axis
<li><b>tbodyaccjerkmeany:</b>: numeric field describing mean time signal body accleration jerk on y-axis
<li><b>tbodyaccjerkmeanz:</b>: numeric field describing mean time signal body accleration jerk on z-axis
<li><b>tbodygyromeanx:</b>: numeric field describing mean time signal angular velocity on x-axis
<li><b>tbodygyromeany:</b>: numeric field describing mean time signal angular velocity on y-axis
<li><b>tbodygyromeanz:</b>: numeric field describing mean time signal angular velocity on z-axis
<li><b>tbodygyrojerkmeanx:</b>: numeric field describing mean time signal angular velocity jerk on x-axis
<li><b>tbodygyrojerkmeany:</b>: numeric field describing mean time signal angular velocity jerk on y-axis
<li><b>tbodygyrojerkmeanz:</b>: numeric field describing mean time signal angular velocity jerk on z-axis
<li><b>tbodyaccmagmean:</b>: numeric field describing mean magnitude of time signal body accleration
<li><b>tgravityaccmagmean:</b>: numeric field describing mean magnitude of time signal gravity accleration
<li><b>tbodyaccjerkmagmean:</b>: numeric field describing mean magnitude of time signal body accleration jerk
<li><b>tbodygyromagmean:</b>: numeric field describing mean magnitude of time signal angular velocity
<li><b>tbodygyrojerkmagmean:</b>: numeric field describing mean magnitude of time signal angular velocity jerk
<li><b>fbodyaccmeanx:</b>: numeric field describing mean frequecy domain signal body accleration on x-axis
<li><b>fbodyaccmeany:</b>: numeric field describing mean frequecy domain signal body accleration on y-axis
<li><b>fbodyaccmeanz:</b>: numeric field describing mean frequecy domain signal body accleration on z-axis
<li><b>fbodyaccjerkmeanx:</b>: numeric field describing mean frequecy domain signal body accleration jerk on x-axis
<li><b>fbodyaccjerkmeany:</b>: numeric field describing mean frequecy domain signal body accleration jerk on y-axis
<li><b>fbodyaccjerkmeanz:</b>: numeric field describing mean frequecy domain signal body accleration jerk on z-axis
<li><b>fbodygyromeanx:</b>: numeric field describing mean frequecy domain signal angular velocity on x-axis
<li><b>fbodygyromeany:</b>: numeric field describing mean frequecy domain signal angular velocity on y-axis
<li><b>fbodygyromeanz:</b>: numeric field describing mean frequecy domain signal angular velocity on z-axis
<li><b>fbodyaccmagmean:</b>: numeric field describing mean magnitude of frequecy domain signal body accleration
<li><b>fbodyaccjerkmagmean:</b>: numeric field describing mean magnitude of frequecy domain signal body accleration jerk
<li><b>fbodygyromagmean:</b>: numeric field describing mean magnitude of frequecy domain signal angular velocity
<li><b>fbodygyrojerkmagmean:</b>: numeric field describing mean magnitude of frequecy domain signal angular velocity jerk
<li><b>tbodyaccstdx:</b>: numeric field describing standard deviation time signal body accleration on x-axis
<li><b>tbodyaccstdy:</b>: numeric field describing standard deviation time signal body accleration on y-axis
<li><b>tbodyaccstdz:</b>: numeric field describing standard deviation time signal body accleration on z-axis
<li><b>tgravityaccstdx:</b>: numeric field describing standard deviation time signal gravity accleration on x-axis
<li><b>tgravityaccstdy:</b>: numeric field describing standard deviation time signal gravity accleration on y-axis
<li><b>tgravityaccstdz:</b>: numeric field describing standard deviation time signal gravity accleration on z-axis
<li><b>tbodyaccjerkstdx:</b>: numeric field describing standard deviation time signal body accleration jerk on x-axis
<li><b>tbodyaccjerkstdy:</b>: numeric field describing standard deviation time signal body accleration jerk on y-axis
<li><b>tbodyaccjerkstdz:</b>: numeric field describing standard deviation time signal body accleration jerk on z-axis
<li><b>tbodygyrostdx:</b>: numeric field describing standard deviation time signal angular velocity on x-axis
<li><b>tbodygyrostdy:</b>: numeric field describing standard deviation time signal angular velocity on y-axis
<li><b>tbodygyrostdz:</b>: numeric field describing standard deviation time signal angular velocity on z-axis
<li><b>tbodygyrojerkstdx:</b>: numeric field describing standard deviation time signal angular velocity jerk on x-axis
<li><b>tbodygyrojerkstdy:</b>: numeric field describing standard deviation time signal angular velocity jerk on y-axis
<li><b>tbodygyrojerkstdz:</b>: numeric field describing standard deviation time signal angular velocity jerk on z-axis
<li><b>tbodyaccmagstd:</b>: numeric field describing standard deviation magnitude of time signal body accleration
<li><b>tgravityaccmagstd:</b>: numeric field describing standard deviation magnitude of time signal gravity accleration
<li><b>tbodyaccjerkmagstd:</b>: numeric field describing standard deviation magnitude of time signal body accleration jerk
<li><b>tbodygyromagstd:</b>: numeric field describing standard deviation magnitude of time signal angular velocity
<li><b>tbodygyrojerkmagstd:</b>: numeric field describing standard deviation magnitude of time signal angular velocity jerk
<li><b>fbodyaccstdx:</b>: numeric field describing standard deviation frequecy domain signal body accleration on x-axis
<li><b>fbodyaccstdy:</b>: numeric field describing standard deviation frequecy domain signal body accleration on y-axis
<li><b>fbodyaccstdz:</b>: numeric field describing standard deviation frequecy domain signal body accleration on z-axis
<li><b>fbodyaccjerkstdx:</b>: numeric field describing standard deviation frequecy domain signal body accleration jerk on x-axis
<li><b>fbodyaccjerkstdy:</b>: numeric field describing standard deviation frequecy domain signal body accleration jerk on y-axis
<li><b>fbodyaccjerkstdz:</b>: numeric field describing standard deviation frequecy domain signal body accleration jerk on z-axis
<li><b>fbodygyrostdx:</b>: numeric field describing standard deviation frequecy domain signal angular velocity on x-axis
<li><b>fbodygyrostdy:</b>: numeric field describing standard deviation frequecy domain signal angular velocity on y-axis
<li><b>fbodygyrostdz:</b>: numeric field describing standard deviation frequecy domain signal angular velocity on z-axis
<li><b>fbodyaccmagstd:</b>: numeric field describing standard deviation magnitude of frequecy domain signal body accleration
<li><b>fbodyaccjerkmagstd:</b>: numeric field describing standard deviation magnitude of frequecy domain signal body accleration jerk
<li><b>fbodygyromagstd:</b>: numeric field describing standard deviation magnitude of frequecy domain signal angular velocity
<li><b>fbodygyrojerkmagstd:</b>: numeric field describing standard deviation magnitude of frequecy domain signal angular velocity jerk
