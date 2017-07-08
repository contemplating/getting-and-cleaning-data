#setwd("R-files/R-Course Week 4/Project")

library(dplyr)

#read data
testdatameasure <- read.table("test/x_test.txt")
testdataactivity <- read.csv("test/y_test.txt", header = FALSE)
testdatasubject <- read.csv("test/subject_test.txt", header = FALSE)

traindatameasure <- read.table("train/x_train.txt")
traindataactivity <- read.csv("train/y_train.txt", header = FALSE)
traindatasubject <- read.csv("train/subject_train.txt", header = FALSE)

# merge data sets
measures <- rbind(testdatameasure, traindatameasure) 
activity <- rbind(testdataactivity, traindataactivity) 
subject <- rbind(testdatasubject, traindatasubject) 

names(measures) <- c("measures")
names(activity) <- c("activity")
names(subject) <- c("subject")

colnames <- readLines("features.txt")
#select only mean and std columns 
means <- grep("-mean()", colnames, fixed=T)
stds <- grep("-std()", colnames)

# fix column names
colnames <- sapply(seq_along(colnames), function(x) {gsub("()", "", gsub(paste0(x, " "),"", colnames[x]), fixed = T)})

# label activities
activity$activity <- factor(activity$activity, labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING", "STANDING","LAYING"))

names(measures) <- colnames
measurements <- data.frame(subject, activity, measures[sort(c(means,stds))])

# select only means for summary
mean_measurements <- data.frame(subject, activity, measures[sort(means)])

#group table
activity_subject_grouped <- group_by(mean_measurements, subject, activity)
activity_subject <- summarise_all(activity_subject_grouped, funs(mean))

write.csv(activity_subject, file = "activity_subject.csv", row.names = F )