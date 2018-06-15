# Install libraries
packages <- c("reshape2")
inst.packages <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(inst.packages)) install.packages(inst.packages)

# Load libraries
invisible(lapply(packages, require, character.only = TRUE))

# Read in data frames
subject_train <- read.table("train/subject_train.txt")
subject_test <- read.table("test/subject_test.txt")
X_train <- read.table("train/X_train.txt")
X_test <- read.table("test/X_test.txt")
y_train <- read.table("train/y_train.txt")
y_test <- read.table("test/y_test.txt")

# Add column names
featureNames <- read.table("features.txt")
names(X_train) <- featureNames[,2]
names(X_test) <- featureNames[,2]
names(y_train) <- "Activity"
names(y_test) <- "Activity"
names(subject_train) <- "ID"
names(subject_test) <- "ID"

# Step 1: Combines files into one dataset
train <- cbind(subject_train, y_train, X_train)
test <- cbind(subject_test, y_test, X_test)
data <- rbind(train, test)

# Step 2: Extract only measurements on the mean and sd
indices <- grep(paste(c("mean\\(\\)", "std\\(\\)"), collapse = "|"), names(data))
data <- data[,c(1, 2, indices)]

# Step 3: Use descriptive activity names
data$Activity <- factor(data$Activity, labels = c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))

# Step 4: Use descriptive variable names
names(data) <- gsub("mean\\()", "Mean", names(data))
names(data) <- gsub("std\\()", "Std", names(data))
names(data) <- gsub("-", ".", names(data))

# Step 5: Create a tidy data set
melted <- melt(data, id = c("ID", "Activity"))
tidy <- dcast(melted, ID+Activity ~ variable, mean)

# Write output
write.csv(tidy, "tidy.csv", row.names=FALSE)
