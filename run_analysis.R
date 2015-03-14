
run_analysis <- function (working_dir="", download_dir="/data")
{
 ##########################################################################################
 # This function when called with Valid working directory and Data directory will implement
 # specification Getting and Cleaning Data ; Course Project. It is wriiten as a function in R
 ##########################################################################################
 # source dplyr library 
  library(dplyr); 
 #Validate that working directory passed is a valid directory & set the working directory
 
  if (!file.exists (working_dir)) {
     stop ("Specify valid working dirctory")
  }
  setwd(working_dir)
 
 #if the directory to down load and manipulate data doesn't exists create that directory
 
  if(!file.exists("./data")){dir.create("./data")} 
 
 #Down load and Unzip the file to create raw data 
 
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(url=fileUrl,destfile="./data/Dataset.zip",mode="wb",method="auto")
  dateDownloaded <- date()
  dateDownloaded
  unzip(zipfile="./data/Dataset.zip",exdir="./data", overwrite = TRUE)
 
 # Source through directories and create a file path to all the files 
 
  filepath_full<- file.path("./data", "UCI HAR Dataset")
  files<-list.files(filepath_full, recursive=TRUE)
# Read activity file   
  dataActivityTest  <- read.table(file.path(filepath_full, "test" , "Y_test.txt" ),header = FALSE)
  dataActivityTrain <- read.table(file.path(filepath_full, "train", "Y_train.txt"),header = FALSE)
 # Read the Subject files
  dataSubjectTrain <- read.table(file.path(filepath_full, "train", "subject_train.txt"),header = FALSE)
  dataSubjectTest  <- read.table(file.path(filepath_full, "test" , "subject_test.txt"),header = FALSE)
# Read Features  files
  dataFeaturesTest  <- read.table(file.path(filepath_full, "test" , "X_test.txt" ),header = FALSE)
  dataFeaturesTrain <- read.table(file.path(filepath_full, "train", "X_train.txt"),header = FALSE)

# Merge the rows from Train and Test files for Subject , activity and features to produce unified data frame

  dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)
  dataActivity <- rbind(dataActivityTrain, dataActivityTest)
  dataFeatures <- rbind(dataFeaturesTrain, dataFeaturesTest)

#Name the fileds

  names(dataSubject)<-c("subject")
  names(dataActivity)<- c("activity")
  dataFeaturesNames <- read.table (file.path(filepath_full, "features.txt"), head=FALSE )
  names(dataFeatures) <- dataFeaturesNames$V2

# merge the columns
  dataCombine <- cbind(dataSubject, dataActivity)
  Data <- cbind(dataFeatures, dataCombine)
  grep_std_string <- "mean\\(\\)|std\\(\\)"
  Needed_features <- dataFeaturesNames[,2][grep(grep_std_string, dataFeaturesNames[,2])]
  SelectedColumns <- c(as.character(Needed_features), "subject" , "activity")
  Data<-subset(Data,select=SelectedColumns)

#Name the column of Data frame with meaningfull names 

  names(Data)<-gsub("tBody", "Time_Body", names(Data))
  names(Data)<-gsub("fBody", "Frequency_Body", names(Data))
  names(Data)<-gsub("tGravity", "Time_Gravity", names(Data))
  names(Data)<-gsub("Acc", "Accelerometer", names(Data))
  names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
  names(Data)<-gsub("Mag", "Magnitude", names(Data))
  names(Data)<-gsub("BodyBody", "Body", names(Data))
  
#Group the data, Create summary , write out the summary

  Data_group <- group_by(Data, subject, activity)
  Data_group_summary <- summarise_each(Data_group, funs(mean))
  write.table(Data_group_summary, file = "tidydata.txt",row.name=FALSE)                                     

}

# The following gives run stack of program Invocation & Run. 
# The output file tidydata.txt has been uploaded to github
# setwd("C:/Coursera/Getting_cleaning_data_Course_project")
# > getwd()
# [1] "C:/Coursera/Getting_cleaning_data_Course_project"
# working_dir <- getwd()
# working_dir
# [1] "C:/Coursera/Getting_cleaning_data_Course_project"
#> source("C:/Coursera/Getting_cleaning_data_Course_project/run_analysis.R")
#> run_analysis(working_dir)
# trying URL 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
# Content type 'application/zip' length 62556944 bytes (59.7 Mb)
# opened URL
# downloaded 59.7 Mb
# 