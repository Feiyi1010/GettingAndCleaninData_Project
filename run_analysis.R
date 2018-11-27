##download data
if(!file.exists("./data")) dir.create("./data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/project.zip")
unzip_project <- unzip("./data/project.zip", exdir = "./data")

##1. Merges the training and the test sets to create one data set.
##load data
subject_test <- read.table(unzip_project[14])
x_test <- read.table(unzip_project[15])
y_test <- read.table(unzip_project[16])
subject_train <- read.table(unzip_project[26])
x_train <- read.table(unzip_project[27])
y_train<- read.table(unzip_project[28])
##merge data
testdata <- cbind(subject_test, y_test, x_test)
traindata <- cbind(subject_train, y_train, x_train)
dat1 <- rbind(traindata, testdata)
colnames(dat1)[1:2] <- c("subject", "activity_tab")

##2. Extracts only the measurements on the mean 
##   and standard deviation for each measurement. 
features <- read.table(unzip_project[2], stringsAsFactors = FALSE)
index <- grep(("mean\\(\\)|std\\(\\)"), features$V2)
dat2 <- dat1[, c(1, 2, index+2)]
colnames(dat2) <- c("subject", "activity_tab", features[index, 2])

##3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table(unzip_project[1])
dat3 <- dat2
dat3$activity_tab <- factor(dat3$activity_tab, levels = activity_labels[,1], labels = activity_labels[,2])
colnames(dat3)[2] <- "activity"

##4. Appropriately labels the data set with descriptive variable names.
dat4 <- dat3
names(dat4) <- gsub("^t", "time", names(dat4))
names(dat4) <- gsub("^f", "frequency", names(dat4))
names(dat4) <- gsub("\\()", "", names(dat4))
names(dat4) <- gsub("-mean", "-Mean", names(dat4))
names(dat4) <- gsub("-std", "-Standard deviation", names(dat4))

##5. From the data set in step 4, creates a second, independent tidy data set 
##   with the average of each variable for each activity and each subject.
library(dplyr)
dat5 <- dat4 %>%
        group_by(subject, activity) %>%
        summarise_all(mean)
write.table(dat5, "./data/data_mean.txt", row.names = FALSE)
dat5
