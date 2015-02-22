# 1. Merges the training and the test sets to create one data set.

#combine X data set
tmp <- read.table("train/X_train.txt")
tmp2 <- read.table("test/X_test.txt")
X <- rbind(tmp, tmp2)

#combine subject data set
tmp <- read.table("train/subject_train.txt")
tmp2 <- read.table("test/subject_test.txt")
S <- rbind(tmp, tmp2)

#combine Y data set
tmp <- read.table("train/y_train.txt")
tmp2 <- read.table("test/y_test.txt")
Y <- rbind(tmp, tmp2)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement.

features <- read.table("features.txt")

#get the required indices
indices <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])

#reduce the data to required ones
X2 <- X[, indices]

#rename X2 data set
names(X2) <- features[indices, 2]

names(X2) <- gsub("\\(|\\)", "", names(X2))



# 3. Uses descriptive activity names to name the activities in the data set.

activities <- read.table("activity_labels.txt")

#replace _ with nothing
activities[, 2] = gsub("_", "", as.character(activities[, 2]))

#relable the activities with descriptions
Y[,1] = activities[Y[,1], 2]

#name Y
names(Y) <- "activity"




# 4. Appropriately labels the data set with descriptive activity names.

#name S
names(S) <- "subject"

#Make the clean data
data <- cbind(S, Y, X2)

#file output
write.table(data, "clean_data.txt")




# 5. Creates a 2nd, independent tidy data set with the average of each variable for each activity and each subject.

uniquesubjects = unique(S)[,1]
subjects_num = length(unique(S)[,1])
activities_num = length(activities[,1])
numCols = dim(data)[2]
result = data[1:(subjects_num*activities_num), ]

row = 1

#loop over subjects
for (s in 1:subjects_num) {
#loop over activities  
  for (a in 1:activities_num) {
    result[row, 1] = uniquesubjects[s]
    result[row, 2] = activities[a, 2]
    tmp <- data[data$subject==s & data$activity==activities[a, 2], ]
    result[row, 3:numCols] <- colMeans(tmp[, 3:numCols])
    row = row+1
  }
}

#data outpout
write.table(result, "final_results.txt", row.name=FALSE)



