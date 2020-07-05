#You should create one R script called run_analysis.R that does the following.
#Download the files on the desktop 
fileurl="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl,destfile="coursera.zip")

#Unzip the file
unzip(zipfile="coursera.zip")

#Read the test files
xtest=read.table(file.path("UCI HAR Dataset", "test" , "X_test.txt" ),header=FALSE)
ytest=read.table(file.path("UCI HAR Dataset", "test" , "Y_test.txt" ),header = FALSE)
subjecttest=read.table(file.path("UCI HAR Dataset","tast","subject_test.txt"),header=FALSE)

#Read the train files
xtrain <- read.table(file.path("UCI HAR Dataset","train","X_train.txt"),header=FALSE)
ytrain <- read.table(file.path("UCI HAR Dataset","train","y_train.txt"),header=FALSE)
subjecttrain <- read.table("UCI HAR Dataset","train","subject_train.txt"),header=FALSE)

#Read activity and feature files
activitylabels <- read.table(file.path("UCI HAR Dataset","activity_labels.txt") )
features <- read.table(file.path("UCI HAR Datase","features.txt")

#1.Merges the training and the test sets to create one data set.
#Bind the data of subjects,labels and features of test and train sets by cols
test=cbind(subjecttest,ytest,xtest)
train=cbind(subjecttrain,ytrain,xtrain)
#Combine train and test sets
Dataset=rbind(test,train)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.
#subsetting mean and std cols
DataNames= c("subject","activity",as.character(features$V2) )
meanstd= grep("subject|activity|[Mm]ean|std", DataNames, value = FALSE)
Newdataset=Dataset[,meanstd]

#3.Uses descriptive activity names to name the activities in the data set
names(activitylabels)=c("activitynumber", "activityname")
Newdataset$activitynumber=activitylabels[activitynumber,2]

#4.Appropriately labels the data set with descriptive variable names.
names(Newdataset)[2]="activity"
names(Newdataset)<-gsub("Acc", "Accelerometer", names(Newdataset))
names(Newdataset)<-gsub("Gyro", "Gyroscope", names(Newdataset))
names(Newdataset)<-gsub("BodyBody", "Body", names(Newdataset))
names(Newdataset)<-gsub("Mag", "Magnitude", names(Newdataset))
names(Newdataset)<-gsub("^t", "Time", names(Newdataset))
names(Newdataset)<-gsub("^f", "Frequency", names(Newdataset))
names(Newdataset)<-gsub("tBody", "TimeBody", names(Newdataset))
names(Newdataset)<-gsub("-mean()", "Mean", names(Newdataset), ignore.case = TRUE)
names(Newdataset)<-gsub("-std()", "STD", names(Newdataset), ignore.case = TRUE)
names(Newdataset)<-gsub("-freq()", "Frequency", names(Newdataset), ignore.case = TRUE)
names(Newdataset)<-gsub("angle", "Angle", names(Newdataset))
names(Newdataset)<-gsub("gravity", "Gravity", names(Newdataset))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))

#5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidydataset=Newdataset %>% group_by(activity,subject) %>% summarize_all(funs(mean))
write.table(tidydataset,file="tidydataset.tet",row.name=FALSE)
