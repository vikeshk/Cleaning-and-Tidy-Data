# Cleaning-and-Tidy-Data
Cleaning data and produce the tidy output for Health Data

run_analysis.R performs the following:

1) Merges the training and the test sets to create one data set.
2) Extracts only the measurements on the mean and standard deviation for each measurement.
3) Uses descriptive activity names to name the activities in the data set
4) Appropriately labels the data set with descriptive activity names.
5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
run_analysis.R

How it Works :
1) It downloads the UCI HAR Dataset data set and puts the zip file working directrory. After it is downloaded, it unzips the file into the UCI HAR Dataset folder.
2) It loads the train and test data sets and appends the two datasets into one data frame. This is done using rbind.
3) It extracts just the mean and standard deviation from the features data set. This is done using grep.
4) After cleaning the column names, these are applied to the x data frame.
5) After loading activities data set, it converts it to lower case using tolower and removes underscore using gsub. activity and subject column names are named for YFile and subj data sets, respectively.
6) The three data sets, XFile, YFile and subj, are merged. Then, it is exported as a txt file into the Project folder in the same working directory, named merged.txt.
7) The mean of activities and subjects are created into a separate tidy data set which is exported into the Project folder as txt file; this is named average.txt.

