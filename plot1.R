library(data.table)

# Download data

if(!file.exists("./Household")){dir.create("./Household")}
FileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(FileUrl, destfile = "./Household.zip")

# Unzip file

HouseholdUnzipped <- unzip("Household.zip", exdir="Household")

# Read a subset of the data 

data <- read.table(HouseholdUnzipped, header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
subsetHousehold <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]

# Make the variable 'Global_active_power' numeric

globalActivePower <- as.numeric(subsetHousehold$Global_active_power)

# Create a png file

png("plot1.png", width=480, height=480)

# Make the histogram

hist(globalActivePower, col = "red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

# Close the png

dev.off()


