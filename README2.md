<!DOCTYPE html>
<!-- saved from url=(0038)http://word-to-markdown.herokuapp.com/ -->
<html lang="en"><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Word to Markdown Converter</title>

    <!-- Bootstrap -->
    <link href="http://word-to-markdown.herokuapp.com/vendor/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="http://word-to-markdown.herokuapp.com/assets/style.css" rel="stylesheet">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
      <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>
  <body>

    <h1>Word to Markdown Converter</h1>

    <h2>Results of converting "README1.md"</h2>

<div class="row">
  <div class="col-md-6">
    <h3>Markdown</h3>
    <div class="md-preview">
      <pre id="markdown"># **Getting and Cleaning Data Course Project**

# This projected is implemented as run\_analysis.R is implemented as a function that accepts two arguments working\_dir and download\_dir .

# A valid working\_dir must be supplied ; if the directory is not valid the program will error out ans exit.

# Download\_dir is where processing data from web gets down loaded. The default directory for this is a sub directory under working\_dir called Data.

# The functional specification for this project is 

1. Merges the training and the test sets to create one data set.&amp;nbsp;
2. Extracts only the measurements on the mean and standard deviation for each measurement.&amp;nbsp;
3. Uses descriptive activity names to name the activities in the data set&amp;nbsp;
4. Appropriately labels the data set with descriptive variable names.&amp;nbsp;
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.&amp;nbsp;

# &amp;nbsp; **We will &amp;nbsp;source dplyr library**

# &amp;nbsp; library(dplyr); 

# &amp;nbsp; **Validate that working directory passed is a valid directory &amp; set the working directory**

# &amp;nbsp; if (!file.exists (working\_dir)) {

# &amp;nbsp; &amp;nbsp; &amp;nbsp;stop ("Specify valid working dirctory")

# &amp;nbsp; }

# &amp;nbsp; setwd(working\_dir)

# &amp;nbsp; **#if the directory to down load and manipulate data doesn't exists create that directory**

# &amp;nbsp; if(!file.exists("./data")){dir.create("./data")} 

# &amp;nbsp; **#Down load and Unzip the file to create raw data**

fileUrl&lt;-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# **&amp;nbsp;This assignment was done on windows and needed method="auto" and mode="wb" . The usual recommendation of curl for method did not work**

# &amp;nbsp; download.file(url=fileUrl,destfile="./data/Dataset.zip",mode="wb",method="auto")

# &amp;nbsp; dateDownloaded &lt;- date()

# &amp;nbsp; dateDownloaded

# &amp;nbsp; unzip(zipfile="./data/Dataset.zip",exdir="./data", overwrite = TRUE)

# &amp;nbsp; **Source through directories and create a file path to all the files. We have to specify recursive=TRUE to get the subdirectories also. &amp;nbsp;**

# &amp;nbsp; filepath\_full&lt;- file.path("./data", "UCI HAR Dataset")

# &amp;nbsp; files&lt;-list.files(filepath\_full, recursive=TRUE)

# Displaying variuables in files via a debugger will display following files. The directory they are located is 

# **C:\Coursera\Getting\_Cleaning\_Data\_Course\_Project\data\UCI HAR Dataset**

# files

## &amp;nbsp;[1] "activity\_labels.txt" &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;

## &amp;nbsp;[2] "features\_info.txt" &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;

## &amp;nbsp;[3] "features.txt" &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;

## &amp;nbsp;[4] "README.txt" &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;

## &amp;nbsp;[5] "test/Inertial Signals/body\_acc\_x\_test.txt" &amp;nbsp;

## &amp;nbsp;[6] "test/Inertial Signals/body\_acc\_y\_test.txt" &amp;nbsp;

## &amp;nbsp;[7] "test/Inertial Signals/body\_acc\_z\_test.txt" &amp;nbsp;

## &amp;nbsp;[8] "test/Inertial Signals/body\_gyro\_x\_test.txt" &amp;nbsp;

## &amp;nbsp;[9] "test/Inertial Signals/body\_gyro\_y\_test.txt" &amp;nbsp;

## [10] "test/Inertial Signals/body\_gyro\_z\_test.txt" &amp;nbsp;

