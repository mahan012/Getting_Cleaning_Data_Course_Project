Getting and Cleaning Data Course ProjectGetting and Cleaning Data Course Project

#######################################################################################################################

**This projected is implemented as run\_analysis.R is implemented as a function that accepts two arguments working\_dir and download\_dir .**

**A valid working\_dir must be supplied; if the directory is not valid the program will error out and exit.**

**Download\_dir is where processing data from web gets down loaded. The default directory for this is a sub directory under working\_dir called Data.**

&nbsp;

**The functional specification for this project is**

**(1) Merges the training and the test sets to create one data set.**

**(2) Extracts only the measurements on the mean and standard deviation for each measurement.**

**(3) Uses descriptive activity names to name the activities in the data set**

**(4) Appropriately labels the data set with descriptive variable names.**

**(5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**

#########################################################################################################################

**We will source dplyr library**

libarary(dplyr)

**##### Validate that working directory passed is a valid directory & set the working directory**

&nbsp; &nbsp;if (!file.exists (working\_dir)) {

&nbsp; &nbsp; &nbsp;stop ("Specify valid working dirctory")

&nbsp; }

**&nbsp; setwd(working\_dir)**

**#####** I **f the directory to down load and manipulate data doesn't exists create that directory**

&nbsp;if(!file.exists("./data")){dir.create("./data")}

**##### Down load and Unzip the file to create raw data**

fileUrl <- [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

&nbsp;

**##### This assignment was done on windows and needed method="auto" and mode="wb" . The usual recommendation of curl for method did not work**

&nbsp;

&nbsp; download.file(url=fileUrl,destfile="./data/Dataset.zip",mode="wb",method="auto")

&nbsp; dateDownloaded <- date()

&nbsp; dateDownloaded

&nbsp; unzip(zipfile="./data/Dataset.zip",exdir="./data", overwrite = TRUE)

&nbsp;

**##### Source through directories and create a file path to all the files. We have to specify recursive=TRUE to get the subdirectories also. &nbsp;**

&nbsp;

&nbsp; filepath\_full<- file.path("./data", "UCI HAR Dataset")

&nbsp; files<-list.files(filepath\_full, recursive=TRUE)

&nbsp;

**##### Displaying variuables in files via a debugger will display following files. The directory they are located is**

C:\Coursera\Getting\_Cleaning\_Data\_Course\_Project\data\UCI HAR Dataset

&nbsp;

Files

######################################################################################################

&nbsp;[1] "activity\_labels.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

&nbsp;[2] "features\_info.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

&nbsp;[3] "features.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

&nbsp;[4] "README.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

&nbsp;[5] "test/Inertial Signals/body\_acc\_x\_test.txt" &nbsp;

&nbsp;[6] "test/Inertial Signals/body\_acc\_y\_test.txt" &nbsp;

&nbsp;[7] "test/Inertial Signals/body\_acc\_z\_test.txt" &nbsp;

&nbsp;[8] "test/Inertial Signals/body\_gyro\_x\_test.txt" &nbsp;

&nbsp;[9] "test/Inertial Signals/body\_gyro\_y\_test.txt" &nbsp;

[10] "test/Inertial Signals/body\_gyro\_z\_test.txt" &nbsp;

[11] "test/Inertial Signals/total\_acc\_x\_test.txt" &nbsp;

[12] "test/Inertial Signals/total\_acc\_y\_test.txt" &nbsp;

[13] "test/Inertial Signals/total\_acc\_z\_test.txt" &nbsp;

[14] "test/subject\_test.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[15] "test/X\_test.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[16] "test/y\_test.txt" &nbsp; &nbsp;

&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[17] "train/Inertial Signals/body\_acc\_x\_train.txt"

[18] "train/Inertial Signals/body\_acc\_y\_train.txt"

[19] "train/Inertial Signals/body\_acc\_z\_train.txt"

[20] "train/Inertial Signals/body\_gyro\_x\_train.txt"

[21] "train/Inertial Signals/body\_gyro\_y\_train.txt"

[22] "train/Inertial Signals/body\_gyro\_z\_train.txt"

[23] "train/Inertial Signals/total\_acc\_x\_train.txt"

[24] "train/Inertial Signals/total\_acc\_y\_train.txt"

[25] "train/Inertial Signals/total\_acc\_z\_train.txt"

[26] "train/subject\_train.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[27] "train/X\_train.txt" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[28] "train/y\_train.txt"

###########################################################################################################

**&nbsp;##### Read activity file &nbsp; &nbsp;**

&nbsp; dataActivityTest &nbsp;<- read.table(file.path(filepath\_full, "test" , "Y\_test.txt" ),header = FALSE)

&nbsp; dataActivityTrain <- read.table(file.path(filepath\_full, "train", "Y\_train.txt"),header = FALSE)

&nbsp;

**&nbsp;#####**** Read the Subject files**

&nbsp;

&nbsp; dataSubjectTrain <- read.table(file.path(filepath\_full, "train", "subject\_train.txt"),header = FALSE)

&nbsp; dataSubjectTest &nbsp;<- read.table(file.path(filepath\_full, "test" , "subject\_test.txt"),header = FALSE)

&nbsp;

**&nbsp;##### Read Features &nbsp;files**

&nbsp; dataFeaturesTest &nbsp;<- read.table(file.path(filepath\_full, "test" , "X\_test.txt" ),header = FALSE)

&nbsp; dataFeaturesTrain <- read.table(file.path(filepath\_full, "train", "X\_train.txt"),header = FALSE)

**Look at the properties of the above varibles**

str(dataActivityTest)

## 'data.frame': &nbsp; &nbsp;2947 obs. of &nbsp;1 variable:

## &nbsp;$ V1: int &nbsp;5 5 5 5 5 5 5 5 5 5 ...

str(dataActivityTrain)

## 'data.frame': &nbsp; &nbsp;7352 obs. of &nbsp;1 variable:

## &nbsp;$ V1: int &nbsp;5 5 5 5 5 5 5 5 5 5 ...

str(dataSubjectTrain)

## 'data.frame': &nbsp; &nbsp;7352 obs. of &nbsp;1 variable:

## &nbsp;$ V1: int &nbsp;1 1 1 1 1 1 1 1 1 1 ...

str(dataSubjectTest)

## 'data.frame': &nbsp; &nbsp;2947 obs. of &nbsp;1 variable:

## &nbsp;$ V1: int &nbsp;2 2 2 2 2 2 2 2 2 2 ...

str(dataFeaturesTest)

## 'data.frame': &nbsp; &nbsp;2947 obs. of &nbsp;561 variables:

## &nbsp;$ V1 &nbsp;: num &nbsp;0.257 0.286 0.275 0.27 0.275 ...

## &nbsp;$ V2 &nbsp;: num &nbsp;-0.0233 -0.0132 -0.0261 -0.0326 -0.0278 ...

## &nbsp;$ V3 &nbsp;: num &nbsp;-0.0147 -0.1191 -0.1182 -0.1175 -0.1295 ...

## &nbsp;$ V4 &nbsp;: num &nbsp;-0.938 -0.975 -0.994 -0.995 -0.994 ...

## &nbsp;$ V5 &nbsp;: num &nbsp;-0.92 -0.967 -0.97 -0.973 -0.967 ...

## &nbsp;$ V6 &nbsp;: num &nbsp;-0.668 -0.945 -0.963 -0.967 -0.978 ...

## &nbsp;$ V7 &nbsp;: num &nbsp;-0.953 -0.987 -0.994 -0.995 -0.994 ...

## &nbsp;$ V8 &nbsp;: num &nbsp;-0.925 -0.968 -0.971 -0.974 -0.966 ...

## &nbsp;$ V9 &nbsp;: num &nbsp;-0.674 -0.946 -0.963 -0.969 -0.977 ...

## &nbsp;$ V10 : num &nbsp;-0.894 -0.894 -0.939 -0.939 -0.939 ...

## &nbsp;$ V11 : num &nbsp;-0.555 -0.555 -0.569 -0.569 -0.561 ...

## &nbsp;$ V12 : num &nbsp;-0.466 -0.806 -0.799 -0.799 -0.826 ...

## &nbsp;$ V13 : num &nbsp;0.717 0.768 0.848 0.848 0.849 ...

## &nbsp;$ V14 : num &nbsp;0.636 0.684 0.668 0.668 0.671 ...

## &nbsp;$ V15 : num &nbsp;0.789 0.797 0.822 0.822 0.83 ...

## &nbsp;$ V16 : num &nbsp;-0.878 -0.969 -0.977 -0.974 -0.975 ...

## &nbsp;$ V17 : num &nbsp;-0.998 -1 -1 -1 -1 ...

## &nbsp;$ V18 : num &nbsp;-0.998 -1 -1 -0.999 -0.999 ...

## &nbsp;$ V19 : num &nbsp;-0.934 -0.998 -0.999 -0.999 -0.999 ...

## &nbsp;$ V20 : num &nbsp;-0.976 -0.994 -0.993 -0.995 -0.993 ...

## &nbsp;$ V21 : num &nbsp;-0.95 -0.974 -0.974 -0.979 -0.967 ...

## &nbsp;$ V22 : num &nbsp;-0.83 -0.951 -0.965 -0.97 -0.976 ...

## &nbsp;$ V23 : num &nbsp;-0.168 -0.302 -0.618 -0.75 -0.591 ...

## &nbsp;$ V24 : num &nbsp;-0.379 -0.348 -0.695 -0.899 -0.74 ...

## &nbsp;$ V25 : num &nbsp;0.246 -0.405 -0.537 -0.554 -0.799 ...

## &nbsp;$ V26 : num &nbsp;0.521 0.507 0.242 0.175 0.116 ...

## &nbsp;$ V27 : num &nbsp;-0.4878 -0.1565 -0.115 -0.0513 -0.0289 ...

## &nbsp;$ V28 : num &nbsp;0.4823 0.0407 0.0327 0.0342 -0.0328 ...

## &nbsp;$ V29 : num &nbsp;-0.0455 0.273 0.1924 0.1536 0.2943 ...

## &nbsp;$ V30 : num &nbsp;0.21196 0.19757 -0.01194 0.03077 0.00063 ...

## &nbsp;$ V31 : num &nbsp;-0.1349 -0.1946 -0.0634 -0.1293 -0.0453 ...

## &nbsp;$ V32 : num &nbsp;0.131 0.411 0.471 0.446 0.168 ...

## &nbsp;$ V33 : num &nbsp;-0.0142 -0.3405 -0.5074 -0.4195 -0.0682 ...

## &nbsp;$ V34 : num &nbsp;-0.106 0.0776 0.1885 0.2715 0.0744 ...

## &nbsp;$ V35 : num &nbsp;0.0735 -0.084 -0.2316 -0.2258 0.0271 ...

## &nbsp;$ V36 : num &nbsp;-0.1715 0.0353 0.6321 0.4164 -0.1459 ...

## &nbsp;$ V37 : num &nbsp;0.0401 -0.0101 -0.5507 -0.2864 -0.0502 ...

## &nbsp;$ V38 : num &nbsp;0.077 -0.105 0.3057 -0.0638 0.2352 ...

## &nbsp;$ V39 : num &nbsp;-0.491 -0.429 -0.324 -0.167 0.29 ...

## &nbsp;$ V40 : num &nbsp;-0.709 0.399 0.28 0.545 0.458 ...

## &nbsp;$ V41 : num &nbsp;0.936 0.927 0.93 0.929 0.927 ...

## &nbsp;$ V42 : num &nbsp;-0.283 -0.289 -0.288 -0.293 -0.303 ...

## &nbsp;$ V43 : num &nbsp;0.115 0.153 0.146 0.143 0.138 ...

## &nbsp;$ V44 : num &nbsp;-0.925 -0.989 -0.996 -0.993 -0.996 ...

## &nbsp;$ V45 : num &nbsp;-0.937 -0.984 -0.988 -0.97 -0.971 ...

## &nbsp;$ V46 : num &nbsp;-0.564 -0.965 -0.982 -0.992 -0.968 ...

## &nbsp;$ V47 : num &nbsp;-0.93 -0.989 -0.996 -0.993 -0.996 ...

## &nbsp;$ V48 : num &nbsp;-0.938 -0.983 -0.989 -0.971 -0.971 ...

## &nbsp;$ V49 : num &nbsp;-0.606 -0.965 -0.98 -0.993 -0.969 ...

## &nbsp;$ V50 : num &nbsp;0.906 0.856 0.856 0.856 0.854 ...

## &nbsp;$ V51 : num &nbsp;-0.279 -0.305 -0.305 -0.305 -0.313 ...

## &nbsp;$ V52 : num &nbsp;0.153 0.153 0.139 0.136 0.134 ...

## &nbsp;$ V53 : num &nbsp;0.944 0.944 0.949 0.947 0.946 ...

## &nbsp;$ V54 : num &nbsp;-0.262 -0.262 -0.262 -0.273 -0.279 ...

## &nbsp;$ V55 : num &nbsp;-0.0762 0.149 0.145 0.1421 0.1309 ...

## &nbsp;$ V56 : num &nbsp;-0.0178 0.0577 0.0406 0.0461 0.0554 ...

## &nbsp;$ V57 : num &nbsp;0.829 0.806 0.812 0.809 0.804 ...

## &nbsp;$ V58 : num &nbsp;-0.865 -0.858 -0.86 -0.854 -0.843 ...

## &nbsp;$ V59 : num &nbsp;-0.968 -0.957 -0.961 -0.963 -0.965 ...

## &nbsp;$ V60 : num &nbsp;-0.95 -0.988 -0.996 -0.992 -0.996 ...

## &nbsp;$ V61 : num &nbsp;-0.946 -0.982 -0.99 -0.973 -0.972 ...

## &nbsp;$ V62 : num &nbsp;-0.76 -0.971 -0.979 -0.996 -0.969 ...

## &nbsp;$ V63 : num &nbsp;-0.425 -0.729 -0.823 -0.823 -0.83 ...

## &nbsp;$ V64 : num &nbsp;-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ...

## &nbsp;$ V65 : num &nbsp;0.219 -0.465 -0.53 -0.7 -0.302 ...

## &nbsp;$ V66 : num &nbsp;-0.43 -0.51 -0.295 -0.343 -0.482 ...

## &nbsp;$ V67 : num &nbsp;0.431 0.525 0.305 0.359 0.539 ...

## &nbsp;$ V68 : num &nbsp;-0.432 -0.54 -0.315 -0.375 -0.596 ...

## &nbsp;$ V69 : num &nbsp;0.433 0.554 0.326 0.392 0.655 ...

## &nbsp;$ V70 : num &nbsp;-0.795 -0.746 -0.232 -0.233 -0.493 ...

## &nbsp;$ V71 : num &nbsp;0.781 0.733 0.169 0.176 0.463 ...

## &nbsp;$ V72 : num &nbsp;-0.78 -0.737 -0.155 -0.169 -0.465 ...

## &nbsp;$ V73 : num &nbsp;0.785 0.749 0.164 0.185 0.483 ...

## &nbsp;$ V74 : num &nbsp;-0.984 -0.845 -0.429 -0.297 -0.536 ...

## &nbsp;$ V75 : num &nbsp;0.987 0.869 0.44 0.304 0.544 ...

## &nbsp;$ V76 : num &nbsp;-0.989 -0.893 -0.451 -0.311 -0.553 ...

## &nbsp;$ V77 : num &nbsp;0.988 0.913 0.458 0.315 0.559 ...

## &nbsp;$ V78 : num &nbsp;0.981 0.945 0.548 0.986 0.998 ...

## &nbsp;$ V79 : num &nbsp;-0.996 -0.911 -0.335 0.653 0.916 ...

## &nbsp;$ V80 : num &nbsp;-0.96 -0.739 0.59 0.747 0.929 ...

## &nbsp;$ V81 : num &nbsp;0.072 0.0702 0.0694 0.0749 0.0784 ...

## &nbsp;$ V82 : num &nbsp;0.04575 -0.01788 -0.00491 0.03227 0.02228 ...

## &nbsp;$ V83 : num &nbsp;-0.10604 -0.00172 -0.01367 0.01214 0.00275 ...

## &nbsp;$ V84 : num &nbsp;-0.907 -0.949 -0.991 -0.991 -0.992 ...

## &nbsp;$ V85 : num &nbsp;-0.938 -0.973 -0.971 -0.973 -0.979 ...

## &nbsp;$ V86 : num &nbsp;-0.936 -0.978 -0.973 -0.976 -0.987 ...

## &nbsp;$ V87 : num &nbsp;-0.916 -0.969 -0.991 -0.99 -0.991 ...

## &nbsp;$ V88 : num &nbsp;-0.937 -0.974 -0.973 -0.973 -0.977 ...

## &nbsp;$ V89 : num &nbsp;-0.949 -0.979 -0.975 -0.978 -0.985 ...

## &nbsp;$ V90 : num &nbsp;-0.903 -0.915 -0.992 -0.992 -0.994 ...

## &nbsp;$ V91 : num &nbsp;-0.95 -0.981 -0.975 -0.975 -0.986 ...

## &nbsp;$ V92 : num &nbsp;-0.891 -0.978 -0.962 -0.962 -0.986 ...

## &nbsp;$ V93 : num &nbsp;0.898 0.898 0.994 0.994 0.994 ...

## &nbsp;$ V94 : num &nbsp;0.95 0.968 0.976 0.976 0.98 ...

## &nbsp;$ V95 : num &nbsp;0.946 0.966 0.966 0.97 0.985 ...

## &nbsp;$ V96 : num &nbsp;-0.931 -0.974 -0.982 -0.983 -0.987 ...

## &nbsp;$ V97 : num &nbsp;-0.995 -0.998 -1 -1 -1 ...

## &nbsp;$ V98 : num &nbsp;-0.997 -0.999 -0.999 -0.999 -1 ...

## &nbsp;$ V99 : num &nbsp;-0.997 -0.999 -0.999 -0.999 -1 ...

## &nbsp; [list output truncated]

str(dataFeaturesTrain)

## 'data.frame': &nbsp; &nbsp;7352 obs. of &nbsp;561 variables:

## &nbsp;$ V1 &nbsp;: num &nbsp;0.289 0.278 0.28 0.279 0.277 ...

## &nbsp;$ V2 &nbsp;: num &nbsp;-0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...

## &nbsp;$ V3 &nbsp;: num &nbsp;-0.133 -0.124 -0.113 -0.123 -0.115 ...

## &nbsp;$ V4 &nbsp;: num &nbsp;-0.995 -0.998 -0.995 -0.996 -0.998 ...

## &nbsp;$ V5 &nbsp;: num &nbsp;-0.983 -0.975 -0.967 -0.983 -0.981 ...

## &nbsp;$ V6 &nbsp;: num &nbsp;-0.914 -0.96 -0.979 -0.991 -0.99 ...

## &nbsp;$ V7 &nbsp;: num &nbsp;-0.995 -0.999 -0.997 -0.997 -0.998 ...

## &nbsp;$ V8 &nbsp;: num &nbsp;-0.983 -0.975 -0.964 -0.983 -0.98 ...

## &nbsp;$ V9 &nbsp;: num &nbsp;-0.924 -0.958 -0.977 -0.989 -0.99 ...

## &nbsp;$ V10 : num &nbsp;-0.935 -0.943 -0.939 -0.939 -0.942 ...

## &nbsp;$ V11 : num &nbsp;-0.567 -0.558 -0.558 -0.576 -0.569 ...

## &nbsp;$ V12 : num &nbsp;-0.744 -0.818 -0.818 -0.83 -0.825 ...

## &nbsp;$ V13 : num &nbsp;0.853 0.849 0.844 0.844 0.849 ...

## &nbsp;$ V14 : num &nbsp;0.686 0.686 0.682 0.682 0.683 ...

## &nbsp;$ V15 : num &nbsp;0.814 0.823 0.839 0.838 0.838 ...

## &nbsp;$ V16 : num &nbsp;-0.966 -0.982 -0.983 -0.986 -0.993 ...

## &nbsp;$ V17 : num &nbsp;-1 -1 -1 -1 -1 ...

## &nbsp;$ V18 : num &nbsp;-1 -1 -1 -1 -1 ...

## &nbsp;$ V19 : num &nbsp;-0.995 -0.998 -0.999 -1 -1 ...

## &nbsp;$ V20 : num &nbsp;-0.994 -0.999 -0.997 -0.997 -0.998 ...

## &nbsp;$ V21 : num &nbsp;-0.988 -0.978 -0.965 -0.984 -0.981 ...

## &nbsp;$ V22 : num &nbsp;-0.943 -0.948 -0.975 -0.986 -0.991 ...

## &nbsp;$ V23 : num &nbsp;-0.408 -0.715 -0.592 -0.627 -0.787 ...

## &nbsp;$ V24 : num &nbsp;-0.679 -0.501 -0.486 -0.851 -0.559 ...

## &nbsp;$ V25 : num &nbsp;-0.602 -0.571 -0.571 -0.912 -0.761 ...

## &nbsp;$ V26 : num &nbsp;0.9293 0.6116 0.273 0.0614 0.3133 ...

## &nbsp;$ V27 : num &nbsp;-0.853 -0.3295 -0.0863 0.0748 -0.1312 ...

## &nbsp;$ V28 : num &nbsp;0.36 0.284 0.337 0.198 0.191 ...

## &nbsp;$ V29 : num &nbsp;-0.0585 0.2846 -0.1647 -0.2643 0.0869 ...

## &nbsp;$ V30 : num &nbsp;0.2569 0.1157 0.0172 0.0725 0.2576 ...

## &nbsp;$ V31 : num &nbsp;-0.2248 -0.091 -0.0745 -0.1553 -0.2725 ...

## &nbsp;$ V32 : num &nbsp;0.264 0.294 0.342 0.323 0.435 ...

## &nbsp;$ V33 : num &nbsp;-0.0952 -0.2812 -0.3326 -0.1708 -0.3154 ...

## &nbsp;$ V34 : num &nbsp;0.279 0.086 0.239 0.295 0.44 ...

## &nbsp;$ V35 : num &nbsp;-0.4651 -0.0222 -0.1362 -0.3061 -0.2691 ...

## &nbsp;$ V36 : num &nbsp;0.4919 -0.0167 0.1739 0.4821 0.1794 ...

## &nbsp;$ V37 : num &nbsp;-0.191 -0.221 -0.299 -0.47 -0.089 ...

## &nbsp;$ V38 : num &nbsp;0.3763 -0.0134 -0.1247 -0.3057 -0.1558 ...

## &nbsp;$ V39 : num &nbsp;0.4351 -0.0727 -0.1811 -0.3627 -0.1898 ...

## &nbsp;$ V40 : num &nbsp;0.661 0.579 0.609 0.507 0.599 ...

## &nbsp;$ V41 : num &nbsp;0.963 0.967 0.967 0.968 0.968 ...

## &nbsp;$ V42 : num &nbsp;-0.141 -0.142 -0.142 -0.144 -0.149 ...

## &nbsp;$ V43 : num &nbsp;0.1154 0.1094 0.1019 0.0999 0.0945 ...

## &nbsp;$ V44 : num &nbsp;-0.985 -0.997 -1 -0.997 -0.998 ...

## &nbsp;$ V45 : num &nbsp;-0.982 -0.989 -0.993 -0.981 -0.988 ...

## &nbsp;$ V46 : num &nbsp;-0.878 -0.932 -0.993 -0.978 -0.979 ...

## &nbsp;$ V47 : num &nbsp;-0.985 -0.998 -1 -0.996 -0.998 ...

## &nbsp;$ V48 : num &nbsp;-0.984 -0.99 -0.993 -0.981 -0.989 ...

## &nbsp;$ V49 : num &nbsp;-0.895 -0.933 -0.993 -0.978 -0.979 ...

## &nbsp;$ V50 : num &nbsp;0.892 0.892 0.892 0.894 0.894 ...

## &nbsp;$ V51 : num &nbsp;-0.161 -0.161 -0.164 -0.164 -0.167 ...

## &nbsp;$ V52 : num &nbsp;0.1247 0.1226 0.0946 0.0934 0.0917 ...

## &nbsp;$ V53 : num &nbsp;0.977 0.985 0.987 0.987 0.987 ...

## &nbsp;$ V54 : num &nbsp;-0.123 -0.115 -0.115 -0.121 -0.122 ...

## &nbsp;$ V55 : num &nbsp;0.0565 0.1028 0.1028 0.0958 0.0941 ...

## &nbsp;$ V56 : num &nbsp;-0.375 -0.383 -0.402 -0.4 -0.4 ...

## &nbsp;$ V57 : num &nbsp;0.899 0.908 0.909 0.911 0.912 ...

## &nbsp;$ V58 : num &nbsp;-0.971 -0.971 -0.97 -0.969 -0.967 ...

## &nbsp;$ V59 : num &nbsp;-0.976 -0.979 -0.982 -0.982 -0.984 ...

## &nbsp;$ V60 : num &nbsp;-0.984 -0.999 -1 -0.996 -0.998 ...

## &nbsp;$ V61 : num &nbsp;-0.989 -0.99 -0.992 -0.981 -0.991 ...

## &nbsp;$ V62 : num &nbsp;-0.918 -0.942 -0.993 -0.98 -0.98 ...

## &nbsp;$ V63 : num &nbsp;-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ...

## &nbsp;$ V64 : num &nbsp;-1 -1 -1 -1 -1 -1 -1 -1 -1 -1 ...

## &nbsp;$ V65 : num &nbsp;0.114 -0.21 -0.927 -0.596 -0.617 ...

## &nbsp;$ V66 : num &nbsp;-0.59042 -0.41006 0.00223 -0.06493 -0.25727 ...

## &nbsp;$ V67 : num &nbsp;0.5911 0.4139 0.0275 0.0754 0.2689 ...

## &nbsp;$ V68 : num &nbsp;-0.5918 -0.4176 -0.0567 -0.0858 -0.2807 ...

## &nbsp;$ V69 : num &nbsp;0.5925 0.4213 0.0855 0.0962 0.2926 ...

## &nbsp;$ V70 : num &nbsp;-0.745 -0.196 -0.329 -0.295 -0.167 ...

## &nbsp;$ V71 : num &nbsp;0.7209 0.1253 0.2705 0.2283 0.0899 ...

## &nbsp;$ V72 : num &nbsp;-0.7124 -0.1056 -0.2545 -0.2063 -0.0663 ...

## &nbsp;$ V73 : num &nbsp;0.7113 0.1091 0.2576 0.2048 0.0671 ...

## &nbsp;$ V74 : num &nbsp;-0.995 -0.834 -0.705 -0.385 -0.237 ...

## &nbsp;$ V75 : num &nbsp;0.996 0.834 0.714 0.386 0.239 ...

## &nbsp;$ V76 : num &nbsp;-0.996 -0.834 -0.723 -0.387 -0.241 ...

## &nbsp;$ V77 : num &nbsp;0.992 0.83 0.729 0.385 0.241 ...

## &nbsp;$ V78 : num &nbsp;0.57 -0.831 -0.181 -0.991 -0.408 ...

## &nbsp;$ V79 : num &nbsp;0.439 -0.866 0.338 -0.969 -0.185 ...

## &nbsp;$ V80 : num &nbsp;0.987 0.974 0.643 0.984 0.965 ...

## &nbsp;$ V81 : num &nbsp;0.078 0.074 0.0736 0.0773 0.0734 ...

## &nbsp;$ V82 : num &nbsp;0.005 0.00577 0.0031 0.02006 0.01912 ...

## &nbsp;$ V83 : num &nbsp;-0.06783 0.02938 -0.00905 -0.00986 0.01678 ...

## &nbsp;$ V84 : num &nbsp;-0.994 -0.996 -0.991 -0.993 -0.996 ...

## &nbsp;$ V85 : num &nbsp;-0.988 -0.981 -0.981 -0.988 -0.988 ...

## &nbsp;$ V86 : num &nbsp;-0.994 -0.992 -0.99 -0.993 -0.992 ...

## &nbsp;$ V87 : num &nbsp;-0.994 -0.996 -0.991 -0.994 -0.997 ...

## &nbsp;$ V88 : num &nbsp;-0.986 -0.979 -0.979 -0.986 -0.987 ...

## &nbsp;$ V89 : num &nbsp;-0.993 -0.991 -0.987 -0.991 -0.991 ...

## &nbsp;$ V90 : num &nbsp;-0.985 -0.995 -0.987 -0.987 -0.997 ...

## &nbsp;$ V91 : num &nbsp;-0.992 -0.979 -0.979 -0.992 -0.992 ...

## &nbsp;$ V92 : num &nbsp;-0.993 -0.992 -0.992 -0.99 -0.99 ...

## &nbsp;$ V93 : num &nbsp;0.99 0.993 0.988 0.988 0.994 ...

## &nbsp;$ V94 : num &nbsp;0.992 0.992 0.992 0.993 0.993 ...

## &nbsp;$ V95 : num &nbsp;0.991 0.989 0.989 0.993 0.986 ...

## &nbsp;$ V96 : num &nbsp;-0.994 -0.991 -0.988 -0.993 -0.994 ...

## &nbsp;$ V97 : num &nbsp;-1 -1 -1 -1 -1 ...

## &nbsp;$ V98 : num &nbsp;-1 -1 -1 -1 -1 ...

## &nbsp;$ V99 : num &nbsp;-1 -1 -1 -1 -1 ...

## &nbsp; [list output truncated]

&nbsp;

**##### We are implementing the spec (1) Merges the training and the test sets to create one data set.**

**##### Merge the rows from Train and Test files for Subject , activity and features to produce unified data frame**

&nbsp;

&nbsp; dataSubject <- rbind(dataSubjectTrain, dataSubjectTest)

&nbsp; dataActivity <- rbind(dataActivityTrain, dataActivityTest)

&nbsp; dataFeatures <- rbind(dataFeaturesTrain, dataFeaturesTest)

&nbsp;

**##### Name the fields &nbsp;of subject and activity**

&nbsp; names(dataSubject)<-c("subject")

&nbsp; names(dataActivity)<- c("activity")

**##### &nbsp;Read the features.txt file and extract the field containing the names .**

&nbsp;

&nbsp; dataFeaturesNames <- read.table (file.path(filepath\_full, "features.txt"), head=FALSE )

&nbsp; names(dataFeatures) <- dataFeaturesNames$V2

&nbsp;

**##### Do a columnar merge of subject, activity and features to create a single data frame.**

&nbsp;

&nbsp; dataCombine <- cbind(dataSubject, dataActivity)

&nbsp; Data <- cbind(dataFeatures, dataCombine)

&nbsp;

**##### We are implementing (2) Extracts only the measurements on the mean and standard deviation for each measurement.**

&nbsp;

**##### We will use grep command to extract out selected columns. These columns represent variables that have mean and std in their names . we will subset (using SelectedColumns) the merged data and extract out ##### required &nbsp;data .**

&nbsp;

&nbsp; grep\_std\_string <- "mean\\(\\)|std\\(\\)"

&nbsp; Needed\_features <- dataFeaturesNames[,2][grep(grep\_std\_string, dataFeaturesNames[,2])]

&nbsp; SelectedColumns <- c(as.character(Needed\_features), "subject" , "activity")

&nbsp; Data<-subset(Data,select=SelectedColumns) &nbsp;? This piece of code acieves subsetting

1. Check the structures of the data frame&nbsp;Data&nbsp;

str(Data)

## 'data.frame': &nbsp; &nbsp;10299 obs. of &nbsp;68 variables:

## &nbsp;$ tBodyAcc-mean()-X &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: num &nbsp;0.289 0.278 0.28 0.279 0.277 ...

## &nbsp;$ tBodyAcc-mean()-Y &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: num &nbsp;-0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...

## &nbsp;$ tBodyAcc-mean()-Z &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: num &nbsp;-0.133 -0.124 -0.113 -0.123 -0.115 ...

## &nbsp;$ tBodyAcc-std()-X &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : num &nbsp;-0.995 -0.998 -0.995 -0.996 -0.998 ...

## &nbsp;$ tBodyAcc-std()-Y &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : num &nbsp;-0.983 -0.975 -0.967 -0.983 -0.981 ...

## &nbsp;$ tBodyAcc-std()-Z &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : num &nbsp;-0.914 -0.96 -0.979 -0.991 -0.99 ...

## &nbsp;$ tGravityAcc-mean()-X &nbsp; &nbsp; &nbsp; : num &nbsp;0.963 0.967 0.967 0.968 0.968 ...

## &nbsp;$ tGravityAcc-mean()-Y &nbsp; &nbsp; &nbsp; : num &nbsp;-0.141 -0.142 -0.142 -0.144 -0.149 ...

## &nbsp;$ tGravityAcc-mean()-Z &nbsp; &nbsp; &nbsp; : num &nbsp;0.1154 0.1094 0.1019 0.0999 0.0945 ...

## &nbsp;$ tGravityAcc-std()-X &nbsp; &nbsp; &nbsp; &nbsp;: num &nbsp;-0.985 -0.997 -1 -0.997 -0.998 ...

## &nbsp;$ tGravityAcc-std()-Y &nbsp; &nbsp; &nbsp; &nbsp;: num &nbsp;-0.982 -0.989 -0.993 -0.981 -0.988 ...

## &nbsp;$ tGravityAcc-std()-Z &nbsp; &nbsp; &nbsp; &nbsp;: num &nbsp;-0.878 -0.932 -0.993 -0.978 -0.979 ...

## &nbsp;$ tBodyAccJerk-mean()-X &nbsp; &nbsp; &nbsp;: num &nbsp;0.078 0.074 0.0736 0.0773 0.0734 ...

## &nbsp;$ tBodyAccJerk-mean()-Y &nbsp; &nbsp; &nbsp;: num &nbsp;0.005 0.00577 0.0031 0.02006 0.01912 ...

## &nbsp;$ tBodyAccJerk-mean()-Z &nbsp; &nbsp; &nbsp;: num &nbsp;-0.06783 0.02938 -0.00905 -0.00986 0.01678 ...

## &nbsp;$ tBodyAccJerk-std()-X &nbsp; &nbsp; &nbsp; : num &nbsp;-0.994 -0.996 -0.991 -0.993 -0.996 ...

## &nbsp;$ tBodyAccJerk-std()-Y &nbsp; &nbsp; &nbsp; : num &nbsp;-0.988 -0.981 -0.981 -0.988 -0.988 ...

## &nbsp;$ tBodyAccJerk-std()-Z &nbsp; &nbsp; &nbsp; : num &nbsp;-0.994 -0.992 -0.99 -0.993 -0.992 ...

## &nbsp;$ tBodyGyro-mean()-X &nbsp; &nbsp; &nbsp; &nbsp; : num &nbsp;-0.0061 -0.0161 -0.0317 -0.0434 -0.034 ...

## &nbsp;$ tBodyGyro-mean()-Y &nbsp; &nbsp; &nbsp; &nbsp; : num &nbsp;-0.0314 -0.0839 -0.1023 -0.0914 -0.0747 ...

## &nbsp;$ tBodyGyro-mean()-Z &nbsp; &nbsp; &nbsp; &nbsp; : num &nbsp;0.1077 0.1006 0.0961 0.0855 0.0774 ...

## &nbsp;$ tBodyGyro-std()-X &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: num &nbsp;-0.985 -0.983 -0.976 -0.991 -0.985 ...

## &nbsp;$ tBodyGyro-std()-Y &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: num &nbsp;-0.977 -0.989 -0.994 -0.992 -0.992 ...

## &nbsp;$ tBodyGyro-std()-Z &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: num &nbsp;-0.992 -0.989 -0.986 -0.988 -0.987 ...

## &nbsp;$ tBodyGyroJerk-mean()-X &nbsp; &nbsp; : num &nbsp;-0.0992 -0.1105 -0.1085 -0.0912 -0.0908 ...

## &nbsp;$ tBodyGyroJerk-mean()-Y &nbsp; &nbsp; : num &nbsp;-0.0555 -0.0448 -0.0424 -0.0363 -0.0376 ...

## &nbsp;$ tBodyGyroJerk-mean()-Z &nbsp; &nbsp; : num &nbsp;-0.062 -0.0592 -0.0558 -0.0605 -0.0583 ...

## &nbsp;$ tBodyGyroJerk-std()-X &nbsp; &nbsp; &nbsp;: num &nbsp;-0.992 -0.99 -0.988 -0.991 -0.991 ...

## &nbsp;$ tBodyGyroJerk-std()-Y &nbsp; &nbsp; &nbsp;: num &nbsp;-0.993 -0.997 -0.996 -0.997 -0.996 ...

## &nbsp;$ tBodyGyroJerk-std()-Z &nbsp; &nbsp; &nbsp;: num &nbsp;-0.992 -0.994 -0.992 -0.993 -0.995 ...

## &nbsp;$ tBodyAccMag-mean() &nbsp; &nbsp; &nbsp; &nbsp; : num &nbsp;-0.959 -0.979 -0.984 -0.987 -0.993 ...

## &nbsp;$ tBodyAccMag-std() &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: num &nbsp;-0.951 -0.976 -0.988 -0.986 -0.991 ...

## &nbsp;$ tGravityAccMag-mean() &nbsp; &nbsp; &nbsp;: num &nbsp;-0.959 -0.979 -0.984 -0.987 -0.993 ...

## &nbsp;$ tGravityAccMag-std() &nbsp; &nbsp; &nbsp; : num &nbsp;-0.951 -0.976 -0.988 -0.986 -0.991 ...

## &nbsp;$ tBodyAccJerkMag-mean() &nbsp; &nbsp; : num &nbsp;-0.993 -0.991 -0.989 -0.993 -0.993 ...

## &nbsp;$ tBodyAccJerkMag-std() &nbsp; &nbsp; &nbsp;: num &nbsp;-0.994 -0.992 -0.99 -0.993 -0.996 ...

## &nbsp;$ tBodyGyroMag-mean() &nbsp; &nbsp; &nbsp; &nbsp;: num &nbsp;-0.969 -0.981 -0.976 -0.982 -0.985 ...

## &nbsp;$ tBodyGyroMag-std() &nbsp; &nbsp; &nbsp; &nbsp; : num &nbsp;-0.964 -0.984 -0.986 -0.987 -0.989 ...

## &nbsp;$ tBodyGyroJerkMag-mean() &nbsp; &nbsp;: num &nbsp;-0.994 -0.995 -0.993 -0.996 -0.996 ...

## &nbsp;$ tBodyGyroJerkMag-std() &nbsp; &nbsp; : num &nbsp;-0.991 -0.996 -0.995 -0.995 -0.995 ...

## &nbsp;$ fBodyAcc-mean()-X &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: num &nbsp;-0.995 -0.997 -0.994 -0.995 -0.997 ...

## &nbsp;$ fBodyAcc-mean()-Y &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: num &nbsp;-0.983 -0.977 -0.973 -0.984 -0.982 ...

## &nbsp;$ fBodyAcc-mean()-Z &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: num &nbsp;-0.939 -0.974 -0.983 -0.991 -0.988 ...

## &nbsp;$ fBodyAcc-std()-X &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : num &nbsp;-0.995 -0.999 -0.996 -0.996 -0.999 ...

## &nbsp;$ fBodyAcc-std()-Y &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : num &nbsp;-0.983 -0.975 -0.966 -0.983 -0.98 ...

## &nbsp;$ fBodyAcc-std()-Z &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : num &nbsp;-0.906 -0.955 -0.977 -0.99 -0.992 ...

## &nbsp;$ fBodyAccJerk-mean()-X &nbsp; &nbsp; &nbsp;: num &nbsp;-0.992 -0.995 -0.991 -0.994 -0.996 ...

## &nbsp;$ fBodyAccJerk-mean()-Y &nbsp; &nbsp; &nbsp;: num &nbsp;-0.987 -0.981 -0.982 -0.989 -0.989 ...

## &nbsp;$ fBodyAccJerk-mean()-Z &nbsp; &nbsp; &nbsp;: num &nbsp;-0.99 -0.99 -0.988 -0.991 -0.991 ...

## &nbsp;$ fBodyAccJerk-std()-X &nbsp; &nbsp; &nbsp; : num &nbsp;-0.996 -0.997 -0.991 -0.991 -0.997 ...

## &nbsp;$ fBodyAccJerk-std()-Y &nbsp; &nbsp; &nbsp; : num &nbsp;-0.991 -0.982 -0.981 -0.987 -0.989 ...

## &nbsp;$ fBodyAccJerk-std()-Z &nbsp; &nbsp; &nbsp; : num &nbsp;-0.997 -0.993 -0.99 -0.994 -0.993 ...

## &nbsp;$ fBodyGyro-mean()-X &nbsp; &nbsp; &nbsp; &nbsp; : num &nbsp;-0.987 -0.977 -0.975 -0.987 -0.982 ...

## &nbsp;$ fBodyGyro-mean()-Y &nbsp; &nbsp; &nbsp; &nbsp; : num &nbsp;-0.982 -0.993 -0.994 -0.994 -0.993 ...

## &nbsp;$ fBodyGyro-mean()-Z &nbsp; &nbsp; &nbsp; &nbsp; : num &nbsp;-0.99 -0.99 -0.987 -0.987 -0.989 ...

## &nbsp;$ fBodyGyro-std()-X &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: num &nbsp;-0.985 -0.985 -0.977 -0.993 -0.986 ...

## &nbsp;$ fBodyGyro-std()-Y &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: num &nbsp;-0.974 -0.987 -0.993 -0.992 -0.992 ...

## &nbsp;$ fBodyGyro-std()-Z &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: num &nbsp;-0.994 -0.99 -0.987 -0.989 -0.988 ...

## &nbsp;$ fBodyAccMag-mean() &nbsp; &nbsp; &nbsp; &nbsp; : num &nbsp;-0.952 -0.981 -0.988 -0.988 -0.994 ...

## &nbsp;$ fBodyAccMag-std() &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: num &nbsp;-0.956 -0.976 -0.989 -0.987 -0.99 ...

## &nbsp;$ fBodyBodyAccJerkMag-mean() : num &nbsp;-0.994 -0.99 -0.989 -0.993 -0.996 ...

## &nbsp;$ fBodyBodyAccJerkMag-std() &nbsp;: num &nbsp;-0.994 -0.992 -0.991 -0.992 -0.994 ...

## &nbsp;$ fBodyBodyGyroMag-mean() &nbsp; &nbsp;: num &nbsp;-0.98 -0.988 -0.989 -0.989 -0.991 ...

## &nbsp;$ fBodyBodyGyroMag-std() &nbsp; &nbsp; : num &nbsp;-0.961 -0.983 -0.986 -0.988 -0.989 ...

## &nbsp;$ fBodyBodyGyroJerkMag-mean(): num &nbsp;-0.992 -0.996 -0.995 -0.995 -0.995 ...

## &nbsp;$ fBodyBodyGyroJerkMag-std() : num &nbsp;-0.991 -0.996 -0.995 -0.995 -0.995 ...

## &nbsp;$ subject &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;: int &nbsp;1 1 1 1 1 1 1 1 1 1 ...

## &nbsp;$ activity &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : int &nbsp;5 5 5 5 5 5 5 5 5 5 ...

# Appropriately labels the data set with descriptive

**#### (3) & (4) We are implementing Uses descriptive activity names to name the activities in the data set**

**##### Name the column of Data frame with meaningful names . we will use gsub function to do a global substitute of source strings to column strings as part of names.**

**##### gsub()**** &nbsp; ****function replaces all matches of a string, if the parameter is a string vector, returns a string vector of the same length and with the same attributes (after possible coercion to character). Elements of string ##### vectors which are not substituted will be returned unchanged (including any declared encoding).**** &nbsp;**

**##### tBody will be converted to Time\_Body**

**##### FBody will be converted to Frequency\_Body**

**##### tGravity will be converted to Time\_Gravity**

**##### Acc will be converted to Accelerometer**

**##### Gyo will be converted to Gyroscope**

**##### Mag will be converted to Magnitude**

**##### BodyBOdy will be Converted to Body**

names(Data)<-gsub("tBody", "Time\_Body", names(Data))

names(Data)<-gsub("fBody", "Frequency\_Body", names(Data))

names(Data)<-gsub("tGravity", "Time\_Gravity", names(Data))

names(Data)<-gsub("Acc", "Accelerometer", names(Data))

names(Data)<-gsub("Gyro", "Gyroscope", names(Data))

names(Data)<-gsub("Mag", "Magnitude", names(Data))

names(Data)<-gsub("BodyBody", "Body", names(Data))

names(Data)

&nbsp;[1] "Time\_BodyAccelerometer-mean()-X" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "Time\_BodyAccelerometer-mean()-Y" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

&nbsp;[3] "Time\_BodyAccelerometer-mean()-Z" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "Time\_BodyAccelerometer-std()-X" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

&nbsp;[5] "Time\_BodyAccelerometer-std()-Y" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"Time\_BodyAccelerometer-std()-Z" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

&nbsp;[7] "Time\_GravityAccelerometer-mean()-X" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"Time\_GravityAccelerometer-mean()-Y" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

&nbsp;[9] "Time\_GravityAccelerometer-mean()-Z" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"Time\_GravityAccelerometer-std()-X" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[11] "Time\_GravityAccelerometer-std()-Y" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "Time\_GravityAccelerometer-std()-Z" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[13] "Time\_BodyAccelerometerJerk-mean()-X" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "Time\_BodyAccelerometerJerk-mean()-Y" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[15] "Time\_BodyAccelerometerJerk-mean()-Z" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "Time\_BodyAccelerometerJerk-std()-X" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[17] "Time\_BodyAccelerometerJerk-std()-Y" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"Time\_BodyAccelerometerJerk-std()-Z" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[19] "Time\_BodyGyroscope-mean()-X" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "Time\_BodyGyroscope-mean()-Y" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[21] "Time\_BodyGyroscope-mean()-Z" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "Time\_BodyGyroscope-std()-X" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[23] "Time\_BodyGyroscope-std()-Y" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"Time\_BodyGyroscope-std()-Z" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[25] "Time\_BodyGyroscopeJerk-mean()-X" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "Time\_BodyGyroscopeJerk-mean()-Y" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[27] "Time\_BodyGyroscopeJerk-mean()-Z" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "Time\_BodyGyroscopeJerk-std()-X" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[29] "Time\_BodyGyroscopeJerk-std()-Y" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"Time\_BodyGyroscopeJerk-std()-Z" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[31] "Time\_BodyAccelerometerMagnitude-mean()" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"Time\_BodyAccelerometerMagnitude-std()" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[33] "Time\_GravityAccelerometerMagnitude-mean()" &nbsp; &nbsp; &nbsp; "Time\_GravityAccelerometerMagnitude-std()" &nbsp; &nbsp; &nbsp;

[35] "Time\_BodyAccelerometerJerkMagnitude-mean()" &nbsp; &nbsp; &nbsp;"Time\_BodyAccelerometerJerkMagnitude-std()" &nbsp; &nbsp; &nbsp;

[37] "Time\_BodyGyroscopeMagnitude-mean()" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"Time\_BodyGyroscopeMagnitude-std()" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[39] "Time\_BodyGyroscopeJerkMagnitude-mean()" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"Time\_BodyGyroscopeJerkMagnitude-std()" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[41] "Frequency\_BodyAccelerometer-mean()-X" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"Frequency\_BodyAccelerometer-mean()-Y" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[43] "Frequency\_BodyAccelerometer-mean()-Z" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"Frequency\_BodyAccelerometer-std()-X" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[45] "Frequency\_BodyAccelerometer-std()-Y" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "Frequency\_BodyAccelerometer-std()-Z" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[47] "Frequency\_BodyAccelerometerJerk-mean()-X" &nbsp; &nbsp; &nbsp; &nbsp;"Frequency\_BodyAccelerometerJerk-mean()-Y" &nbsp; &nbsp; &nbsp;

[49] "Frequency\_BodyAccelerometerJerk-mean()-Z" &nbsp; &nbsp; &nbsp; &nbsp;"Frequency\_BodyAccelerometerJerk-std()-X" &nbsp; &nbsp; &nbsp; &nbsp;

[51] "Frequency\_BodyAccelerometerJerk-std()-Y" &nbsp; &nbsp; &nbsp; &nbsp; "Frequency\_BodyAccelerometerJerk-std()-Z" &nbsp; &nbsp; &nbsp; &nbsp;

[53] "Frequency\_BodyGyroscope-mean()-X" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"Frequency\_BodyGyroscope-mean()-Y" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[55] "Frequency\_BodyGyroscope-mean()-Z" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"Frequency\_BodyGyroscope-std()-X" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[57] "Frequency\_BodyGyroscope-std()-Y" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "Frequency\_BodyGyroscope-std()-Z" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

[59] "Frequency\_BodyAccelerometerMagnitude-mean()" &nbsp; &nbsp; "Frequency\_BodyAccelerometerMagnitude-std()" &nbsp; &nbsp;

[61] "Frequency\_BodyAccelerometerJerkMagnitude-mean()" "Frequency\_BodyAccelerometerJerkMagnitude-std()"

[63] "Frequency\_BodyGyroscopeMagnitude-mean()" &nbsp; &nbsp; &nbsp; &nbsp; "Frequency\_BodyGyroscopeMagnitude-std()" &nbsp; &nbsp; &nbsp; &nbsp;

[65] "Frequency\_BodyGyroscopeJerkMagnitude-mean()" &nbsp; &nbsp; "Frequency\_BodyGyroscopeJerkMagnitude-std()" &nbsp; &nbsp;

[67] "subject" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; "activity" &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;

Warning message:

**##### We are implementing (5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.**

**#####**** Group the data, Create summary, write out the Summary.**

**##### We will be making use of group\_by , summarize\_each dply utility commands to achieve this.**

Data\_group <- group\_by(Data, subject, activity)

Data\_group\_summary <- summarise\_each(Data\_group, funs(mean))

Data\_group\_summary

Source: local data frame [180 x 68]

Groups: subject

&nbsp; &nbsp;subject activity Time\_BodyAccelerometer-mean()-X Time\_BodyAccelerometer-mean()-Y Time\_BodyAccelerometer-mean()-Z

1 &nbsp; &nbsp; &nbsp; &nbsp;1 &nbsp; &nbsp; &nbsp; &nbsp;1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0.2773308 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.017383819 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.1111481

2 &nbsp; &nbsp; &nbsp; &nbsp;1 &nbsp; &nbsp; &nbsp; &nbsp;2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0.2554617 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.023953149 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.0973020

3 &nbsp; &nbsp; &nbsp; &nbsp;1 &nbsp; &nbsp; &nbsp; &nbsp;3 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0.2891883 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.009918505 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.1075662

4 &nbsp; &nbsp; &nbsp; &nbsp;1 &nbsp; &nbsp; &nbsp; &nbsp;4 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0.2612376 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.001308288 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.1045442

5 &nbsp; &nbsp; &nbsp; &nbsp;1 &nbsp; &nbsp; &nbsp; &nbsp;5 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0.2789176 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.016137590 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.1106018

6 &nbsp; &nbsp; &nbsp; &nbsp;1 &nbsp; &nbsp; &nbsp; &nbsp;6 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0.2215982 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.040513953 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.1132036

7 &nbsp; &nbsp; &nbsp; &nbsp;2 &nbsp; &nbsp; &nbsp; &nbsp;1 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0.2764266 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.018594920 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.1055004

8 &nbsp; &nbsp; &nbsp; &nbsp;2 &nbsp; &nbsp; &nbsp; &nbsp;2 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0.2471648 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.021412113 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.1525139

9 &nbsp; &nbsp; &nbsp; &nbsp;2 &nbsp; &nbsp; &nbsp; &nbsp;3 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0.2776153 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.022661416 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.1168129

10 &nbsp; &nbsp; &nbsp; 2 &nbsp; &nbsp; &nbsp; &nbsp;4 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 0.2770874 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.015687994 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;-0.1092183

.. &nbsp; &nbsp; ... &nbsp; &nbsp; &nbsp;... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ... &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ...

Variables not shown: Time\_BodyAccelerometer-std()-X (dbl), Time\_BodyAccelerometer-std()-Y (dbl),

&nbsp; Time\_BodyAccelerometer-std()-Z (dbl), Time\_GravityAccelerometer-mean()-X (dbl), Time\_GravityAccelerometer-mean()-Y (dbl),

&nbsp; Time\_GravityAccelerometer-mean()-Z (dbl), Time\_GravityAccelerometer-std()-X (dbl), Time\_GravityAccelerometer-std()-Y

&nbsp; (dbl), Time\_GravityAccelerometer-std()-Z (dbl), Time\_BodyAccelerometerJerk-mean()-X (dbl),

&nbsp; Time\_BodyAccelerometerJerk-mean()-Y (dbl), Time\_BodyAccelerometerJerk-mean()-Z (dbl), Time\_BodyAccelerometerJerk-std()-X

&nbsp; (dbl), Time\_BodyAccelerometerJerk-std()-Y (dbl), Time\_BodyAccelerometerJerk-std()-Z (dbl), Time\_BodyGyroscope-mean()-X

&nbsp; (dbl), Time\_BodyGyroscope-mean()-Y (dbl), Time\_BodyGyroscope-mean()-Z (dbl), Time\_BodyGyroscope-std()-X (dbl),

&nbsp; Time\_BodyGyroscope-std()-Y (dbl), Time\_BodyGyroscope-std()-Z (dbl), Time\_BodyGyroscopeJerk-mean()-X (dbl),

&nbsp; Time\_BodyGyroscopeJerk-mean()-Y (dbl), Time\_BodyGyroscopeJerk-mean()-Z (dbl), Time\_BodyGyroscopeJerk-std()-X (dbl),

&nbsp; Time\_BodyGyroscopeJerk-std()-Y (dbl), Time\_BodyGyroscopeJerk-std()-Z (dbl), Time\_BodyAccelerometerMagnitude-mean() (dbl),

&nbsp; Time\_BodyAccelerometerMagnitude-std() (dbl), Time\_GravityAccelerometerMagnitude-mean() (dbl),

&nbsp; Time\_GravityAccelerometerMagnitude-std() (dbl), Time\_BodyAccelerometerJerkMagnitude-mean() (dbl),

&nbsp; Time\_BodyAccelerometerJerkMagnitude-std() (dbl), Time\_BodyGyroscopeMagnitude-mean() (dbl),

&nbsp; Time\_BodyGyroscopeMagnitude-std() (dbl), Time\_BodyGyroscopeJerkMagnitude-mean() (dbl),

&nbsp; Time\_BodyGyroscopeJerkMagnitude-std() (dbl), Frequency\_BodyAccelerometer-mean()-X (dbl),

&nbsp; Frequency\_BodyAccelerometer-mean()-Y (dbl), Frequency\_BodyAccelerometer-mean()-Z (dbl),

&nbsp; Frequency\_BodyAccelerometer-std()-X (dbl), Frequency\_BodyAccelerometer-std()-Y (dbl), Frequency\_BodyAccelerometer-std()-Z

&nbsp; (dbl), Frequency\_BodyAccelerometerJerk-mean()-X (dbl), Frequency\_BodyAccelerometerJerk-mean()-Y (dbl),

&nbsp; Frequency\_BodyAccelerometerJerk-mean()-Z (dbl), Frequency\_BodyAccelerometerJerk-std()-X (dbl),

&nbsp; Frequency\_BodyAccelerometerJerk-std()-Y (dbl), Frequency\_BodyAccelerometerJerk-std()-Z (dbl),

&nbsp; Frequency\_BodyGyroscope-mean()-X (dbl), Frequency\_BodyGyroscope-mean()-Y (dbl), Frequency\_BodyGyroscope-mean()-Z (dbl),

&nbsp; Frequency\_BodyGyroscope-std()-X (dbl), Frequency\_BodyGyroscope-std()-Y (dbl), Frequency\_BodyGyroscope-std()-Z (dbl),

&nbsp; Frequency\_BodyAccelerometerMagnitude-mean() (dbl), Frequency\_BodyAccelerometerMagnitude-std() (dbl),

&nbsp; Frequency\_BodyAccelerometerJerkMagnitude-mean() (dbl), Frequency\_BodyAccelerometerJerkMagnitude-std() (dbl),

&nbsp; Frequency\_BodyGyroscopeMagnitude-mean() (dbl), Frequency\_BodyGyroscopeMagnitude-std() (dbl),

&nbsp; Frequency\_BodyGyroscopeJerkMagnitude-mean() (dbl), Frequency\_BodyGyroscopeJerkMagnitude-std() (dbl)

&nbsp;

write.table(Data\_group\_summary, file = "tidydata.txt",row.name=FALSE)

# **#### END OF PROGRAM**

# **}**

# The following test run proves that tidydata.txt was created and uploaded using above piece of R code.

# The output file tidydata.txt has been uploaded to github

# setwd("C:/Coursera/Getting\_cleaning\_data\_Course\_project")

# > getwd()

# [1] "C:/Coursera/Getting\_cleaning\_data\_Course\_project"

# working\_dir <- getwd()

# working\_dir

# [1] "C:/Coursera/Getting\_cleaning\_data\_Course\_project"

# source("C:/Coursera/Getting\_cleaning\_data\_Course\_project/run\_analysis.R")

# run\_analysis(working\_dir)

# trying URL 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

# Content type 'application/zip' length 62556944 bytes (59.7 Mb)

# opened URL

# downloaded 59.7 Mb

&nbsp;

&nbsp;