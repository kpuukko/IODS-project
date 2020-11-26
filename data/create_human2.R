# Creating data for exercise 5
# Kati Puukko, 26.11.2020
# Datasource: http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt

# Install libraries
library(tidyr) 
library(stringr)

# Load data
setwd('C:/LocalData/kpuukko/IODS-project')
human <- read.table("data/hd_gii.txt", sep="\t", header=TRUE)

#Explore structure and dimensions of data
str(human)#195 observations and 17 variables
dim(human)

#Transform the Gross National Income (GNI) variable to numeric 

human$Gross.National.Income..GNI..per.Capita <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric()

#Exclude unneeded variables: keep only the columns matching the following variable names
keep <- c("country", "edu2", "labo", "lifeexp", "yearedu", "GNI", "matmor", "adobirth", "parli")

#Remove all rows with missing values
comp <- complete.cases(human)
human_ <- filter(human, comp == TRUE)

#Remove the observations which relate to regions instead of countries
last <- nrow(human_) - 7
human_ <- human_[1:last, ]

#Define the row names of the data by the country names and remove the country name column from the data.
rownames(human_) <- human_$Country
human_ <- dplyr::select(human_, -Country)

# check that dimension matches 
dim(human)
dim(human_)

# Save the data (overwriting the old file)
write.csv(human_, "data/human2.csv")
