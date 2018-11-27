# GettingAndCleaninData_Project
The course project for Getting and Cleanin Data.
The script can make the raw data downloaded from the given URL to a tidy dataset.
The main steps follow the instruction of the course project.

First, I download the zip file and unzipped it. The paths of all the unzipped files are stored in 'unzip_project'.

Step 1: Merges the training and the test sets to create one data set.
First, I load the data required.
Then use 'cbind' and 'rbind' to merge those data sets.
I named the dataset 'dat1'

Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.
After loading the 'features.txt', I use grep to get the index of all the features whose names contain either 'mean' or 'std'.
Then I use the index to extract those colums in dat1 and store the new dataset in dat2.
I also rename the colums in dat2.

Step 3: Uses descriptive activity names to name the activities in the data set
Use the activity name I get from 'activity_labels.txt' to replace the tabs in the second colum of dat2.
Store the new dataset as dat3.

Step 4: Appropriately labels the data set with descriptive variable names.
I change some of the colum names into more appropriate ones by using the gsub function.

Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
I use the dplyr package in this step.
I calculate the means for every variables except 'subject' and 'activity' by using group_by and summarise_all function.
And store the new dataset as dat5.