## [11] "test/Inertial Signals/total\_acc\_x\_test.txt" &amp;nbsp;

## [12] "test/Inertial Signals/total\_acc\_y\_test.txt" &amp;nbsp;

## [13] "test/Inertial Signals/total\_acc\_z\_test.txt" &amp;nbsp;

## [14] "test/subject\_test.txt" &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;

## [15] "test/X\_test.txt" &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;

## [16] "test/y\_test.txt" &amp;nbsp; &amp;nbsp;

&amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;

## [17] "train/Inertial Signals/body\_acc\_x\_train.txt"

## [18] "train/Inertial Signals/body\_acc\_y\_train.txt"

## [19] "train/Inertial Signals/body\_acc\_z\_train.txt"

## [20] "train/Inertial Signals/body\_gyro\_x\_train.txt"

## [21] "train/Inertial Signals/body\_gyro\_y\_train.txt"

## [22] "train/Inertial Signals/body\_gyro\_z\_train.txt"

## [23] "train/Inertial Signals/total\_acc\_x\_train.txt"

## [24] "train/Inertial Signals/total\_acc\_y\_train.txt"

## [25] "train/Inertial Signals/total\_acc\_z\_train.txt"

## [26] "train/subject\_train.txt" &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;

## [27] "train/X\_train.txt" &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp;

## [28] "train/y\_train.txt"

# **# Read activity file &amp;nbsp; &amp;nbsp;**

# &amp;nbsp; dataActivityTest &amp;nbsp;&lt;- read.table(file.path(filepath\_full, "test" , "Y\_test.txt" ),header = FALSE)

# &amp;nbsp; dataActivityTrain &lt;- read.table(file.path(filepath\_full, "train", "Y\_train.txt"),header = FALSE)

# &amp;nbsp; **# Read the Subject files**

# &amp;nbsp; dataSubjectTrain &lt;- read.table(file.path(filepath\_full, "train", "subject\_train.txt"),header = FALSE)

# &amp;nbsp; dataSubjectTest &amp;nbsp;&lt;- read.table(file.path(filepath\_full, "test" , "subject\_test.txt"),header = FALSE)

# # Read Features &amp;nbsp;files

# &amp;nbsp; dataFeaturesTest &amp;nbsp;&lt;- read.table(file.path(filepath\_full, "test" , "X\_test.txt" ),header = FALSE)

# &amp;nbsp; dataFeaturesTrain &lt;- read.table(file.path(filepath\_full, "train", "X\_train.txt"),header = FALSE)

# &amp;nbsp; **Merge the rows from Train and Test files for Subject , activity and features to produce unified data frame**

# &amp;nbsp; dataSubject &lt;- rbind(dataSubjectTrain, dataSubjectTest)

# &amp;nbsp; dataActivity &lt;- rbind(dataActivityTrain, dataActivityTest)

# &amp;nbsp; dataFeatures &lt;- rbind(dataFeaturesTrain, dataFeaturesTest)

# **Name the fields &amp;nbsp;of subject and activity**

# &amp;nbsp; names(dataSubject)&lt;-c("subject")

# &amp;nbsp; names(dataActivity)&lt;- c("activity")

# &amp;nbsp; **Read the features.txt file and extract the field containing the names .**

# &amp;nbsp; dataFeaturesNames &lt;- read.table (file.path(filepath\_full, "features.txt"), head=FALSE )

# &amp;nbsp; names(dataFeatures) &lt;- dataFeaturesNames$V2

# Do a columnar merge of subject, activity and features to create a single data frame.

# &amp;nbsp; dataCombine &lt;- cbind(dataSubject, dataActivity)

# &amp;nbsp; Data &lt;- cbind(dataFeatures, dataCombine)

# **# we will use grep command to extrace out selected coumns . These columns represene variables that have mean and std in their names . we will subset (using SelectedColumns) the merged data and extract out required &amp;nbsp;data .**

# &amp;nbsp; grep\_std\_string &lt;- "mean\\(\\)|std\\(\\)"

# &amp;nbsp; Needed\_features &lt;- dataFeaturesNames[,2][grep(grep\_std\_string, dataFeaturesNames[,2])]

