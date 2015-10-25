# Read the training and the test sets
print("Started:")
print("Reading data...")
train <- read.table("project/UCI HAR Dataset/train/X_train.txt")
test <- read.table("project/UCI HAR Dataset/test/X_test.txt")

trainActivity <- read.table("project/UCI HAR Dataset/train/y_train.txt")
testActivity <- read.table("project/UCI HAR Dataset/test/y_test.txt")

trainId <- read.table("project/UCI HAR Dataset/train/subject_train.txt")
testId <- read.table("project/UCI HAR Dataset/test/subject_test.txt")

train <- cbind(train, trainActivity)
train <- cbind(train, trainId)
test <- cbind(test, testActivity)
test <- cbind(test, testId)

# Merges the training and the test sets to create one data set.
print("Merging sets...")
join <- rbind(train, test)

# Appropriately labels the data set with descriptive variable names
print("Labeling data...")
features <- read.table("project/UCI HAR Dataset/features.txt")
colnames(join) <- c(as.vector(features$V2), "Activity", "SubjectId")

# Uses descriptive activity names to name the activities in the data set
print("Naming activities...")
activity <- read.table("project/UCI HAR Dataset/activity_labels.txt")
join$"Activity" <- as.factor(activity$V2[join$"Activity"])

# Extracts only the measurements on the mean and standard deviation for each measurement
print("Extracting mean and std data...")
features2 <- c(grep(pattern = "mean\\(", features$V2, value = TRUE),grep(pattern = "std\\(", features$V2, value = TRUE), "Activity", "SubjectId")
join2 <- join[,features2]

print("Successfully ended!")