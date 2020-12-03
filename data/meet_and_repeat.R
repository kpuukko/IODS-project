#Kati Puukko
#Creating data for analysis 6
#3.12.2020

##Download packages
library(dplyr)
library(tidyr)

## 1. Load the data sets(BPRS and RATS) into R

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep=" ", header=T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep='\t', header=T)

#check their variable names

names(BPRS)
names(RATS)

#view the data contents and structures

str(BPRS)
dim(BPRS) #40 observations, 11 variables

str(RATS)
dim(RATS) #16 observations, 13 variables

#create some brief summaries of the variables

summary(BPRS) 
#In total 40 participants in the data,who have participated in the study during 8 weeks.
#The participants are divided to two treatment groups with 20 participants in both groups 

summary(RATS)
#3 groups of rats that had different diets
#other variables describe different nutrition indicators (e.g.body weight)

#2. Convert the categorical variables of both data sets to factors.

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

#3. Convert the data sets to long form. 

# Convert to long form and add a week variable to BPRS

BPRS_long <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)
BPRS_long <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

#Convert to long form and add time variable to RATS

RATS_long <- RATS %>%
  gather(key = WD, value = Weight, -ID, -Group) %>%
  mutate(Time = as.integer(substr(WD,3,4)))

#4. Take a serious look at the data sets

glimpse(BPRS_long) #360 rows, 5 columns
glimpse(RATS_long)#176 rows, 5 columns

summary(BPRS_long)
summary(RATS_long)

str(BPRS_long) #treatment and subject are now factors
str(RATS_long) #ID and group are factors

names(BPRS_long) #week and time variables exists
names(RATS_long)

#In long format, observations are listed in separate rows one below another.
#In long format observations present repeated measures of the same person, 

#Save the datasets

write.table(BPRS_long, file = "data/BPRSL.txt", sep="\t")
write.table(RATS_long, file = "data/RATSL.txt", sep="\t")
