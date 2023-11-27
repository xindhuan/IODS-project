# Name: Xindi Huang
# Date: 27.11.2023
# Descriptiion: This script for data wrangling


# Load library
library(readr)
library(dplyr)

# Read data
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# Explore the datasets
# Structure and dimensions of the data
str(hd) 
str(gii)

# Summaries of variables
summary(hd)
summary(gii)

# Check column names
colnames(hd)
colnames(gii)

# Rename variables 
hd <- rename(hd,
             Country = Country, 
             HDI = `Human Development Index (HDI)`,
             Life.Exp = `Life Expectancy at Birth`,
             Edu.Exp = `Expected Years of Education`, 
             Edu.Mean = `Mean Years of Education`, 
             GNI = `Gross National Income (GNI) per Capita`,
             GNI.minus.HDI = `GNI per Capita Rank Minus HDI Rank`
             )

gii <- rename(gii,
              Country = Country,
              GII = `Gender Inequality Index (GII)`,
              Mat.Mor = `Maternal Mortality Ratio`, 
              Ado.Birth = `Adolescent Birth Rate`, 
              Parli = `Percent Representation in Parliament`, 
              Edu2.F = `Population with Secondary Education (Female)`, 
              Edu2.M = `Population with Secondary Education (Male)`, 
              Labo.F = `Labour Force Participation Rate (Female)`, 
              Labo.M = `Labour Force Participation Rate (Male)`
              )

# Mutate the Gender inequality data
gii <- mutate(gii, 
              "Edu2.FM" = Edu2.F / Edu2.M, 
              "Labo.FM" = Labo.F / Labo.M)

# Join together the two datasets by Country
human <- inner_join(hd, gii, by = "Country")
dim(human)

# Save dataset
write_csv(human, "./data/human.csv")

