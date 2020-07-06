#You should create one R script called run_analysis.R that does the following.
#Download the files on the desktop 
fileurl="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile="coursera.zip")

#Unzip the file
unzip(zipfile="coursera.zip")

#Read activity and feature files
activitylabels <- read.table(file.path("UCI HAR Dataset","activity_labels.txt"),col.names=c("number","activity")）
features <- read.table(file.path("UCI HAR Dataset","features.txt")，col.names=c("num","function"))

#Read the test files
Xtest=read.table(file.path("UCI HAR Dataset", "test" , "X_test.txt" ),col.names=features$functions)
Ytest=read.table(file.path("UCI HAR Dataset", "test" , "Y_test.txt" ),col.names="number")
Subjecttest=read.table(file.path("UCI HAR Dataset","tast","subject_test.txt"),col.names="subject")

#Read the train files
Xtrain <- read.table(file.path("UCI HAR Dataset","train","X_train.txt"),col.names=features$functions)
Ytrain <- read.table(file.path("UCI HAR Dataset","train","y_train.txt"),col.names="number")
subjecttrain <- read.table("UCI HAR Dataset","train","subject_train.txt"),col.names="subject")

#1.Merges the training and the test sets to create one data set.
#Bind the data of subjects,labels and features of test and train sets
X=rbind(Xtrain,Xtest)
Y=rbind(Ytrain,Ytest)
Subject=rbind(subjecttrain,subjecttest)
Dataset=cbind(Subject,Y,X)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.
#subsetting "subject","number","mean" and "std"cols
Extractdataset=Dataset %>% select(subject,number,contains("mean"),contains("std"))

#3.Uses descriptive activity names to name the activities in the data set
#Use the correponding name,which is the 2nd col of activitylabels to subsitute the col of numbers in Extractdataset 
Extractdataset$number=activitylabels[Extractdataset$number,2]

#4.Appropriately labels the data set with descriptive variable names.
> names(Extractdataset)[2]="activity"
> names(Extractdataset)=gsub("Acc","Accelerometer",names(Extractdataset))
> names(Extractdataset)=gsub("Gyro", "Gyroscope", names(Extractdataset))
> names(Extractdataset)=gsub("BodyBody", "Body", names(Extractdataset))
> names(Extractdataset)=gsub("Mag", "Magnitude", names(Extractdataset))
> names(Extractdataset)=gsub("^t", "Time", names(Extractdataset))
> names(Extractdataset)=gsub("^f", "Frequency", names(Extractdataset))
> names(Extractdataset)=gsub("tBody", "TimeBody", names(Extractdataset))
> names(Extractdataset)=gsub("-mean()", "Mean", names(Extractdataset), ignore.case = TRUE)
> names(Extractdataset)=gsub("-std()", "STD", names(Extractdataset),ignore.case = TRUE)
> names(Extractdataset)=gsub("-freq()", "Frequency", names(Extractdataset), ignore.case = TRUE)
> names(Extractdataset)=gsub(""angle", "Angle", names(Extractdataset))

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
>TIDYDATA=aggregate(.~subject+activity,data=Extractdataset,FUN=mean)
>write.table(TIDYDATA,"averaged.txt",row.names=FALSE)
