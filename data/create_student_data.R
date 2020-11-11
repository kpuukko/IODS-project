#Kati Puukko, 11.11.2020
#Data wrangling exercise for Exercise 3: Logistic regression

#Read data

setwd('C:/LocalData/kpuukko/IODS-project/data')

student_mat <- read.csv("student-mat.csv", sep=";", header=TRUE)
student_por <- read.csv("student-por.csv", sep=";", header=TRUE)


#Explore the structure and dimensions of the data.

str(student_mat) #395 observations, 33 variables
dim(student_mat) 

str(student_por) #649 pbservations, 33 variables
dim(student_por) 


# Join the two data sets using the common columns to use as identifiers

library(dplyr)

join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")
mat_por <- inner_join(student_mat, student_por, by = join_by, suffix = c(".math", ".por"))
dim(mat_por)
str(mat_por)

colnames(mat_por)

#combine the 'duplicated' answers in the joined data, use datacamp else-if structure to fix it
# create a new data frame with only the joined columns
alc <- select(mat_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(student_mat)[!colnames(student_mat) %in% join_by]

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(mat_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

# now dimensions matches original data
dim(alc) #382 observations and 33 variables
colnames(alc)

#Create a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

#Use 'alc_use' to create a new column 'high_use' for which 'alc_use' is greater than 2 (and FALSE otherwise).
alc <- mutate(alc, high_use = alc_use > 2)

# Glimpse the modified data to check everything is as instructed and it is.
glimpse(alc)

# Save the data

write.csv(alc, file = "data/alc.csv", row.names = FALSE)
