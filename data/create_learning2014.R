#Kati Puukko, 5.11.2020
#This is R file 

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

str(lrn14) #all variables are integer types
dim(lrn14) #180 observations, 60 variables

# Access the dplyr library
library(dplyr)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
attitude_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# select the columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# select the columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# select the columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# choose a handful of columns to keep
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

#  create a new dataset and exclude cases where the exam point variable is zero 
learning2014 <- filter(select(lrn14, one_of(c("gender","Age","Attitude", "deep", "stra", "surf", "Points"))), Points > 0)
str(learning2014)#166 observations of 7 variables

#Save the analysis dataset 

# Write students2014 as a csv-file to the data folder
write.csv(learning2014, file = "data/learning2014.csv", sep="\t")

# Write students2014 as a table to the data folder
write.table(learning2014, file = "data/learning2014.txt", sep="\t")

str(learning2014)
