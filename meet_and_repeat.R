# load required libraries
library(tidyverse)
library(readr)
# load datasets
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = TRUE)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep = '\t', header = TRUE)

# check dataset
str(BPRS)
str(RATS)

dim(BPRS)
dim(RATS)

summary(BPRS)
summary(RATS)

# convert categorical variables to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# convert data sets to long form
BPRSL <-  pivot_longer(BPRS, cols=-c(treatment,subject),
                       names_to = "weeks",
                       values_to = "bprs") %>% 
  mutate(week = as.integer(substr(weeks,5,5))) %>% 
  arrange(weeks)

RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD, 3, 4))) %>%
  arrange(Time)

# check the new data sets and compare with wide form versions
summary(BPRSL)
str(BPRSL)
head(BPRSL)

summary(RATSL)
str(RATSL)
head(RATSL)

rm(BPRS)
rm(RATS)

# save data
write_csv(BPRSL, "./data/bprsl.csv")
write_csv(RATSL, "./data/ratsl.csv")
