library(data.table)
library(dplyr)
library(plyr)
library(tidyr)
##Please download the zipped file from the URL https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
##Create a directory c:\week4 and unzip the file inside it
##You should have C:\week4\UCI HAR Dataset directory structure
##The following commands are not reliable enough to donwload 
##dir.create("c:/week4/", showWarnings = TRUE, recursive = FALSE, mode = "0777")
##download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "./assignment.zip", method = "auto")
##unzip("c:/week4/assignment.zip", exdir = )
setwd("C:/week4/UCI HAR Dataset")
activity_label <- tbl_df(read.table("./activity_labels.txt"))
feature_label <- tbl_df(read.table("./features.txt"))
feature_label[1] <- list(NULL)
feature_label <- t(feature_label)
x_train <- tbl_df(read.table("./train/X_train.txt"))
y_train <- tbl_df(read.table("./train/y_train.txt"))
subject_train <- tbl_df(read.table("./train/subject_train.txt"))
x_test <- tbl_df(read.table("./test/X_test.txt"))
y_test <- tbl_df(read.table("./test/y_test.txt"))
subject_test <- tbl_df(read.table("./test/subject_test.txt"))
##View(activity_label)
##View(feature_label)
##View(x_train)
##View(y_train)
##View(subject_train)
##View(x_test)
##View(y_test)
##View(subject_test)
feature_result <- rbind(x_train, x_test)
subject_activity <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
##View(feature_result)
##View(subject_activity)
##View(subject)
all_data <- cbind(subject, subject_activity, feature_result)
names(all_data) <- c("subject", "activity_no", head(feature_label))
names(activity_label) <- c("activity_no", "activity_label")
all_data_label <- names(all_data)
View(all_data)
all_data_selected_label <- all_data_label[grep("subject|activity_no|mean\\(\\)|std\\(\\)", all_data_label)]
data_selected <- subset(all_data, select = all_data_selected_label)
data_selected <- merge(activity_label, data_selected, by = "activity_no", all.x = TRUE)
col_idx <- grep("subject", names(data_selected))
##Move subject to be the first column
data_selected <- data_selected[, c(col_idx, (1:ncol(data_selected))[-col_idx])]
##Sort by subject
data_selected <- data_selected[order(data_selected$subject), ]
##Rename the labels to be more descriptive
names(data_selected) <- make.names(names(data_selected))
names(data_selected) <- gsub('Acc',"Acceleration",names(data_selected))
names(data_selected) <- gsub('Mag',"Magnitude",names(data_selected))
names(data_selected) <- gsub('^t',"Time.",names(data_selected))
names(data_selected) <- gsub('^f',"FrequencyDomain.",names(data_selected))
names(data_selected) <- gsub('\\.mean',".Mean",names(data_selected))
names(data_selected) <- gsub('\\.std',".StandardDeviation",names(data_selected))
names(data_selected) <- gsub('Freq\\.',"Frequency.",names(data_selected))
View(data_selected)
##The following command will generate warnings due to NA that it can't average.
tidy_data <- aggregate(data_selected, by = list(data_selected$subject, data_selected$activity_label), FUN = mean, na.rm = TRUE)
## Deleting NA columns - activity_label and subject
tidy_data[3] <- list(NULL)
tidy_data[4] <- list(NULL)
## Renaming first two columns to be subject and activity label in the tidy data
colnames(tidy_data)[1:2] <- c("subject", "activity_label")
View(tidy_data)


