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
setkey(features, "V1")

activityLabels<-fread("UCI HAR Dataset/activity_labels.txt")
setkey(activityLabels, "V1")
setnames(activityLabels, 2, "activityLabel") #Rename the new loaded column

yTrain<-fread("UCI HAR Dataset/train/y_train.txt")
setkey(yTrain, "V1")
yTrain<-yTrain[activityLabels]

yTest<-fread("UCI HAR Dataset/test/y_test.txt")
setkey(yTest, "V1")
yTest<-yTest[activityLabels]

#Create the Key Columns
keycols<-c("subject", "activityLabel")
#Get test data
xTest<-fread("UCI HAR Dataset/test/x_test.txt")
#Add activity and subject columns
xTest[,subject:=subTest[,V1]]
xTest[,activityLabel:=yTest[,activityLabel]]
setkeyv(xTest, keycols)

#Get training data
xTrain<-fread("UCI HAR Dataset/train/x_train.txt")
#Add activity and subject columns
xTrain[,subject:=subTrain[,V1]]
xTrain[,activityLabel:=yTrain[,activityLabel]]
setkeyv(xTrain, keycols)

#Append the data tables
xFull<-rbindlist(list(xTest, xTrain))
#Set column names and keys for the aggregate file
names(xFull)<-c(features$V2,keycols)
setkeyv(xFull, keycols)

#Subset the data to on include columns with Mean, Std, or the Keys in their title 
meandt<-xFull[, c(grep("mean",names(xFull)),grep("std",names(xFull)),grep("subject",names(xFull)),grep("activityLabel",names(xFull))),with=FALSE]
meandt <- subset(meandt, select = -grep("meanFreq",names(meandt)))
#Summarize the data by subject and activity
output<-meandt[,lapply(.SD,mean),by=keycols]
#Report on Means and std
write.table(output, "mean.txt", row.name=FALSE)
