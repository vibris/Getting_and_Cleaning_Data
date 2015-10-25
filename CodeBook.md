train - Training set from 'train/X_train.txt'
test - Test set from 'test/X_test.txt'

trainActivity - Training labels from 'train/y_train.txt'
testActivity - Test labels from 'test/y_test.txt'

trainId - Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30 from 'train/subject_train.txt'
testId - Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30 from 'test/subject_test.txt'

join <- rbind(train, test) - Merges the training and the test sets to create one data set

features - List of all features from 'features.txt'

colnames(join) <- c(as.vector(features$V2), "Activity", "SubjectId") - Appropriately labels the data set with descriptive variable names

activity - Links the class labels with their activity name
join$"Activity" <- as.factor(activity$V2[join$"Activity"]) - Uses descriptive activity names to name the activities in the data set

features2 <- c(grep(pattern = "mean\\(", features$V2, value = TRUE),grep(pattern = "std\\(", features$V2, value = TRUE), "Activity", "SubjectId") - fields on the mean and standard deviation
join2 <- join[,features2] - Extracts only the measurements on the mean and standard deviation for each measurement

join3 <- group_by(join2, Activity, SubjectId)%>% summarise_each(funs(mean)) - From the data set in prev step, creates a second, independent tidy data set with the average of each variable for each activity and each subject