# &amp;nbsp; SelectedColumns &lt;- c(as.character(Needed\_features), "subject" , "activity")

# &amp;nbsp; **Data&lt;-subset(Data,select=SelectedColumns) &amp;nbsp;****  ****This piece of code acieves subsetting**

# ##############################################################################

# **Name the column of Data frame with meaningful names . we will use gsub function to do a global substitute of source strings to column strings as part of names.**

# **gsub()**** &amp;nbsp; ****function replaces all matches of a string, if the parameter is a string vector, returns a string vector of the same length and with the same attributes (after possible coercion to character). Elements of string vectors which are not substituted will be returned unchanged (including any declared encoding).**** &amp;nbsp;**

# #############################################################################

# &amp;nbsp; names(Data)&lt;-gsub("tBody", "Time\_Body", names(Data))

# &amp;nbsp; names(Data)&lt;-gsub("fBody", "Frequency\_Body", names(Data))

# &amp;nbsp; names(Data)&lt;-gsub("tGravity", "Time\_Gravity", names(Data))

# &amp;nbsp; names(Data)&lt;-gsub("Acc", "Accelerometer", names(Data))

# &amp;nbsp; names(Data)&lt;-gsub("Gyro", "Gyroscope", names(Data))

# &amp;nbsp; names(Data)&lt;-gsub("Mag", "Magnitude", names(Data))

# &amp;nbsp; names(Data)&lt;-gsub("BodyBody", "Body", names(Data))

# #Group the data, Create summary , write out the summary. We will be making use of group\_by , summarize\_each dply utility commands to achieve this.

# &amp;nbsp; Data\_group &lt;- group\_by(Data, subject, activity)

# &amp;nbsp; Data\_group\_summary &lt;- summarise\_each(Data\_group, funs(mean))

# &amp;nbsp; write.table(Data\_group\_summary, file = "tidydata.txt",row.name=FALSE) &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; &amp;nbsp; 

# }

# The following test run proves that tidydata.txt was cteated and uploaded using above piece of R code.

# **# The output file tidydata.txt has been uploaded to github**

# **# setwd("C:/Coursera/Getting\_cleaning\_data\_Course\_project")**

# **# &gt; getwd()**

# **# [1] "C:/Coursera/Getting\_cleaning\_data\_Course\_project"**

# **# working\_dir &lt;- getwd()**

# **# working\_dir**

# **# [1] "C:/Coursera/Getting\_cleaning\_data\_Course\_project"**

# **#&gt; source("C:/Coursera/Getting\_cleaning\_data\_Course\_project/run\_analysis.R")**

# **#&gt; run\_analysis(working\_dir)**

# **# trying URL 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'**

# **# Content type 'application/zip' length 62556944 bytes (59.7 Mb)**

# **# opened URL**

# **# downloaded 59.7 Mb**

# #

&amp;nbsp;</pre>
    </div>
  </div>
  <div class="col-md-6">
    <h3>Rendered</h3>
    <div class="rendered-preview">
      <h1><strong>Getting and Cleaning Data Course Project</strong></h1>

<h1>This projected is implemented as run_analysis.R is implemented as a function that accepts two arguments working_dir and download_dir .</h1>

<h1>A valid working_dir must be supplied ; if the directory is not valid the program will error out ans exit.</h1>

<h1>Download_dir is where processing data from web gets down loaded. The default directory for this is a sub directory under working_dir called Data.</h1>

<h1>The functional specification for this project is</h1>

<ol>
<li>Merges the training and the test sets to create one data set.&nbsp;</li>
<li>Extracts only the measurements on the mean and standard deviation for each measurement.&nbsp;</li>
<li>Uses descriptive activity names to name the activities in the data set&nbsp;</li>
<li>Appropriately labels the data set with descriptive variable names.&nbsp;</li>
<li>From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.&nbsp;</li>
</ol>

<h1>&nbsp; <strong>We will &nbsp;source dplyr library</strong></h1>

<h1>&nbsp; library(dplyr);</h1>

<h1>&nbsp; <strong>Validate that working directory passed is a valid directory &amp; set the working directory</strong></h1>

