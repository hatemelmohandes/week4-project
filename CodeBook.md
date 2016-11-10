# Data Dictionary - Human Activity Recognition Using Smartphones Data Set #


----------

## Dataset Inputs ##

### I- Subjects: ###

30 People conducted both training and testing sessions

#### Source File ####
 
subject_train.txt

subject_test.txt


Each observation of these two files represents who conducted either the training or the testing. For the training dataset, we will find 7352 Activities and in the testing dataset done by the full group of 30 people, we have 2947 Activities done by only 24 people out of the 30 people volunteered. Total of 10299 activities have been conducted by 30 people during training and testing combined 


### II- Activity Labels: ###
The following are the only six activities that have been conducted during the experiment:

1. WALKING
1. WALKING_UPSTAIRS
1. WALKING_DOWNSTAIRS
1. SITTING
1. STANDING
1. LAYING

#### Source File: ####

activity_labels.txt


III- Activities Conducted:

Each subject (person) completed one activity at a time. During each one activity for that specific subject (person), 561 features (shown below) or you can refer to it as observations that have been collected.


#### Source Files: ####


y_train.txt

y_test.txt





### IV- Features: ###

For each person conducted one activity, the experiment collected 561 observations for each activity that one subject (person) performed.

So each line in the subject files (person) I- Subjects, matches an activity that has been conducted by that person in the III- Activities Conducted and the activity type should be one of the 6 mentioned above in II- Activity Labels


#### Source File: ####

features.txt

### V- Features Observations (Results): ###

For each subject (person) who performed one activity at a time, 561 observations have been collected. 


#### Source Files: ####

X_train.txt


X_test.txt


Total number of observations are 10299 (activities for train and test) X 561 features = 5,777,739


## Project Data Preparation: ##

For the script to work, please complete the following

1. Create a directory called c:\week4
1. Download the file [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
1. Extract the zipped file into c:\week4
2. Set the working directory setwd("C:/week4/UCI HAR Dataset")

The extracted data will contain many files, however we will use only the files mentioned above and the rest should be ignored

The main dataset that we will create will consist of the combination of the above mentioned five categories.
The dataset will consist of the following columns:

- Subject: The person who conducted the experiment
- Activity: The activity that has been conducted by that subject (person)
- Activity Label: A friendly name of the activity instead of just a number from 1-6
- Features: These are the 561 observations which will translate to 561 additional column

The dataset will consist of the following rows:

- Training 7352
- Testing 2947
- Total rows will be 10299

In order to prepare for project deliverable We will create table dataframes as following:


"##Load all required data from text files into tables dataframe

activity_label <- tbl_df(read.table("./activity_labels.txt"))

feature_label <- tbl_df(read.table("./features.txt"))

x_train <- tbl_df(read.table("./train/X_train.txt"))

y_train <- tbl_df(read.table("./train/y_train.txt"))

subject_train <- tbl_df(read.table("./train/subject_train.txt"))

x_test <- tbl_df(read.table("./test/X_test.txt"))

y_test <- tbl_df(read.table("./test/y_test.txt"))

subject_test <- tbl_df(read.table("./test/subject_test.txt"))

"##Remove the first column of feature_label 

feature_label[1] <- list(NULL)

"##Transpose the feature_label dataframe in order to make it consistent with all data

feature_label <- t(feature_label)




****The project deliverable section will explain how we will create the main dataset****

## Project Deliverable: ##

### 1.Merges the training and the test sets to create one data set: ###

"##Four types of files will be merged together, the subjects, the activities, the features and the observations

"##Bind all relevant data together

feature_result <- rbind(x_train, x_test)

subject_activity <- rbind(y_train, y_test)

subject <- rbind(subject_train, subject_test)
 
"##Create a gigantic dataframe with all required columns. Starts with subject, activity number, feature observation


all_data <- cbind(subject, subject_activity, feature_result)


Now we have a huge dataset with all the data we have and no labels for the columns

The following are additional tasks that I have carried on to make things easier later on

"##Add proper column names to the master dataset

names(all_data) <- c("subject", "activity_no", head(feature_label))

"##Add proper column names to the activity label table


names(activity_label) <- c("activity_no", "activity_label")


all_data_label <- names(all_data)

"##View the data to get a sense of what has been accomplished so far

View(all_data)

### 2. Extracts only the measurements on the mean and standard deviation for each measurement. ###


"##Create subset of data to extract only mean and standard deviation from the master dataset


all_data_selected_label <- all_data_label[grep("subject|activity_no|mean\\(\\)|std\\(\\)", all_data_label)]


data_selected <- subset(all_data, select = all_data_selected_label)


### 3. Uses descriptive activity names to name the activities in the data set ###

"##Adding a friendly name to the activity conducted column instead of just a no 1-6

data_selected <- merge(activity_label, data_selected, by = "activity_no", all.x = TRUE)

col_idx <- grep("subject", names(data_selected))

"##Move subject to be the first column

data_selected <- data_selected[, c(col_idx, (1:ncol(data_selected))[-col_idx])]

"##Sort by subject

data_selected <- data_selected[order(data_selected$subject), ]


### 4. Appropriately labels the data set with descriptive variable names. ###


"##Rename the labels to be more descriptive

names(data_selected) <- make.names(names(data_selected))

names(data_selected) <- gsub('Acc',"Acceleration",names(data_selected))

names(data_selected) <- gsub('Mag',"Magnitude",names(data_selected))

names(data_selected) <- gsub('^t',"Time.",names(data_selected))

names(data_selected) <- gsub('^f',"FrequencyDomain.",names(data_selected))

names(data_selected) <- gsub('\\.mean',".Mean",names(data_selected))

names(data_selected) <- gsub('\\.std',".StandardDeviation",names(data_selected))

names(data_selected) <- gsub('Freq\\.',"Frequency.",names(data_selected))

"##The following command will view the data to get a visualized sense of the results

View(data_selected)


### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. ###


"##Create the tidy data from the selected data table. 
"##The tidy data will take the average for each person per activity, so 30 people "##and 6 activities to generate 180 observations
"##The following command will generate warnings due to NA that it can't average.

tidy_data <- aggregate(data_selected, by = list(data_selected$subject, data_selected$activity_label), FUN = mean, na.rm = TRUE)

"##Deleting NA columns - activity_label and subject

tidy_data[3] <- list(NULL)

tidy_data[4] <- list(NULL)


"##Renaming first two columns to be subject and activity label in the tidy data

colnames(tidy_data)[1:2] <- c("subject", "activity_label")

View(tidy_data)

write.csv(tidy_data, "./tidy_data.csv")




