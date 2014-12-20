
## STEP 0: load required packages 

 2

 

 3
# load the reshape2 package (will be used in STEP 5) 

 4
library(reshape2) 

 5

 

 6

 

 7
## STEP 1: Merges the training and the test sets to create one data set 

 8

 

 9
# read data into data frames 

 10
subject_train <- read.table("subject_train.txt") 

 11
subject_test <- read.table("subject_test.txt") 

 12
X_train <- read.table("X_train.txt") 

 13
X_test <- read.table("X_test.txt") 

 14
y_train <- read.table("y_train.txt") 

 15
y_test <- read.table("y_test.txt") 

 16

 

 17
# add column name for subject files 

 18
names(subject_train) <- "subjectID" 

 19
names(subject_test) <- "subjectID" 

 20

 

 21
# add column names for measurement files 

 22
featureNames <- read.table("features.txt") 

 23
names(X_train) <- featureNames$V2 

 24
names(X_test) <- featureNames$V2 

 25

 

 26
# add column name for label files 

 27
names(y_train) <- "activity" 

 28
names(y_test) <- "activity" 

 29

 

 30
# combine files into one dataset 

 31
train <- cbind(subject_train, y_train, X_train) 

 32
test <- cbind(subject_test, y_test, X_test) 

 33
combined <- rbind(train, test) 

 34

 

 35

 

 36
## STEP 2: Extracts only the measurements on the mean and standard 

 37
## deviation for each measurement. 

 38

 

 39
# determine which columns contain "mean()" or "std()" 

 40
meanstdcols <- grepl("mean\\(\\)", names(combined)) | 

 41
    grepl("std\\(\\)", names(combined)) 

 42

 

 43
# ensure that we also keep the subjectID and activity columns 

 44
meanstdcols[1:2] <- TRUE 

 45

 

 46
# remove unnecessary columns 

 47
combined <- combined[, meanstdcols] 

 48

 

 49

 

 50
## STEP 3: Uses descriptive activity names to name the activities 

 51
## in the data set. 

 52
## STEP 4: Appropriately labels the data set with descriptive 

 53
## activity names.  

 54

 

 55
# convert the activity column from integer to factor 

 56
combined$activity <- factor(combined$activity, labels=c("Walking", 

 57
    "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")) 

 58

 

 59

 

 60
## STEP 5: Creates a second, independent tidy data set with the 

 61
## average of each variable for each activity and each subject. 

 62

 

 63
# create the tidy data set 

 64
melted <- melt(combined, id=c("subjectID","activity")) 

 65
tidy <- dcast(melted, subjectID+activity ~ variable, mean) 

 66

 

 67
# write the tidy data set to a file 

 68
write.csv(tidy, "tidy.csv", row.names=FALSE) 
