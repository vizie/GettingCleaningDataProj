# GettingCleaningDataProj
Use the run_analysis.R file to aggregate the data found at:   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
You may uncomment Line #5 to download a fresh copy of the data to your working directory.

#Features (Columns)
  The columns of this data set are held in "UCI HAR Dataset/features.txt" and input into the variable 'features'
#Potential Activites
  Their are 6 activities possible found in "UCI HAR Dataset/activity_labels.txt" and input into the variable 'activityLabels'
  - 1-WALKING
  - 2-WALKING_UPSTAIRS
  - 3-WALKING_DOWNSTAIRS
  - 4-SITTING
  - 5-STANDING
  - 6-LAYING

#Subjects
  Subjects are labelled from 1-30 and are in non-unique lists ordered by the corresponding record in the x_train/x_test files.  This data is found in "UCI HAR Dataset/test/y_test.txt" and "UCI HAR Dataset/train/y_train.txt" and put into the variables yTest and yTrain.

