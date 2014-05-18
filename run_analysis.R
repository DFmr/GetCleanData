
#script downloads Galaxy Smartphone datasets, and merges and cleans data
#for more information on running the script, read associated README.md file
#for more information on variables and dataset, read associated Codebook.md

#downloads file from UCI Machine Learning Repository to workikng directory
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(url,"UCI HAR Dataset.zip")

#downloadDate<-date()
#downloadDate
#[1] "Fri May 16 05:26:28 2014"

unzip("UCI HAR Dataset.zip") #unzips the data to the working directory

sub.trn<-read.table(".\\UCI HAR Dataset\\train\\subject_train.txt") #reads training subject dataset

y.trn<-read.table(".\\UCI HAR Dataset\\train\\y_train.txt") #reads training activity data

x.trn<-read.table(".\\UCI HAR Dataset\\train\\X_train.txt") #reads training Samsung Smartphone data

trn<-cbind(sub.trn,y.trn,x.trn) #binds training activity, subject and smartphone data into a single dataset

sub.tst<-read.table(".\\UCI HAR Dataset\\test\\subject_test.txt") #reads test subject dataset

y.tst<-read.table(".\\UCI HAR Dataset\\test\\y_test.txt") #reads test activity data

x.tst<-read.table(".\\UCI HAR Dataset\\test\\X_test.txt") #reads test Samsung Smartphone data

tst<-cbind(sub.tst,y.tst,x.tst) #binds test activity, subject and smartphone data into a single dataset

data<-rbind(trn,tst) #combines training and test data into a single dataframe

f.names<-read.table(".\\UCI HAR Dataset\\features.txt") #reads a text file with variable names for Samsung smartphone data

var.names<-gsub("-","",f.names[,2]) #eliminates '-' to make variable names readable
var.names<-tolower(gsub("()","",var.names,fixed = TRUE)) #eliminates '()' to make variable names readable; makes varibles lower case
var.names<-gsub(",","",var.names,fixed = TRUE) #eliminates ',' to makes variables more readable
var.names<-gsub("bodybody","body",var.names) #some of the variables seem to have extra 'body'

colnames(data)<-c("subject","activitycode",var.names) #renames columns in dataset

n<-names(data)
mn<-grep("mean",n,value=TRUE) #creates a vector of column names for variables with 'means' in title
mn2<-grep("freq",mn,invert=TRUE,value=TRUE) #eliminates column names with 'freq' in vector of means
mn3<-grep("angle",mn2,invert=TRUE,value=TRUE) #eliminates column names with 'std' in vector of means
std<-grep("std",n,value=TRUE) #creates a vector of column names for variables with 'std' in title

select<-c(mn3,std) #creates vector with mean and std columns

parse<-match(c("subject","activitycode",select),names(data)) #creates a vector with the position of variable columns

data.parse<-data[,c(parse)] #creates a dataset with only variables of interest

labels<-read.table(".\\UCI HAR Dataset\\activity_labels.txt") #reads table with activity labels

labels$V2<-tolower(gsub("_"," ",labels$V2)) #"removes '-' hyphens from dataset;converts labels to lower case

labels$V2<-sub("laying","lying",labels$V2)  #replaces 'laying' label with 'lying' which I think is closer to intent of measure

colnames(labels)<-c("activitycode","activity") #creates colnames for label dataset

data.act<-merge(data.parse,labels,by="activitycode") #merges smartphone data with dataset with activity labels

data.act<-data.act[,c(1:2,69,3:68)] #reorders dataset so that activity and subect data some first

final.data<-aggregate(.~activity+subject,data=data.act,FUN=mean) #obtains the average mean and std by subject and by activity

write.table(final.data,"finalData.txt",sep="\t",row.names=F,col.names=T) #writes a tab delminted text file with the summarized data



