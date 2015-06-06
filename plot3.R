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

## Combine date and time fields

DateTime <-as.POSIXct(paste(feb_data$Date, feb_data$Time), format="%Y-%m-%d %H:%M:%S")
feb_data$Datetime <- as.POSIXct(DateTime)

## Generate plot 3

with(feb_data, {
        plot(Sub_metering_1~Datetime, type="l",
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## Save the chart to the working directory and close the file

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
