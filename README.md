# Instructions for preprocessing
## Software Dependency
 library(data.table)
 library(dplyr)

## Source Dependency
The source data can be found using this link https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
  	
## Run the Script
- You will then need to execute run_analysis.R
```R
 run_analysis()
```
- You should run the script in the same folder as where the UCI HAR Dataset directory can be found

## What does the script do:

- run_analysis.R is an R script that: 
  1. takes a directory of sensor training and testing data and their derivative calculations and merges them into a single file 
  2. Converts them into a wide-format data set ordered by "subject" identifier and additionally ordered by "activity" identifier
  3. Improves readibility by using a single variable per column and variable names that folllow R conventions 
  4. Translates a numerical activity key into english language activity descriptions 
  5. Subset the list of 500+ variables to a subset of variables that includes all standard deviation and mean calculations
  6. Aggregates the dataset by activity and subject using the mean value of each metric
  7. writes the tidy data set to a data.table txt file, called tidy.txt
                              
