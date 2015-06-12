# Source of data for this project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

# This R script does the following:

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive activity names.
# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

# Load Libraries
library(data.table)
library(dplyr)

# 1. Merges the training and the test sets to create one data set.
# Read and load the metadata for activities and labels
featureNames <- read.table("UCI HAR Dataset/features.txt")
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", header = FALSE)

# Read and load the training data
subjectTrain <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)

# Read and load the actual test data
subjectTest <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)

# Merge the training and test data using rbind (append/union rows) - not using Merge cause there is no key
subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

# Set the column names in the features data set to the correct column names found in featureNames dataset
colnames(features) <- t(featureNames[2])

# HardCode single column Name in Activity data set to be "Activity"
colnames(activity) <- "Activity"

# HardCode single column Name in Subject data set to be "Subject"
colnames(subject) <- "Subject"

# Merge features, activity and training datasets into one dataset. Now using cbind. 
# All three datasets contain 10299 rows - appending datasets by column. 
completeData <- cbind(features,activity,subject)
# Assigment Part 1 Complete


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# Get integer vector pointer to columns that have mean or STD metrics
colsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)

# The last two columns 562 and 563 are added to the list 
requiredColumns <- c(colsWithMeanSTD, 562, 563)

# Now we create a subset of CompleteData to include only the relevant columns
extractedData <- completeData[,requiredColumns]
# Assigment Part 2 Complete


# 3. Uses descriptive activity names to name the activities in the data set.
# Cast activity type column to character (currently numeric)
extractedData$Activity <- as.character(extractedData$Activity)

# Activity Labels have codes 1 to 6. The extractedData dataset has numeric codes 1 to 6. Replacing the codes with the 
# descriptions from the lables dataset
for (i in 1:6){
  extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}

# Classify the activity column to be a factor 
extractedData$Activity <- as.factor(extractedData$Activity)

# Classify the subject column to be a factor 
extractedData$Subject <- as.factor(extractedData$Subject)
# Assignment Part 3 Complete


# 4. Appropriately labels the data set with descriptive activity names.
# Use names() function to get to know column names that can be fixed
# Patterns identified     mapped to         Fix
# Acc                     ->                Accelerometer
# Gyro                    ->                Gyroscope
# BodyBody                ->                Body
# Mag                     ->                Magnitude
# f (startswith)          ->                Frequency
# t (startswith)          ->                Time
# tBody                   ->                TimeBody
# -mean                   ->                Mean
# -std                    ->                STD
# -freq                   ->                Frequency
# angle                   ->                Angle
# gravity                 ->              Gravity
names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))
# Assignment Part 4 Complete

# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.
# convert extractedData dataframe to data table
extractedData <- data.table(extractedData)

# roll up extractedData by Subject and Activity, using a mean of all metrics
tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)

# now order the data by subject, activity ascending
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]

# finally write the data table out to a txt file
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)
