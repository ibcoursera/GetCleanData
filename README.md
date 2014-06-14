GetCleanData
============

Final project for Getting and Cleaning Data

SUMMARY

File name "run_analysis.R".  Script is designed to:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

RAW DATA SOURCE

UC Irvine Machine learning Repository.  Link to data:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

DIRECTIONS

1. Set working directory then run run_analysis.R.
2. Script will download and unzip files on the working directory.
3. After downloading, the script proceeds to process the data into a tidy dataset.  Tidy data set will be saved in the working directory with the file name “TidyData.txt”.
