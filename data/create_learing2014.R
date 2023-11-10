# Name: Xindi Huang
# Date: 10th Nov 2023
# File Description: This is a R script created for data wrangling exercises

### Set the working directory to the IODS Project folder

setwd("~/r/IODS/IODS-project/")

# load the data
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# Look at the structure of the data
str(lrn14)
# str() provides information about the structure of the dataframe. It shows the names and types of each column, as well as a preview of the first few rows of data.

# Look at the dimensions of the data
dim(lrn14)
# dim() shows the dimensions of the dataframe. It shows that there are 183 rows and 60 columns in the dataset.

# Access the dplyr library
library(dplyr)

# create column 'attitude' by scaling the column "Attitude"
lrn14$attitude <- lrn14$Attitude / 10

# select the columns related to deep learning and take the mean
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
lrn14$deep <- rowMeans(lrn14[, deep_questions])

# select the columns related to surface learning and take the mean
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
lrn14$surf <- rowMeans(lrn14[, surface_questions])

# select the columns related to stractegic learning and take the mean
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
lrn14$stra <- rowMeans(lrn14[, strategic_questions])


# choose columns to keep
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

# select the 'keep_columns' to create a new dataset
learning2014 <- lrn14[, keep_columns]

# change columns name
colnames(learning2014)
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"
colnames(learning2014)

# select rows where points is greater than zero
learning2014 <- filter(learning2014, points > 0)
str(learning2014)


# Save the dataset to CSV file in the 'data' folder
write_csv(learning2014, "data/learning2014.csv")

# Read the CSV file back into R
learning2014_data <- read_csv("data/learning2014.csv")

# check if the structure of the data is correct
str(learning2014_data)
head(learning2014_data)

