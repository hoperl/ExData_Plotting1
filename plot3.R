#-----------------------------------------
# Read the data from the online zip file
#-----------------------------------------

temp<-tempfile()
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', temp)
data<-read.table(unz(temp, "household_power_consumption.txt"), header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
head(data)
dim(data)
unlink(temp)

#Extract the subset of data for Feb 1st & 2nd of 2007 relevant for this project
targetData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
dim(targetData)

#-------------------------------------------------------------------------
#Plot sub-metering over the interval and save it as a PNG file, plot3.png
#-------------------------------------------------------------------------

#Extract the values for Global Active Power
globalActivePower <- as.numeric(targetData$Global_active_power)
summary(globalActivePower)
interval <- strptime(paste(targetData$Date, targetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
head(interval)

#Extract sub-metering data
subMetering1 <- as.numeric(targetData$Sub_metering_1)
subMetering2 <- as.numeric(targetData$Sub_metering_2)
subMetering3 <- as.numeric(targetData$Sub_metering_3)

png("plot3.png", width=480, height=480, bg = "transparent")

plot(interval, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")
plot(interval, subMetering1, type="l", ylab="Energy Submetering", xlab="")
lines(interval, subMetering2, type="l", col="red")
lines(interval, subMetering3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

dev.off()