<h1>&nbsp; if (!file.exists (working_dir)) {</h1>

<h1>&nbsp; &nbsp; &nbsp;stop ("Specify valid working dirctory")</h1>

<h1>&nbsp; }</h1>

<h1>&nbsp; setwd(working_dir)</h1>

<h1>&nbsp; <strong>#if the directory to down load and manipulate data doesn't exists create that directory</strong></h1>

<h1>&nbsp; if(!file.exists("./data")){dir.create("./data")}</h1>

<h1>&nbsp; <strong>#Down load and Unzip the file to create raw data</strong></h1>

<p>fileUrl&lt;-"<a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip</a>"</p>

<h1><strong>&nbsp;This assignment was done on windows and needed method="auto" and mode="wb" . The usual recommendation of curl for method did not work</strong></h1>

<h1>&nbsp; download.file(url=fileUrl,destfile="./data/Dataset.zip",mode="wb",method="auto")</h1>

<h1>&nbsp; dateDownloaded &lt;- date()</h1>

<h1>&nbsp; dateDownloaded</h1>

<h1>&nbsp; unzip(zipfile="./data/Dataset.zip",exdir="./data", overwrite = TRUE)</h1>

<h1>&nbsp; <strong>Source through directories and create a file path to all the files. We have to specify recursive=TRUE to get the subdirectories also. &nbsp;</strong></h1>

<h1>&nbsp; filepath_full&lt;- file.path("./data", "UCI HAR Dataset")</h1>

<h1>&nbsp; files&lt;-list.files(filepath_full, recursive=TRUE)</h1>

<h1>Displaying variuables in files via a debugger will display following files. The directory they are located is</h1>

<h1><strong>C:\Coursera\Getting_Cleaning_Data_Course_Project\data\UCI HAR Dataset</strong></h1>

<h1>files</h1>

<h2>&nbsp;[1] "activity_labels.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</h2>

<h2>&nbsp;[2] "features_info.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</h2>

<h2>&nbsp;[3] "features.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</h2>

<h2>&nbsp;[4] "README.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</h2>

<h2>&nbsp;[5] "test/Inertial Signals/body_acc_x_test.txt" &nbsp;</h2>

<h2>&nbsp;[6] "test/Inertial Signals/body_acc_y_test.txt" &nbsp;</h2>

<h2>&nbsp;[7] "test/Inertial Signals/body_acc_z_test.txt" &nbsp;</h2>

<h2>&nbsp;[8] "test/Inertial Signals/body_gyro_x_test.txt" &nbsp;</h2>

<h2>&nbsp;[9] "test/Inertial Signals/body_gyro_y_test.txt" &nbsp;</h2>

<h2>[10] "test/Inertial Signals/body_gyro_z_test.txt" &nbsp;</h2>

<h2>[11] "test/Inertial Signals/total_acc_x_test.txt" &nbsp;</h2>

<h2>[12] "test/Inertial Signals/total_acc_y_test.txt" &nbsp;</h2>

<h2>[13] "test/Inertial Signals/total_acc_z_test.txt" &nbsp;</h2>

<h2>[14] "test/subject_test.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</h2>

<h2>[15] "test/X_test.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</h2>

<h2>[16] "test/y_test.txt" &nbsp; &nbsp;</h2>

<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</p>

<h2>[17] "train/Inertial Signals/body_acc_x_train.txt"</h2>

<h2>[18] "train/Inertial Signals/body_acc_y_train.txt"</h2>

<h2>[19] "train/Inertial Signals/body_acc_z_train.txt"</h2>

<h2>[20] "train/Inertial Signals/body_gyro_x_train.txt"</h2>

<h2>[21] "train/Inertial Signals/body_gyro_y_train.txt"</h2>

<h2>[22] "train/Inertial Signals/body_gyro_z_train.txt"</h2>

<h2>[23] "train/Inertial Signals/total_acc_x_train.txt"</h2>

<h2>[24] "train/Inertial Signals/total_acc_y_train.txt"</h2>

<h2>[25] "train/Inertial Signals/total_acc_z_train.txt"</h2>

<h2>[26] "train/subject_train.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</h2>

<h2>[27] "train/X_train.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</h2>

<h2>[28] "train/y_train.txt"</h2>

