# GettingCleaningDataProj
Use the run_analysis.R file to aggregate the data found at:   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
You may uncomment Line #5 to download a fresh copy of the data to your working directory.

#Features (Columns)
  The columns of this data set are held in "UCI HAR Dataset/features.txt" and input into the variable 'features'.  These features are applied to the x_test and x_train files to clearly label the columns.
#Potential Activites
  Their are 6 activities possible.  A unique list is found in "UCI HAR Dataset/activity_labels.txt" and input into the variable 'activityLabels'
  - 1-WALKING
  - 2-WALKING_UPSTAIRS
  - 3-WALKING_DOWNSTAIRS
  - 4-SITTING
  - 5-STANDING
  - 6-LAYING

 Data for activity by record can be found in "UCI HAR Dataset/test/y_test.txt" and "UCI HAR Dataset/train/y_train.txt" and is put into the variables 'yTest' and 'yTrain'.  The yTrain data is merged with the 'activtyLabels' data to make it more readable. 

#Subjects
  Subjects are labelled from 1-30 and are in non-unique lists ordered by the corresponding record in the x_train/x_test files.  This data can be found in "UCI HAR Dataset/train/subject_train.txt" and "UCI HAR Dataset/test/subject_test.txt") and is place in 'subTrain' and 'subTest', respectively.
  
  The subject data is merged with the observational data in lines 35 and 42.

#Oberservations
Observations are kept in the "UCI HAR Dataset/train/x_train.txt" and "UCI HAR Dataset/test/x_test.txt" files and put into variables 'xTest' and 'xTrain'.  This data is then merged with the subject and activity data for both the training and test sets.  The two tables are then combined (appended) into a table called 'xFull'.

#Output
The code subsets the 'xFull' table to only view columns that are keys or columns with headers that contain strings of 'mean' or 'std. The data is then grouped by the subject and activity and an average is taken of all columns.  This final table is written to a text file called 'mean.txt' in your working directory.  The corresponding variable is 'output'.




