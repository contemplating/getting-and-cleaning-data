#setwd("R-files/R-Course Week 4/Project")

library(dplyr)

testdata_body_acc_x <- matrix(scan("test/Inertial Signals/body_acc_x_test.txt", sep=NULL),ncol=128, byrow = TRUE)
testdata_body_acc_y <- matrix(scan("test/Inertial Signals/body_acc_y_test.txt", sep=NULL),ncol=128, byrow = TRUE)
testdata_body_acc_z <- matrix(scan("test/Inertial Signals/body_acc_z_test.txt", sep=NULL),ncol=128, byrow = TRUE)
testdata_body_gyro_x <- matrix(scan("test/Inertial Signals/body_gyro_x_test.txt", sep=NULL),ncol=128, byrow = TRUE)
testdata_body_gyro_y <- matrix(scan("test/Inertial Signals/body_gyro_y_test.txt", sep=NULL),ncol=128, byrow = TRUE)
testdata_body_gyro_z <- matrix(scan("test/Inertial Signals/body_gyro_z_test.txt", sep=NULL),ncol=128, byrow = TRUE)
testdata_total_acc_x <- matrix(scan("test/Inertial Signals/total_acc_x_test.txt", sep=NULL),ncol=128, byrow = TRUE)
testdata_total_acc_y <- matrix(scan("test/Inertial Signals/total_acc_y_test.txt", sep=NULL),ncol=128, byrow = TRUE)
testdata_total_acc_z <- matrix(scan("test/Inertial Signals/total_acc_z_test.txt", sep=NULL),ncol=128, byrow = TRUE)
testdataactivity <- read.csv("test/y_test.txt", header = FALSE)
testdatasubject <- read.csv("test/subject_test.txt", header = FALSE)

traindata_body_acc_x <- matrix(scan("train/Inertial Signals/body_acc_x_train.txt", sep=NULL),ncol=128, byrow = TRUE)
traindata_body_acc_y <- matrix(scan("train/Inertial Signals/body_acc_y_train.txt", sep=NULL),ncol=128, byrow = TRUE)
traindata_body_acc_z <- matrix(scan("train/Inertial Signals/body_acc_z_train.txt", sep=NULL),ncol=128, byrow = TRUE)
traindata_body_gyro_x <- matrix(scan("train/Inertial Signals/body_gyro_x_train.txt", sep=NULL),ncol=128, byrow = TRUE)
traindata_body_gyro_y <- matrix(scan("train/Inertial Signals/body_gyro_y_train.txt", sep=NULL),ncol=128, byrow = TRUE)
traindata_body_gyro_z <- matrix(scan("train/Inertial Signals/body_gyro_z_train.txt", sep=NULL),ncol=128, byrow = TRUE)
traindata_total_acc_x <- matrix(scan("train/Inertial Signals/total_acc_x_train.txt", sep=NULL),ncol=128, byrow = TRUE)
traindata_total_acc_y <- matrix(scan("train/Inertial Signals/total_acc_y_train.txt", sep=NULL),ncol=128, byrow = TRUE)
traindata_total_acc_z <- matrix(scan("train/Inertial Signals/total_acc_z_train.txt", sep=NULL),ncol=128, byrow = TRUE)
traindataactivity <- read.csv("train/y_train.txt", header = FALSE)
traindatasubject <- read.csv("train/subject_train.txt", header = FALSE)

body_acc_x <- matrix(c(testdata_body_acc_x, traindata_body_acc_x), ncol = 128, byrow=TRUE)
body_acc_y <- matrix(c(testdata_body_acc_y, traindata_body_acc_y), ncol = 128, byrow=TRUE)
body_acc_z <- matrix(c(testdata_body_acc_z, traindata_body_acc_z), ncol = 128, byrow=TRUE)

body_gyro_x <- matrix(c(testdata_body_gyro_x, traindata_body_gyro_x), ncol = 128, byrow=TRUE)
body_gyro_y <- matrix(c(testdata_body_gyro_y, traindata_body_gyro_y), ncol = 128, byrow=TRUE)
body_gyro_z <- matrix(c(testdata_body_gyro_z, traindata_body_gyro_z), ncol = 128, byrow=TRUE)

total_acc_x <- matrix(c(testdata_total_acc_x, traindata_total_acc_x), ncol = 128, byrow=TRUE)
total_acc_y <- matrix(c(testdata_total_acc_y, traindata_total_acc_y), ncol = 128, byrow=TRUE)
total_acc_z <- matrix(c(testdata_total_acc_z, traindata_total_acc_z), ncol = 128, byrow=TRUE)

activity <- rbind(testdataactivity, traindataactivity) 
names(activity) <- c("activity")
subject <- rbind(testdatasubject, traindatasubject) 
names(subject) <- c("subject")

measurements = data.frame(subject)
measurements <- measurements %>%
  mutate(activity = factor(activity$activity, labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING", "STANDING","LAYING"))) %>%
  mutate(body.acc.x.mean =  rowMeans(body_acc_x)) %>%
  mutate(body.acc.x.sd =    apply(body_acc_x,1,sd)) %>%
  mutate(body.acc.y.mean =  rowMeans(body_acc_y)) %>%
  mutate(body.acc.y.sd =    apply(body_acc_y,1,sd)) %>%
  mutate(body.acc.z.mean =  rowMeans(body_acc_z)) %>%
  mutate(body.acc.z.sd =    apply(body_acc_z,1,sd)) %>%
  mutate(body.gyro.x.mean = rowMeans(body_acc_x)) %>%
  mutate(body.gyro.x.sd =   apply(body_acc_x,1,sd)) %>%
  mutate(body.gyro.y.mean = rowMeans(body_gyro_y)) %>%
  mutate(body.gyro.y.sd =   apply(body_gyro_y,1,sd)) %>%
  mutate(body.gyro.z.mean = rowMeans(body_gyro_z)) %>%
  mutate(body.gyro.z.sd =   apply(body_gyro_z,1,sd)) %>%
  mutate(total.acc.x.mean = rowMeans(total_acc_x)) %>%
  mutate(total.acc.x.sd =   apply(total_acc_x,1,sd)) %>%
  mutate(total.acc.y.mean = rowMeans(total_acc_y)) %>%
  mutate(total.acc.y.sd =   apply(total_acc_y,1,sd)) %>%
  mutate(total.acc.z.mean = rowMeans(total_acc_z)) %>%
  mutate(total.acc.z.sd =   apply(total_acc_z,1,sd))
  
#traindatax <- read.csv("train/X_train.txt", sep= " ")
#traindatay <- read.csv("train/X_train.txt")
#traindatasubject <- read.csv("train/subject_train.txt")

save(measurements,file="measurements.df")

activity_subject_grouped <- group_by(measurements, subject, activity)

activity_subject <- summarise(activity_subject_grouped, 
          body.acc.x = mean(body.acc.x.mean),
          body.acc.y = mean(body.acc.y.mean),
          body.acc.z = mean(body.acc.z.mean),
          body.gyro.x = mean(body.gyro.x.mean),
          body.gyro.y = mean(body.gyro.y.mean),
          body.gyro.z = mean(body.gyro.z.mean),
          total.acc.x = mean(total.acc.x.mean),
          total.acc.y = mean(total.acc.y.mean),
          total.acc.z = mean(total.acc.z.mean)
)

save(activity_subject,file="activity_subject.df")
