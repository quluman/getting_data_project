Course Project Code Book
========================

The R script (run_analysis.R) processes data (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) in the following way:

* Merges the training and test sets to create one data set: 
  *merge train/X_train.txt and test/X_test.txt, to create a 10299x561 data frame containing the acutally sensor data
  *merge train/y_train.txt and test/y_test.txt, to create a 10299x1 data frame descibing activity IDs.
  *merge train/subject_train.txt and test/subject_test.txt, to create a 10299x1 data frame describing subject IDs

* Extracts only the measurements on the mean and standard deviation for each measurement, from features.txt. The result is a 10299x66 data frame

* Reads activity_labels.txt and applies descriptive activity names to name the activities in the data set:

  * WALKING
  * WALKINGUPSTAIRS
  * WALKINGDOWNSTAIRS
  * SITTING
  * STANDING
  * LAYING


* Uses descriptive activity names to name the activities in the data set. Then it merges the 10299x66 data frame containing acutal data with 10299x1 data frames containing activity labels and subject IDs. The result is saved in clean_data.txt, a 10299x68 data frame such that the first column contains subject IDs, the second column activity names, and the last 66 columns are measurement data. Subject IDs are integers between 1 and 30 inclusive. 

* Creates a second, independent tidy data set with the average of each measurement for each activity and each subject. The result is saved in final_results.txt which is a 180x68 data frame. The first column contains subject IDs, the second column contains activity names, and columns 3:68 contains the average values of the measurements. There are 180 rows (30 subjects * 6 activities).
