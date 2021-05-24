library(dplyr)


X_Train <- read.table("./UCI HAR Dataset/train/X_train.txt")
Y_Train <- read.table("./UCI HAR Dataset/train/Y_train.txt")
Subpart_Train <- read.table("./UCI HAR Dataset/train/subject_train.txt")


X_Test <- read.table("./UCI HAR Dataset/test/X_test.txt")
Y_Test <- read.table("./UCI HAR Dataset/test/Y_test.txt")
Subpart_Test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

# read data description
Variable <- read.table("./UCI HAR Dataset/features.txt")

# read activity labels
Labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# 1. Merges the training and the test sets to create one data set.
X_Total <- rbind(X_Train, X_Test)
Y_Total <- rbind(Y_Train, Y_Test)
Subpart_total <- rbind(Subpart_Train, Subpart_Test)


Selected_Var <- Variable[grep("mean\\(\\)|std\\(\\)",Variable_names[,2]),]
X_Total <- X_Total[,selected_var[,1]]

# 3. Uses descriptive activity names to name the activities in the data set
colnames(Y_total) <- "activity"
Y_Total$activitylabel <- factor(Y_total$activity, labels = as.character(Labels[,2]))
activitylabel <- Y_total[,-1]

# 4. Appropriately labels the data set with descriptive variable names.
colnames(X_total) <- Variable[selected_var[,1],2]

# 5. From the data set in step 4, creates a second, independent tidy data set with the average
# of each variable for each activity and each subject.
colnames(Subpart_Total) <- "subject"
total <- cbind(X_total, activitylabel, Subpart_Total)
total_mean <- total %>% group_by(activitylabel, subject) %>% summarize_each(funs(mean))
write.table(total_mean, file = "./UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)
