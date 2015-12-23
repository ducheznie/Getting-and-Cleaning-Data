## run_analysis.R does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation
##    for each measurement
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data sets with descriptive variable names
## 5. From the data set in step 4, creates a second, independent tidy data
##    set with the average of each variable for each activity and each subject

library(data.table)
library(reshape2)

## Downloading file
if (!file.exists("UCI HAR Dataset")) {
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile = zipfile, method = "curl")
        unzip(zipfile)
}

## Loading activity labels, feature names, column names, test data, and train data
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]
x_test <- read.table("./UCI Har Dataset/test/X_test.txt")
y_test <- read.table("./UCI Har Dataset/test/Y_test.txt")
subject_test <- read.table("./UCI Har Dataset/test/subject_test.txt")
x_train <- read.table("./UCI Har Dataset/train/X_train.txt")
y_train <- read.table("./UCI Har Dataset/train/Y_train.txt")
subject_train <- read.table("./UCI Har Dataset/train/subject_train.txt")

## Labelling data
names(x_test) <- features
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) <- c("Activity_ID", "Activity_Label")
names(x_train) <- features
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) <- c("Activity_ID", "Activity_Label")
names(subject_test) <- "subject"
names(subject_train) = "subject"

## Extracting measurements of mean and standard deviation for each measurement
extract_features <- grepl("mean|std", features)
x_test <- x_test[,extract_features]
x_train <- x_train[,extract_features]

## Merging data
test_data <- cbind(as.data.frame(subject_test), y_test, x_test)
train_data <- cbind(as.data.frame(subject_train), y_train, x_train)
data <- rbind(test_data, train_data)

## Creating new data tidy data set with the average of each variable for each 
## activity and each subject
id_labels <- c("subject", "Activity_ID", "Activity_Label")
data_labels <- setdiff(colnames(data), id_labels)
melt_data <- melt(data, id = id_labels, measure.vars = data_labels)
tidy_data <- dcast(melt_data, subject + Activity_Label ~ variable, mean)
write.table(tidy_data, file = "./tidy_data.txt", row.names = FALSE)