<h1><strong># Read activity file &nbsp; &nbsp;</strong></h1>

<h1>&nbsp; dataActivityTest &nbsp;&lt;- read.table(file.path(filepath_full, "test" , "Y_test.txt" ),header = FALSE)</h1>

<h1>&nbsp; dataActivityTrain &lt;- read.table(file.path(filepath_full, "train", "Y_train.txt"),header = FALSE)</h1>

<h1>&nbsp; <strong># Read the Subject files</strong></h1>

<h1>&nbsp; dataSubjectTrain &lt;- read.table(file.path(filepath_full, "train", "subject_train.txt"),header = FALSE)</h1>

<h1>&nbsp; dataSubjectTest &nbsp;&lt;- read.table(file.path(filepath_full, "test" , "subject_test.txt"),header = FALSE)</h1>

<h1># Read Features &nbsp;files</h1>

<h1>&nbsp; dataFeaturesTest &nbsp;&lt;- read.table(file.path(filepath_full, "test" , "X_test.txt" ),header = FALSE)</h1>

<h1>&nbsp; dataFeaturesTrain &lt;- read.table(file.path(filepath_full, "train", "X_train.txt"),header = FALSE)</h1>

<h1>&nbsp; <strong>Merge the rows from Train and Test files for Subject , activity and features to produce unified data frame</strong></h1>

<h1>&nbsp; dataSubject &lt;- rbind(dataSubjectTrain, dataSubjectTest)</h1>

<h1>&nbsp; dataActivity &lt;- rbind(dataActivityTrain, dataActivityTest)</h1>

<h1>&nbsp; dataFeatures &lt;- rbind(dataFeaturesTrain, dataFeaturesTest)</h1>

<h1><strong>Name the fields &nbsp;of subject and activity</strong></h1>

<h1>&nbsp; names(dataSubject)&lt;-c("subject")</h1>

<h1>&nbsp; names(dataActivity)&lt;- c("activity")</h1>

<h1>&nbsp; <strong>Read the features.txt file and extract the field containing the names .</strong></h1>

<h1>&nbsp; dataFeaturesNames &lt;- read.table (file.path(filepath_full, "features.txt"), head=FALSE )</h1>

<h1>&nbsp; names(dataFeatures) &lt;- dataFeaturesNames$V2</h1>

<h1>Do a columnar merge of subject, activity and features to create a single data frame.</h1>

<h1>&nbsp; dataCombine &lt;- cbind(dataSubject, dataActivity)</h1>

<h1>&nbsp; Data &lt;- cbind(dataFeatures, dataCombine)</h1>

<h1><strong># we will use grep command to extrace out selected coumns . These columns represene variables that have mean and std in their names . we will subset (using SelectedColumns) the merged data and extract out required &nbsp;data .</strong></h1>

<h1>&nbsp; grep_std_string &lt;- "mean\(\)|std\(\)"</h1>

<h1>&nbsp; Needed_features &lt;- dataFeaturesNames[,2][grep(grep_std_string, dataFeaturesNames[,2])]</h1>

<h1>&nbsp; SelectedColumns &lt;- c(as.character(Needed_features), "subject" , "activity")</h1>

<h1>&nbsp; <strong>Data&lt;-subset(Data,select=SelectedColumns) &nbsp;</strong>**  *<em>**This piece of code acieves subsetting</em>*</h1>

<h1><strong>Name the column of Data frame with meaningful names . we will use gsub function to do a global substitute of source strings to column strings as part of names.</strong></h1>

<h1><strong>gsub()</strong>** &nbsp; *<strong><em>function replaces all matches of a string, if the parameter is a string vector, returns a string vector of the same length and with the same attributes (after possible coercion to character). Elements of string vectors which are not substituted will be returned unchanged (including any declared encoding).</em></strong>* &nbsp;**</h1>

<h1>&nbsp; names(Data)&lt;-gsub("tBody", "Time_Body", names(Data))</h1>

<h1>&nbsp; names(Data)&lt;-gsub("fBody", "Frequency_Body", names(Data))</h1>

<h1>&nbsp; names(Data)&lt;-gsub("tGravity", "Time_Gravity", names(Data))</h1>

