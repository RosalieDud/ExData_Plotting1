library(data.table)
library(lubridate)
library(tidyverse)
library(dplyr)

if(!file.exists("./Household")){dir.create("./Household")}
FileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(FileUrl, destfile = "./Household.zip")

HouseholdUnzipped <- unzip("Household.zip", exdir="Household")

data <- read.table(HouseholdUnzipped, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
subsetHousehold <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

# Create variable datetime

datetime <- strptime(paste(subsetHousehold$Date, subsetHousehold$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 

# Make the variable 'Global_active_power' numeric

globalActivePower <- as.numeric(subsetHousehold$Global_active_power)

png("plot2.png", width=480, height=480)

plot(datetime, globalActivePower, type="l", xlab= "", ylab="Global Active Power (kilowatts)")

# Close the png

dev.off()
