##Set the working directory to folder where the data is stored

setwd("~/Data Science/Projects")

##Reading csv data file into memory

power_data <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?" )

## Format date and time fields

power_data$Date <- as.Date(power_data$Date, format="%d/%m/%Y")
power_data$Time <- strptime(power_data$Time, "%H:%M:%S")
power_data$Time <- strftime(power_data$Time, "%H:%M:%S")

## Extract the data for the exercise

feb_data <- subset(power_data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Generate the chart
hist(feb_data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Save the chart to the working directory and close the file

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
