#-----------------------------------------
# Read the data from the online zip file
#-----------------------------------------

#Create a temp file to store the zip file
temp<-tempfile()

#Download the zip file to tempfile
download.file('https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip', temp)

#Read the zip file over connection
data<-read.table(unz(temp, "household_power_consumption.txt"), header=TRUE, sep=";", stringsAsFactors=FALSE, dec=".")
head(data)
dim(data)

#Unlink the zip file
unlink(temp)

#Extract the subset of data for Feb 1st & 2nd of 2007 relevant for this project
targetData <- data[data$Date %in% c("1/2/2007","2/2/2007") ,]
dim(targetData)

#--------------------------------------------------------------------------
#Plot Global Active Power vs interval and save it as a PNG file, plot2.png
#--------------------------------------------------------------------------

#Extract the values for Global Active Power
globalActivePower <- as.numeric(targetData$Global_active_power)
summary(globalActivePower)
interval <- strptime(paste(targetData$Date, targetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
head(interval)

#Open a device to write into a PNG file of 480x480 dimensions
png("plot2.png", width=480, height=480, bg = "transparent")

#Plot the base plot to match to the given screenshot in forked project
plot(interval, globalActivePower, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#Close the plotting device of PNG
dev.off()