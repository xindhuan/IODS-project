# Author: Xindi Huang
# Date: 20.11.2023
# Description: This script analysed Alcohol consumption data

# load required libraries
library(tidyverse)
library(dplyr)

# set the working directory
setwd("~/r/IODS/IODS-project/data")

# read both student-mat.csv and student-por.csv into R
math <- read.csv("student-mat.csv", header = TRUE, sep = ";")
por <- read.csv("student-por.csv", header = TRUE, sep = ";")

# explore the structure and dimensions of the data
str(math)
dim(math)
str(por)
dim(por)

# join the two data sets
free_cols <- c("failures","paid","absences","G1","G2","G3")
join_cols <- setdiff(colnames(por), free_cols)
math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))

# explore the structure and dimensions of the joined data
str(math_por)
dim(math_por)

# remove the duplicate records in the joined data set
alc <- select(math_por, all_of(join_cols))
for(col_name in free_cols) {
  two_cols <- select(math_por, starts_with(col_name))
  first_col <- select(two_cols, 1)[[1]]
  if(is.numeric(first_col)) {
    alc[col_name] <- round(rowMeans(two_cols))
  } else {
    alc[col_name] <- first_col
  }
}

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# glimpse at the alc data
glimpse(alc)

# save the alc data
write_csv(alc, "alc.csv")
