#Kati Puukko
#Creating human data for exercise 5
#Human Development Index (HDI)
#Gender Inequality Index (GII)


##Read the data sets##
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

##Explore the structure and dimensions of the data sets##

str(hd) #195 observations, 8 variables
dim(hd)
summary(hd)

str(gii) #195 observations, 10 variables
dim(gii)
summary(gii)

##Rename the variables using Rename function (new_name = old_name).
##I was not able to run the code because R does not find the original columns names that I'm trying to rename. Any help?

colnames(hd)

hd <- data %>% 
  rename(rank = HDI.Rank, country = Country, hdi = Human.Development.Index..HDI., 
         lifex = Life.Expectancy.at.Birth, eduyear = Expected.Years.of.Education, 
         medu = Mean.Years.of.Education, income = Gross.National.Income..GNI..per.Capita,
         capi = GNI.per.Capita.Rank.Minus.HDI.Rank)

colnames(gii)

gii <- data %>% 
  rename(grank = GII.Rank, Country = Country, gind = Gender.Inequality.Index..GII., 
         morta = Maternal.Mortality.Ratio, brate = Adolescent.Birth.Rate, 
         parl = Percent.Representation.in.Parliament, fedu = Population.with.Secondary.Education..Female.,
         medu = Population.with.Secondary.Education..Male.,flab = Labour.Force.Participation.Rate..Female.,
         mlab = Labour.Force.Participation.Rate..Male.)

#Mutate “Gender inequality” data and create two new variables

#the ratio of Female and Male populations with secondary education in each country. (i.e. edu2F / edu2M).
gii <- mutate(gii, fmedu = (fedu + medu))

#labour force participation of females and males in each country (i.e. labF / labM).
gii <- mutate(gii, fmlab = (flab + mlab))

# Join the two data sets using the variable *Country* as identifier
library(dplyr)
hd_gii <- inner_join(hd, gii, by = "Country", suffix = c(".gii", ".hd"))
dim(hd_gii)
str(hd_gii)
colnames(hd_gii)

# Save the data
write.csv(hd_gii, file = "data/hd_gii.csv", row.names = FALSE)
write.table(hd_gii, file = "data/hd_gii.txt", sep="\t")


