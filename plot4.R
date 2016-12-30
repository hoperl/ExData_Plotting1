#-----------------------------------------
# Read the data from the online zip file
#-----------------------------------------

temp<-tempfile()
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', temp)
data<-read.table(unz(temp, "household_power_consumption.txt"), header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
head(data)
dim(data)
unlink(temp)

#----------------------------------------------------------------------------
# Plot each of the below statistics over date time interval and save the  
# result as a PNG file, plot4.png
#
# 1. Global Active Power
# 2. Voltage
# 3. Energy sub metering
# 4. Global_reactive_power
#----------------------------------------------------------------------------

#Extract the subset of data for Feb 1st & 2nd of 2007 relevant for this project
targetData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
dim(targetData)

png("plot4.png", width=480, height=480, bg = "transparent")
par(mfrow = c(2, 2)) 

interval <- strptime(paste(targetData$Date, targetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
head(interval)

#Extract the values for Global Active Power & plot against datetime
globalActivePower <- as.numeric(targetData$Global_active_power)
summary(globalActivePower)
plot(interval, globalActivePower, type="l", xlab="", ylab="Global Active Power", cex=0.2)

#Extract Voltage & plot against datetime
voltage <- as.numeric(targetData$Voltage)
plot(interval, voltage, type="l", xlab="datetime", ylab="Voltage")

#Extract sub-metering data & plot against datetime
subMetering1 <- as.numeric(targetData$Sub_metering_1)
subMetering2 <- as.numeric(targetData$Sub_metering_2)
subMetering3 <- as.numeric(targetData$Sub_metering_3)
plot(interval, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(interval, subMetering2, type="l", col="red")
lines(interval, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=, lwd=2.5, col=c("black", "red", "blue"), bty="o")

#Extract Global Reactive Power & plot against datetime
globalReactivePower <- as.numeric(targetData$Global_reactive_power)
plot(interval, globalReactivePower, type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()