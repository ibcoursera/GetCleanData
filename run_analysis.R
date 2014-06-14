#  Getting and Cleaning Data 
#  Course Project
#  run_analysis.R

#################################

# Load packages
install.packages("downloader")
install.packages("data.table")

require(downloader)
require(data.table)
require(reshape2)

# Check for and create directory
if(!file.exists("data")){
  dir.create("data")
}

# Download data
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp <- tempfile()
download(fileURL, temp, mode = "wb")
unzip(temp, exdir ="./data")
unlink(temp)
dateDownloaded <- date()

# Clean and prep data sets
featuresRaw <- read.table("./data/UCI HAR Dataset/features.txt")
features <- featuresRaw[,2]
activityRaw <- read.table("./data/UCI HAR Dataset/activity_labels.txt", colClasses = "character")
activity <- activityRaw[,2]

# Training Set
trainX <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names = features, 
                     colClasses = "numeric")
trainY <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names = "Activities")
trainSubject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", 
                           col.names = "Subjects")
train <- cbind(trainSubject, trainX, trainY)

# Test Set
testX <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names = features, 
                     colClasses = "numeric")
testY <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names = "Activities")
testSubject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", 
                          col.names = "Subjects")
test <- cbind(testSubject, testX, testY)

# Subset Data Sets
meanTrain <- grep("mean()", colnames(train))
stdTrain <- grep("std()", colnames(train))
subjectTrain <- which(colnames(train) == "Subjects")
activityTrain <- which(colnames(train) == "Activities")
trainSub <- train[, c(subjectTrain, activityTrain, meanTrain, stdTrain)]

meanTest <- grep("mean()", colnames(test))
stdTest <- grep("std()", colnames(test))
subjectTest <- which(colnames(test) == "Subjects")
activityTest <- which(colnames(test) == "Activities")
testSub <- test[, c(subjectTest, activityTest, meanTest, stdTest)]

# Merge Data Sets
mergeData <- merge(trainSub, testSub, all = "TRUE")

# Replace Activity Names
for(i in 1:length(activity)){
  # change the values in activity column
  mergeData$Activities[mergeData$Activities == i] <- activity[[i]]
}

# Reshape data frame
mergeDataCols <- colnames(mergeData)
meanStdCols <- mergeDataCols[3:length(mergeDataCols)]
mergeData.melt <- melt(mergeData, id = c("Subjects", "Activities"), 
                       measure.vars = meanStdCols)
tidyData <- dcast(mergeData.melt, Subjects + Activities ~ variable, 
                  fun.aggregate = mean)

# Save tidy Data to working directory
write.table(tidyData, file = "TidyData.txt", sep = ",", col.names = TRUE)