<h1>&nbsp; names(Data)&lt;-gsub("Acc", "Accelerometer", names(Data))</h1>

<h1>&nbsp; names(Data)&lt;-gsub("Gyro", "Gyroscope", names(Data))</h1>

<h1>&nbsp; names(Data)&lt;-gsub("Mag", "Magnitude", names(Data))</h1>

<h1>&nbsp; names(Data)&lt;-gsub("BodyBody", "Body", names(Data))</h1>

<h1>#Group the data, Create summary , write out the summary. We will be making use of group_by , summarize_each dply utility commands to achieve this.</h1>

<h1>&nbsp; Data_group &lt;- group_by(Data, subject, activity)</h1>

<h1>&nbsp; Data_group_summary &lt;- summarise_each(Data_group, funs(mean))</h1>

<h1>&nbsp; write.table(Data_group_summary, file = "tidydata.txt",row.name=FALSE) &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</h1>

<h1>}</h1>

<h1>The following test run proves that tidydata.txt was cteated and uploaded using above piece of R code.</h1>

<h1><strong># The output file tidydata.txt has been uploaded to github</strong></h1>

<h1><strong># setwd("C:/Coursera/Getting_cleaning_data_Course_project")</strong></h1>

<h1><strong># &gt; getwd()</strong></h1>

<h1><strong># [1] "C:/Coursera/Getting_cleaning_data_Course_project"</strong></h1>

<h1><strong># working_dir &lt;- getwd()</strong></h1>

<h1><strong># working_dir</strong></h1>

<h1><strong># [1] "C:/Coursera/Getting_cleaning_data_Course_project"</strong></h1>

<h1><strong>#&gt; source("C:/Coursera/Getting_cleaning_data_Course_project/run_analysis.R")</strong></h1>

<h1><strong>#&gt; run_analysis(working_dir)</strong></h1>

<h1><strong># trying URL '<a href="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip">https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip</a>'</strong></h1>

<h1><strong># Content type 'application/zip' length 62556944 bytes (59.7 Mb)</strong></h1>

<h1><strong># opened URL</strong></h1>

<h1><strong># downloaded 59.7 Mb</strong></h1>

<p>&nbsp;</p>
    </div>
  </div>
</div>

<div class="moar">
  <button id="copy-button" class="btn" data-clipboard-target="markdown">Copy to clipboard</button>
  <p>Want to <a href="./README2_files/README2.md">convert another document</a>?</p>
</div>

<script src="./README2_files/ZeroClipboard.min.js"></script>
<script>var client = new ZeroClipboard(document.getElementById("copy-button"));</script><div id="global-zeroclipboard-html-bridge" class="global-zeroclipboard-container" style="position: absolute; left: 0px; top: -9999px; width: 1px; height: 1px; z-index: 999999999;"><object id="global-zeroclipboard-flash-bridge" name="global-zeroclipboard-flash-bridge" width="100%" height="100%" type="application/x-shockwave-flash" data="http://word-to-markdown.herokuapp.com/vendor/zeroclipboard/dist/ZeroClipboard.swf?noCache=1426352963239"><param name="allowScriptAccess" value="sameDomain"><param name="allowNetworking" value="all"><param name="menu" value="false"><param name="wmode" value="transparent"><param name="flashvars" value="trustedOrigins=word-to-markdown.herokuapp.com%2C%2F%2Fword-to-markdown.herokuapp.com%2Chttp%3A%2F%2Fword-to-markdown.herokuapp.com&amp;swfObjectId=global-zeroclipboard-flash-bridge&amp;jsVersion=2.2.0"><div id="global-zeroclipboard-flash-bridge_fallbackContent">&nbsp;</div></object></div>


    <footer>
      <a href="http://ben.balter.com/">@benbalter</a> | <a href="https://github.com/benbalter/word-to-markdown">source</a> | <a href="https://github.com/benbalter/word-to-markdown/blob/master/CONTRIBUTING.md">feedback</a>
    </footer>

    <script src="./README2_files/jquery.min.js"></script>
    <script src="./README2_files/app.js"></script>
    <script src="./README2_files/bootstrap.min.js"></script>
  

</body></html>