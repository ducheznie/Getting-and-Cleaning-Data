# Code Book

## Introduction
This code book describes the variables and transformations used on the data set from the script `run_analysis.R`

The data set and original description of it can be found at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Data Set Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured
3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been 
video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 
70% of the volunteers was selected for generating the training data and 30% the test data.

# run_analysis.R
`run_analysis.R` does the following:
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject, from the data set above

## Getting and Cleaning the data
The script will download and unzip the data set to the working directory, if it is not already there.
The first step is to load the data sets into R. The data sets are then labeled using information found in the 
original folder. 

Once they are labelled, the columns featuring means and standard deviations will be extracted, since they are of interest.
The new data sets containing only means and standard deviations will be merged together and processed to create a new 
tidy data set. 
