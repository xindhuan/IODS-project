# Name: Xindi Huang
# Date: 3.12.2023
# Descriptiion: This script for data wrangling
# Data source: "https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv","https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv"

# Load library
library(readr)
library(dplyr)

# Load data
human <- read_csv("./data/human.csv")

# Explore the structure and dimensions of data
str(human)
dim(human)

# Brief description of the dataset: 
# This dataset appears to include various socio-economic indicators for 195 countries, providing a comprehensive view of human development and gender-related metrics.

names(human)
new_colnames <- c("HDI.Rank", "Country", "HDI", "Life.Exp", "Edu.Exp", "Edu.Mean", 
                  "GNI", "GNI.Minus.Rank", "GII.Rank", "GII", "Mat.Mor", "Ado.Birth", 
                  "Parli.F", "Edu2.F", "Edu2.M", "Labo.F", "Labo.M", "Edu2.FM", "Labo.FM")
colnames(human) <- new_colnames

# Exclude unneeded variables
names(human)
keep <- c( "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))

# Remove rows with missing values
human <- filter(human, complete.cases(human))

# Remove the observations which relate to regions instead of countries
last <- nrow(human) - 7
human <- human[1:last, ]

dim(human)

# Save the cleaned 'human' data in the data folder
write_csv(human, "./data/human.csv")
