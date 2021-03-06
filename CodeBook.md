This CodeBook is to describe the procedure from which the final data set is generated.

Original sturcture of data
==========================

-Description documents:
README.txt---background info of this experimentand its result data
features_info.txt---background info of variables

-Data documents:
features.txt---(561*2)table,containing the name of variables
activity_labels.txt---(6*2)table, containing the activites in the experiment
subject_test.txt---(2947*1)table. Each row indicates the subject of the record
X_test.txt---(2947*561)table. Each row is one experiment record, the columns are the different variables which match the features.txt
y_test.txt---(2947*1)table. Each row indicates the activities of the record
subject_train.txt---(7352*1)table. Each row indicates the subject of the record
X_train.txt---(7352*561)table.Each row is one experiment record, the columns are the different variables which match the features.txt
y_train.txt---Each row indicates the activities of the record

Cleaning Procedure
==================

-Step1: merge train and test data
After loading all relevent data, respectively combine the X_test and X_train, y_test and y_train, subject_test and subject_train by using rbind().

-Step2: extracts only the mean and std 
Firstly, find out all mean and std in the feature array by spliting each row of feature and matching with key words("mean" and "std). As the result, a sub array containing the index of target feature will come out.
Secondly, use the sub array to exclude other columns in X. As the result, a sub X containing only relevent variables will come out.

-Step3: rename activities 
Done by changing the data of activities into character and matching y array.

-Step4: rename labels of variables
Done by using the features to rename the column names of X. Finally, combine subject, y(activities) and X(variables) into the final result.

-Step5: creates a tidy data set with the average of each variable for each activity and each subject.
Use two embed loops to run through the data set from Step4, and use tapply to calculate the mean of each variable breaking down for each activity proformed by each subject. Combine the results of each looping together and wirte to file.

Final structure
===============
The final structre is a 10299 * 81 table. Each row is a set of mean values of the selected variables (only the mean and std measurements), breaking down to each activity and each subject. The first column is the subject and the second column is the activity. One subject has 6 activities. The columns from 3 to 81 are the names of selected variables (the mean and std measurements).


Description of abbreviations of measurements
============================================

Body = related to body movement. Gravity = acceleration of gravity Acc = accelerometer measurement Gyro = gyroscopic measurements Jerk = sudden movement acceleration Mag = magnitude of movement mean and SD are calculated for each subject for each activity for each mean and SD measurements. The units given are g’s for the accelerometer and rad/sec for the gyro and g/sec and rad/sec/sec for the corresponding jerks.

These signals were used to estimate variables of the feature vector for each pattern: ‘-XYZ’ is used to denote 3-axial signals in the X, Y and Z directions. They total 33 measurements including the 3 dimensions - the X,Y, and Z axes.

The tidy data set has been aggregated by Activity and Subject and return a mean value of each metric

The set of variables that were estimated from these signals are: (For a description of the metrics please see the original datasets codebook)

Subject Activity TimeBodyAccelerometerMean()-X TimeBodyAccelerometerMean()-Y TimeBodyAccelerometerMean()-Z TimeBodyAccelerometerSTD()-X TimeBodyAccelerometerSTD()-Y TimeBodyAccelerometerSTD()-Z TimeGravityAccelerometerMean()-X TimeGravityAccelerometerMean()-Y TimeGravityAccelerometerMean()-Z TimeGravityAccelerometerSTD()-X TimeGravityAccelerometerSTD()-Y TimeGravityAccelerometerSTD()-Z TimeBodyAccelerometerJerkMean()-X TimeBodyAccelerometerJerkMean()-Y TimeBodyAccelerometerJerkMean()-Z TimeBodyAccelerometerJerkSTD()-X TimeBodyAccelerometerJerkSTD()-Y TimeBodyAccelerometerJerkSTD()-Z TimeBodyGyroscopeMean()-X TimeBodyGyroscopeMean()-Y TimeBodyGyroscopeMean()-Z TimeBodyGyroscopeSTD()-X TimeBodyGyroscopeSTD()-Y TimeBodyGyroscopeSTD()-Z TimeBodyGyroscopeJerkMean()-X TimeBodyGyroscopeJerkMean()-Y TimeBodyGyroscopeJerkMean()-Z TimeBodyGyroscopeJerkSTD()-X TimeBodyGyroscopeJerkSTD()-Y TimeBodyGyroscopeJerkSTD()-Z TimeBodyAccelerometerMagnitudeMean() TimeBodyAccelerometerMagnitudeSTD() TimeGravityAccelerometerMagnitudeMean() TimeGravityAccelerometerMagnitudeSTD() TimeBodyAccelerometerJerkMagnitudeMean() TimeBodyAccelerometerJerkMagnitudeSTD() TimeBodyGyroscopeMagnitudeMean() TimeBodyGyroscopeMagnitudeSTD() TimeBodyGyroscopeJerkMagnitudeMean() TimeBodyGyroscopeJerkMagnitudeSTD() FrequencyBodyAccelerometerMean()-X FrequencyBodyAccelerometerMean()-Y FrequencyBodyAccelerometerMean()-Z FrequencyBodyAccelerometerSTD()-X FrequencyBodyAccelerometerSTD()-Y FrequencyBodyAccelerometerSTD()-Z FrequencyBodyAccelerometerMeanFreq()-X FrequencyBodyAccelerometerMeanFreq()-Y FrequencyBodyAccelerometerMeanFreq()-Z FrequencyBodyAccelerometerJerkMean()-X FrequencyBodyAccelerometerJerkMean()-Y FrequencyBodyAccelerometerJerkMean()-Z FrequencyBodyAccelerometerJerkSTD()-X FrequencyBodyAccelerometerJerkSTD()-Y FrequencyBodyAccelerometerJerkSTD()-Z FrequencyBodyAccelerometerJerkMeanFreq()-X FrequencyBodyAccelerometerJerkMeanFreq()-Y FrequencyBodyAccelerometerJerkMeanFreq()-Z FrequencyBodyGyroscopeMean()-X FrequencyBodyGyroscopeMean()-Y FrequencyBodyGyroscopeMean()-Z FrequencyBodyGyroscopeSTD()-X FrequencyBodyGyroscopeSTD()-Y FrequencyBodyGyroscopeSTD()-Z FrequencyBodyGyroscopeMeanFreq()-X FrequencyBodyGyroscopeMeanFreq()-Y FrequencyBodyGyroscopeMeanFreq()-Z FrequencyBodyAccelerometerMagnitudeMean() FrequencyBodyAccelerometerMagnitudeSTD() FrequencyBodyAccelerometerMagnitudeMeanFreq() FrequencyBodyAccelerometerJerkMagnitudeMean() FrequencyBodyAccelerometerJerkMagnitudeSTD() FrequencyBodyAccelerometerJerkMagnitudeMeanFreq() FrequencyBodyGyroscopeMagnitudeMean() FrequencyBodyGyroscopeMagnitudeSTD() FrequencyBodyGyroscopeMagnitudeMeanFreq() FrequencyBodyGyroscopeJerkMagnitudeMean() FrequencyBodyGyroscopeJerkMagnitudeSTD() FrequencyBodyGyroscopeJerkMagnitudeMeanFreq() Angle(TimeBodyAccelerometerMean,Gravity) Angle(TimeBodyAccelerometerJerkMean),GravityMean) Angle(TimeBodyGyroscopeMean,GravityMean) Angle(TimeBodyGyroscopeJerkMean,GravityMean) Angle(X,GravityMean) Angle(Y,GravityMean) Angle(Z,GravityMean)