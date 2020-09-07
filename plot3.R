library("data.table")
getwd()
#Reads in data from file then subsets data for specified dates
dsate <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
dsate[,Global_active_power := lapply(.SD, as.numeric),.SDcols = c("Global_active_power")]
# Making a POSIXct date capable of being filtered and graphed by time of day
dsate[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
# Get Dates from 2007-02-01 to 2007-02-02
dsate <- dsate[ (dateTime < "2007-02-03")&(dateTime >= "2007-02-01")]
png("plot3.png", width=480, height=480)
# Plottting
plot(dsate[, dateTime], dsate[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(dsate[, dateTime], dsate[, Sub_metering_3],col="blue")
lines(dsate[, dateTime], dsate[, Sub_metering_2],col="red")

legend("topright", col=c("black","red","blue"), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),lty=c(1,1), lwd=c(1,1))

dev.off()
