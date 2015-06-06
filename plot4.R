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

## Generate plot 4

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(feb_data, {
        plot(Global_active_power~Datetime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~Datetime, type="l", 
             ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~Datetime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~Datetime, type="l", 
             ylab="Global Rective Power (kilowatts)",xlab="")
})

## Save the chart to the working directory and close the file

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()