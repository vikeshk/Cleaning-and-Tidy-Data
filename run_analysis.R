library(data.table)
library(dplyr)

getwd()

setwd("F:/Data Scientist/Cleaning Data/week4/getdata-projectfiles-UCI HAR Dataset")

path <- getwd()

url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
f <- "Dataset.zip"
if (!file.exists(path)) {
  dir.create(path)
}
download.file(url, file.path(path, f))

unzip('./UCI-HAR-dataset.zip')


pathIn <- file.path(path, "UCI HAR Dataset")
list.files(pathIn, recursive = TRUE)

dtSubjectTrain <- fread(file.path(pathIn, "train", "subject_train.txt"))
dtSubjectTest <- fread(file.path(pathIn, "test", "subject_test.txt"))

dtActivityTrain <- fread(file.path(pathIn, "train", "Y_train.txt"))
dtActivityTest <- fread(file.path(pathIn, "test", "Y_test.txt"))


dtTrain <- fread(file.path(pathIn, "train", "X_train.txt"))
dtTest <- fread(file.path(pathIn, "test", "X_test.txt"))

XFile <- rbind(dtTrain, dtTest)

subj <- rbind(dtSubjectTrain, dtSubjectTest)

YFile <- rbind(dtActivityTrain, dtActivityTest)

features <- fread(file.path(pathIn, "features.txt"))
setnames(features, names(features), c("featureNum", "featureName"))
mean.sd <- features[grepl("mean\\(\\)|std\\(\\)", featureName)]
mean.sd$featureCode <- mean.sd[, paste0("V", featureNum)]

x.mean.sd <- XFile[, mean.sd]

activities <-  fread(file.path(pathIn, "activity_labels.txt")) 


y[, 1] = activities[y[, 1], 2]
colnames(YFile) <- 'activity'
colnames(subj) <- 'subject'

# Appropriately labels the data set with descriptive activity names.
data <- cbind(subj, x.mean.sd, YFile)
str(data)
write.table(data, './merged.txt', row.names = F)

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
average.df <- aggregate(x=data, by=list(activities=data$activity, subj=data$subject), FUN=mean)
average.df <- average.df[, !(colnames(average.df) %in% c("subj", "activity"))]
average.df <- select(average.df,1:3)
str(average.df)

