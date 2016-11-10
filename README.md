# Human Activity Recognition Using Smartphones Data Set #


----------


## Introduction ##

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

A full description is available at the site where the data was obtained:

[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

Here are the data for the project:

[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


## Project Summary ##
The purpose of this project is to aggregate the results of the experiment in a way that makes the data useful for analysis. the following are the main components that structured the data:

Subjects: 30 People conducted the experiment
Activities: 6 main activities explained below
Features: 561 observations per person per activity
Features Data: Total of 10299 observations split into 7352 training data and 2947 test data.  

## Project Dictionary ##

### Subjects ###
  
- This represents the people who participated in the experiments. 
- There were 30 people performing 6 tests
- There are 30 people contributed to an actual training and delivered 7352 different training observations
- There are 24 people contributed to 2947 test observations
- The total no of people remains 30
- Each person ID is a single unique digit that between 1-30
- *subject_train.txt* (7352 training observations) and *subject_test.txt* (2947 test observations) files list the people ID who conducted which observations 

 

### Activities ###

The total subjects (30 people mentioned above), experimented 6 activities as following:

- WALKING
- WALKING_UPSTAIRS
- WALKING_DOWNSTAIRS
- SITTING
- STANDING
- LAYING


y_train.txt (7352 training observations) and y_test.txt (2947 test observations) list which activity was conducted for that specific observation activity_labels.txt has the six activity types


### Features ###

Different people conducted different activities, however for each person and activity, the experiment was collecting a complete 561 observations. These observations were conducted on the subjects (people) and activities mentioned above
*features.txt* file has an index of the 561 variables that have been collected for the 10299 observations


### Project Deliverable ###


- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


