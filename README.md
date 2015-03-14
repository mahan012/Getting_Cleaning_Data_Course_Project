Getting and Cleaning Data Course Project

#######################################################################################################################

This projected is implemented as run\_analysis.R is implemented as a function that accepts two arguments working\_dir and download\_dir .

A valid working\_dir must be supplied; if the directory is not valid the program will error out and exit.

Download\_dir is where processing data from web gets down loaded. The default directory for this is a sub directory under working\_dir called Data.

######################################################################################################################

The functional specification for this project is

Merges the training and the test sets to create one data set.

Extracts only the measurements on the mean and standard deviation for each measurement.

Uses descriptive activity names to name the activities in the data set

Appropriately labels the data set with descriptive variable names.

From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

We will source dplyr library

&nbsp; library(dplyr);

# Validate that working directory passed is a valid directory & set the working directory

&nbsp; &nbsp;if (!file.exists (working\_dir)) {

&nbsp; &nbsp; &nbsp;stop ("Specify valid working dirctory")

&nbsp; }

&nbsp; setwd(working\_dir)

&nbsp; #if the directory to down load and manipulate data doesn't exists create that directory

&nbsp; &nbsp;if(!file.exists("./data")){dir.create("./data")}

&nbsp; #Down load and Unzip the file to create raw data

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

&nbsp;This assignment was done on windows and needed method="auto" and mode="wb" . The usual recommendation of curl for method did not work

&nbsp; download.file(url=fileUrl,destfile="./data/Dataset.zip",mode="wb",method="auto")

&nbsp; dateDownloaded <- date()

&nbsp; dateDownloaded

&nbsp; unzip(zipfile="./data/Dataset.zip",exdir="./data", overwrite = TRUE)

&nbsp;

&nbsp;Source through directories and create a file path to all the files. We have to specify recursive=TRUE to get the subdirectories also. &nbsp;

&nbsp;

&nbsp; filepath\_full<- file.path("./data", "UCI HAR Dataset")

&nbsp; files<-list.files(filepath\_full, recursive=TRUE)

&nbsp;

Displaying variuables in files via a debugger will display following files. The directory they are located is

C:\Coursera\Getting\_Cleaning\_Data\_Course\_Project\data\UCI HAR Dataset

&nbsp;

files

# &nbsp;[1] "activity\_labels.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

# &nbsp;[2] "features\_info.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

# &nbsp;[3] "features.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

# &nbsp;[4] "README.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

# &nbsp;[5] "test/Inertial Signals/body\_acc\_x\_test.txt" &nbsp;

# &nbsp;[6] "test/Inertial Signals/body\_acc\_y\_test.txt" &nbsp;

# &nbsp;[7] "test/Inertial Signals/body\_acc\_z\_test.txt" &nbsp;

# &nbsp;[8] "test/Inertial Signals/body\_gyro\_x\_test.txt" &nbsp;

# &nbsp;[9] "test/Inertial Signals/body\_gyro\_y\_test.txt" &nbsp;

# [10] "test/Inertial Signals/body\_gyro\_z\_test.txt" &nbsp;

# [11] "test/Inertial Signals/total\_acc\_x\_test.txt" &nbsp;

# [12] "test/Inertial Signals/total\_acc\_y\_test.txt" &nbsp;

# [13] "test/Inertial Signals/total\_acc\_z\_test.txt" &nbsp;

# [14] "test/subject\_test.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

# [15] "test/X\_test.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

# [16] "test/y\_test.txt" &nbsp; &nbsp;

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

# [17] "train/Inertial Signals/body\_acc\_x\_train.txt"

# [18] "train/Inertial Signals/body\_acc\_y\_train.txt"

# [19] "train/Inertial Signals/body\_acc\_z\_train.txt"

# [20] "train/Inertial Signals/body\_gyro\_x\_train.txt"

# [21] "train/Inertial Signals/body\_gyro\_y\_train.txt"

# [22] "train/Inertial Signals/body\_gyro\_z\_train.txt"

# [23] "train/Inertial Signals/total\_acc\_x\_train.txt"

# [24] "train/Inertial Signals/total\_acc\_y\_train.txt"

# [25] "train/Inertial Signals/total\_acc\_z\_train.txt"

# [26] "train/subject\_train.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

# [27] "train/X\_train.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

# [28] "train/y\_train.txt"

&nbsp;

# Read activity file &nbsp; &nbsp;

&nbsp; dataActivityTest &nbsp;<- read.table(file.path(filepath\_full, "test" , "Y\_test.txt" ),header = FALSE)

&nbsp; dataActivityTrain <- read.table(file.path(filepath\_full, "train", "Y\_train.txt"),header = FALSE)

&nbsp;

&nbsp;# Read the Subject files

&nbsp; dataSubjectTrain <- read.table(file.path(filepath\_full, "train", "subject\_train.txt"),header = FALSE)

