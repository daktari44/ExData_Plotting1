## Exploring Data Analysis: Course Project 1 - Plot 1

## 1. Download and unzip the dataset into the current working directory
## (after testing if the dataset is not already working directory )
if(!file.exists("household_power_consumption.txt")){
      datasource <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
      if(!file.exists("./data")){dir.create("./data")}
      download.file(datasource, destfile = "./data/householdpower.zip", method = "auto", mode= "wb")
      unzip("./data/householdpower.zip") 
      rm(datasource) 
}

## 2. Load required libraries
library(dplyr)


## 3. Read data into memory - subsetting only the dates required for the analysis
col_types <- c(rep("character", 2), rep("numeric", 7))

housepower <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?",  
                         header = TRUE, colClasses = col_types)%>%
      filter(Date == "1/2/2007"|Date =="2/2/2007")


## 4. Plot "Global Active Power" histogram
png("plot1.png")

with(housepower,
      hist(Global_active_power, main = "Global Active Power", 
           xlab = "Global Active Power (kilowatts)", 
           col = "red", bg = "transparent")) 
 
dev.off()
