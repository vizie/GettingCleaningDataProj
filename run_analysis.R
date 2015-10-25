##Set zip name/download name
destFile<-"UCIHARData.zip"

#Uncomment the below line for clean data
#download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile=destFile )

#Unzip it
f<-unzip(destFile)

library(data.table)
##Load in subjects, features, and activity labels
subTrain<-fread("UCI HAR Dataset/train/subject_train.txt")
subTest<-fread("UCI HAR Dataset/test/subject_test.txt")

features<-fread("UCI HAR Dataset/features.txt")


activityLabels<-fread("UCI HAR Dataset/activity_labels.txt")
names(activityLabels)<-c("actID", "activityLabel")
setkey(activityLabels, "actID")

#setnames(activityLabels, 2, "activityLabel") #Rename the new loaded column


yTrain<-fread("UCI HAR Dataset/train/y_train.txt")


yTest<-fread("UCI HAR Dataset/test/y_test.txt")


#Create the Key Columns
keycols<-c("subject", "actID")
#Get test data
xTest<-fread("UCI HAR Dataset/test/x_test.txt")
#Add activity and subject columns
xTest[,subject:=subTest[,V1]]
xTest[,actID:=yTest[,V1]]
setkeyv(xTest, keycols)
xTest<-merge(xTest, activityLabels, by="actID", all=TRUE)
#Get training data
xTrain<-fread("UCI HAR Dataset/train/x_train.txt")
#Add activity and subject columns
xTrain[,subject:=subTrain[,V1]]
xTrain[,actID:=yTrain[,V1]]
setkeyv(xTrain, keycols)
xTrain<-merge(xTrain, activityLabels, by="actID", all=TRUE)

#Append the data tables
xFull<-rbindlist(list(xTest, xTrain))
#Set column names and keys for the aggregate file
names(xFull)<-c("actID",features$V2,"subject","activityLabel")
setkeyv(xFull, keycols)

#Subset the data to on include columns with Mean, Std, or the Keys in their title 
meandt<-xFull[, c(grep("mean",names(xFull)),grep("std",names(xFull)),grep("subject",names(xFull)),grep("activityLabel",names(xFull)),grep("subject",names(xFull))),with=FALSE]
meandt<-meandt[, c(-grep("meanF",names(meandt))),with=FALSE]
#Summarize the data by subject and activity
output<-meandt[,lapply(.SD,mean),by=c("subject","activityLabel")]

#Report on Means and std
write.table(output, "mean.txt", row.name=FALSE)