&nbsp; dataSubjectTest &nbsp;<- read.table(file.path(filepath\_full, "test" , "subject\_test.txt"),header = FALSE)

# Read Features &nbsp;files

&nbsp; dataFeaturesTest &nbsp;<- read.table(file.path(filepath\_full, "test" , "X\_test.txt" ),header = FALSE)

&nbsp; dataFeaturesTrain <- read.table(file.path(filepath\_full, "train", "X\_train.txt"),header = FALSE)

&nbsp;

# We are implementing the spec (1) Merges the training and the test sets to create one data set.

&nbsp;

Merge the rows from Train and Test files for Subject , activity and features to produce unified data frame

&nbsp; dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)

&nbsp; dataActivity <- rbind(dataActivityTrain, dataActivityTest)

&nbsp; dataFeatures <- rbind(dataFeaturesTrain, dataFeaturesTest)

&nbsp;

Name the fields &nbsp;of subject and activity

&nbsp; names(dataSubject)<-c("subject")

&nbsp; names(dataActivity)<- c("activity")

&nbsp;

&nbsp;Read the features.txt file and extract the field containing the names .

&nbsp;

&nbsp; dataFeaturesNames <- read.table (file.path(filepath\_full, "features.txt"), head=FALSE )

&nbsp; names(dataFeatures) <- dataFeaturesNames$V2

&nbsp;

Do a columnar merge of subject, activity and features to create a single data frame.

&nbsp;

&nbsp; dataCombine <- cbind(dataSubject, dataActivity)

&nbsp; Data <- cbind(dataFeatures, dataCombine)

&nbsp;

We are implementing (2) Extracts only the measurements on the mean and standard deviation for each measurement.

&nbsp;

# we will use grep command to extract out selected columns. These columns represent variables that have mean and std in their names . we will subset (using SelectedColumns) the merged data and extract out required &nbsp;data .

&nbsp;

&nbsp; grep\_std\_string <- "mean\\(\\)|std\\(\\)"

&nbsp; Needed\_features <- dataFeaturesNames[,2][grep(grep\_std\_string, dataFeaturesNames[,2])]

&nbsp; SelectedColumns <- c(as.character(Needed\_features), "subject" , "activity")

&nbsp; Data<-subset(Data,select=SelectedColumns) &nbsp;? This piece of code acieves subsetting

&nbsp;

(3) & (4) We are implementing Uses descriptive activity names to name the activities in the data set

&nbsp;

##############################################################################

Name the column of Data frame with meaningful names . we will use gsub function to do a global substitute of source strings to column strings as part of names.

gsub()&nbsp;function replaces all matches of a string, if the parameter is a string vector, returns a string vector of the same length and with the same attributes (after possible coercion to character). Elements of string vectors which are not substituted will be returned unchanged (including any declared encoding).&nbsp;

tBody will be converted to Time\_Body

FBody will be converted to Frequency\_Body

tGravity will be converted to Time\_Gravity

Acc will be converted to Accelerometer

Gyo will be converted to Gyroscope

Mag will be converted to Magnitude

BodyBOdy will be Concerted to Body

#############################################################################

# &nbsp; names(Data)<-gsub("tBody", "Time\_Body", names(Data))

# &nbsp; names(Data)<-gsub("fBody", "Frequency\_Body", names(Data))

# &nbsp; names(Data)<-gsub("tGravity", "Time\_Gravity", names(Data))

# &nbsp; names(Data)<-gsub("Acc", "Accelerometer", names(Data))

# &nbsp; names(Data)<-gsub("Gyro", "Gyroscope", names(Data))

# &nbsp; names(Data)<-gsub("Mag", "Magnitude", names(Data))

# &nbsp; names(Data)<-gsub("BodyBody", "Body", names(Data))

We are implementing (5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# #Group the data, Create summary, write out the summary. We will be making use of group\_by , summarize\_each dply utility commands to achieve this.

# &nbsp; Data\_group <- group\_by(Data, subject, activity)

# &nbsp; Data\_group\_summary <- summarise\_each(Data\_group, funs(mean))

# &nbsp; write.table(Data\_group\_summary, file = "tidydata.txt",row.name=FALSE) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 

# }

# The following test run proves that tidydata.txt was created and uploaded using above piece of R code.

# The output file tidydata.txt has been uploaded to github

# setwd("C:/Coursera/Getting\_cleaning\_data\_Course\_project")

# > getwd()

# 1] "C:/Coursera/Getting\_cleaning\_data\_Course\_project"

# working\_dir <- getwd()

# working\_dir

# [1] "C:/Coursera/Getting\_cleaning\_data\_Course\_project"

# source("C:/Coursera/Getting\_cleaning\_data\_Course\_project/run\_analysis.R")

# run\_analysis(working\_dir)

# trying URL 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

# Content type 'application/zip' length 62556944 bytes (59.7 Mb)

# opened URL

# downloaded 59.7 Mb

# ##########################################################################################

&nbsp;