library(data.table)
library(lubridate)
library(tidyverse)
library(dplyr)

# Create file an download the datafile

if(!file.exists("./Household")){dir.create("./Household")}
FileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(FileUrl, destfile = "./Household.zip")

# Unzip the file

HouseholdUnzipped <- unzip("Household.zip", exdir="Household")

# Read the table and subset

data <- read.table(HouseholdUnzipped, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
subsetHousehold <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

# Create variable datetime

datetime <- strptime(paste(subsetHousehold$Date, subsetHousehold$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

# Make the variables numeric

globalActivePower <- as.numeric(subsetHousehold$Global_active_power)
globalReactivePower <- as.numeric(subsetHousehold$Global_reactive_power)
subMetering1 <- as.numeric(subsetHousehold$Sub_metering_1)
subMetering2 <- as.numeric(subsetHousehold$Sub_metering_2)
subMetering3 <- as.numeric(subsetHousehold$Sub_metering_3)

png("plot4.png", width=480, height=480)

#starting a plot with 2 rows and columns

par(mfrow=c(2,2))

# plot 1

plot(datetime, globalActivePower, type="l", xlab= "", ylab="Global Active Power (kilowatts)")

# plot 2

plot(datetime, subsetHousehold$Voltage, type="l", xlab= "datetime", ylab="Voltage")

# plot 3

plot(datetime, subMetering1, type = "l", ylab ="Energy sub metering", xlab ="")
lines(datetime, subMetering2, type="l", col="red")
lines(datetime, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

# plot 4

plot(datetime, globalReactivePower, type="l", xlab= "datetime", ylab="Global_reactive_power")

dev.off()
