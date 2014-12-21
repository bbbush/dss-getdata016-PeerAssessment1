# setup
library(data.table)
library(plyr)

# assume files have been downloaded
function(
  url="https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI HAR Dataset.zip",
  file="UCI HAR Dataset.zip"){
  if(!file.exists(file))
  {
    download.file(url, file, method="curl")
  }
  if(!file.exists("UCI HAR Dataset"))
  {
    unzip(file)
  }
}()

# read activity labels as factor
activity.labels<-(function(
  file="UCI HAR Dataset/activity_labels.txt"){
  ds<-read.csv(file, sep=" ",header=FALSE)
  factor(ds$V1, labels=ds$V2)
})()

# read feature labels as vector
feature.labels<-(function(
  file="UCI HAR Dataset/features.txt"){
  ds<-read.csv(file, sep=" ", header=FALSE)
  as.character(ds$V2)
})()

# read subject (test) dataset, total 9 unique
test.subjects<-(function(
  file="UCI HAR Dataset/test/subject_test.txt"){
  ds<-read.csv(file, header=FALSE)
  as.numeric(ds$V)
})()

# read subject (train) dataset, total 21
train.subjects<-(function(
  file="UCI HAR Dataset/train/subject_train.txt"){
  ds<-read.csv(file, header=FALSE)
  as.numeric(ds$V)
})()

# in train dataset, there are 7352 records
# in test dataset, there are 2947 records
# natually the result dataset will have 10299 rows
# each row will have 561 variables
test.dataset<-(function(
  file="UCI HAR Dataset/test/X_test.txt",
  file.activity="UCI HAR Dataset/test/y_test.txt"){
  ds<-read.table(file, header=FALSE)
  names(ds)<-feature.labels
  ds.activity<-read.csv(file.activity, header=FALSE)
  ds$activity<-ds.activity$V
  levels(ds$activity)<-activity.labels
  ds$subject<-test.subjects
  ds
})()

train.dataset<-(function(
  file="UCI HAR Dataset/train/X_train.txt",
  file.activity="UCI HAR Dataset/train/y_train.txt"){
  ds<-read.table(file, header=FALSE)
  names(ds)<-feature.labels
  ds.activity<-read.csv(file.activity, header=FALSE)
  ds$activity<-ds.activity$V
  levels(ds$activity)<-activity.labels
  ds$subjects<-train.subjects
  ds
})()

# combine all results
total.dataset<-(function(){
  ds<-test.dataset
  names(ds)<-names(train.dataset)
  ds<-rbind(ds, train.dataset)
  levels(ds$activity)<-activity.labels
  ds
})()

# write to disk
write.table(total.dataset, "total_dataset.txt", row.name=FALSE)

# each row will also have 128 variables for inertial signals
