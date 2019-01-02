rm(list=ls())
# Getting and Cleaning Data 

#################################################
# Assignment 1. Merge the training and the test sets to create one data set
setwd("~/desktop/Coursera/Data_Science_Specialization/3_Getting_Cleaning_Data/UCI_HAR_Dataset")
# Setting the path of the directory
fp_train<-file.path(getwd(),"train"); fp_train
fp_test<-file.path(getwd(),"test"); fp_test

# Reading Training data - Xtrain/ytrain/subject_train
xtrain<-read.table(paste(fp_train, "/X_train.txt", sep=""))
ytrain<-read.table(paste(fp_train, "/y_train.txt", sep=""))
subject_train<-read.table(paste(fp_train, "/subject_train.txt", sep=""))

# Reading Test data - Xtest/ytest/subject_test
xtest<-read.table(paste(fp_test,"/X_test.txt",sep=""))
ytest<-read.table(paste(fp_test,"/y_test.txt",sep=""))
subject_test<-read.table(paste(fp_test,"/subject_test.txt",sep=""))

# Reading the features data
features<-read.table(paste(file.path(getwd()), "/features.txt",sep=""))

# Reading activity labels data
activityLabels<-read.table(paste(file.path(getwd()), "/activity_labels.txt",sep=""))

# Add appropriate descriptive labels to the column variables (Assignment 4)
colnames(xtrain)<-features[,2]
colnames(xtest)<-features[,2]
colnames(ytrain)<-"activityId"
colnames(ytest)<-"activityId"
colnames(subject_train)<-"subjectId"
colnames(subject_test)<-"subjectId"
colnames(activityLabels)<-c("activityId","activityType")

merge_train<-cbind(ytrain, subject_train, xtrain)
merge_test<-cbind(ytest, subject_test, xtest)


# Merging the training and the test sets in one data set
merge_train_test<-rbind(merge_train, merge_test)


#################################################
# Assignment 2. Extracts only the measurements on the mean and sd for each measurement
colNames<-colnames(merge_train_test)
mean_and_std = (grepl("activityId" , colNames) | grepl("subjectId" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))
mean_and_std
meanSD_train_test<-merge_train_test[,mean_and_std==TRUE]; meanSD_train_test
#head(meanSD_train_test)
#tail(meanSD_train_test)


#################################################
# Assignment 3. Uses descriptive activity names to the name the activities in the data set
meanSD_train_test_desc<-merge(meanSD_train_test, activityLabels, by="activityId",all=TRUE)


#################################################
# Assignment 4. Appropriately labels the data set with descriptive variable names
# The column names are already labeled through the Assignment 1.
names(meanSD_train_test_desc)

#################################################
# Assignment 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
TidyData<-aggregate(.~subjectId+activityId, meanSD_train_test_desc, mean); TidyData
TidyData<-arrange(TidyData,activityId,subjectId)
# Saving the new data into data table
write.table(TidyData, "TidyData.txt", row.names=FALSE)
