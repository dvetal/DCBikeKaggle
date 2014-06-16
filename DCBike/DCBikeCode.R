#This is my code to compete on the DC Bike Share Kaggle Competition.

#Load Libraries
library(ggplot2)

#Load Raw Data
RawTrain <- read.csv("data/train.csv",header=T)
RawTest  <- read.csv("data/test.csv",header=T)
RawSubmission  <- read.csv("data/sampleSubmission.csv",header=T)

#I want to keep my raw dataframes raw and seperate them from
#any action I may take on them.  Therefore, I'm going to 
#immediately build a copy.
Train <- RawTrain
Test <- RawTest

#add columns to both train and test by creating a function and doing apply
GetTime <- function(somedatetime) {
  hours <- substr(somedatetime,12,13)
  return(hours)
}

#The following applies my gettime function to make a new column
#that just gives the hour of the day as a factor so I can plot it.
Train$hour <- lapply(Train$datetime, GetTime)
Train$hour <- as.integer(Train$hour)
Train$hour <- as.factor(Train$hour)

Test$hour <- lapply(Test$datetime, GetTime)
Test$hour <- as.integer(Test$hour)
Test$hour <- as.factor(Test$hour)


#there is one datapoint that show weather as 4.  Imputing to 3.
Train[Train$weather==4,]
Train$weather[5632] <- 3


#do some discovery plots
#PLOT 1: see how demand changes depending on the hour of the day
hour.bar <- ggplot(Train, aes(hour,count)) +geom_bar(stat = "identity")
hour.bar + facet_grid(season ~ .)
hour.bar

test.plot <- ggplot(RawTest, aes(x=weather)) + geom_histogram()
test.plot

reg.plot <- ggplot(Train, aes(x=atemp, y=count)) + geom_point(size=1)
reg.plot + facet_grid(season ~ weather)

box.plot <- ggplot(RawTrain,aes(x=season, y=windspeed)) + geom_boxplot()
box.plot


