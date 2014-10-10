## Exploring Data Analysis: Course Project 1 - Plot 2

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
library(lubridate)

## 3. Read data into memory - subsetting only the dates required for the analysis
  ## and merging the Date and Time variables into a new datetime variable.

col_types <- c(rep("character", 2), rep("numeric", 7))
housepower <- read.table("household_power_consumption.txt", sep = ";", na.strings = "?",  
                         header = TRUE, colClasses = col_types)%>%
      filter(Date == "1/2/2007"|Date =="2/2/2007")%>%
      mutate(datetime = dmy_hms(paste(Date, Time)))
      

## 4. Plot the required graphs to a png file

png("plot4.png")
par(mfcol = c(2,2), bg = "transparent")
with(housepower, {
      plot(datetime, Global_active_power, type = "l", xlab = "", ylab="Global Active Power")
      plot(rep(datetime, 3), c(Sub_metering_1, Sub_metering_2, Sub_metering_3), type ="n", xlab = "", 
           ylab = "Energy sub metering")
      lines(datetime, Sub_metering_1, col = "black")
      lines(datetime, Sub_metering_2, col = "red")
      lines(datetime, Sub_metering_3, col = "blue")
      legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
             lty = c(1,1,1), col = c("black", "red", "blue"))
      plot(datetime, Voltage, type = "l")
      plot(datetime, Global_reactive_power, type = "l")
      
})
dev.off()
