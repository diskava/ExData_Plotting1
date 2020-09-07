library("data.table")
getwd()
#Reads in data from file then subsets data for specified dates
dsate <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
dsate[,Global_active_power := lapply(.SD, as.numeric),.SDcols = c("Global_active_power")]
# Making a POSIXct date capable of being filtered and graphed by time of day
dsate[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
# Get Dates from 2007-02-01 to 2007-02-02
dsate <- dsate[ (dateTime < "2007-02-03")&(dateTime >= "2007-02-01")]

png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))

# Plotting
plot(dsate[, dateTime], dsate[, Global_active_power], type="l", xlab="", ylab="Global Active Power")
plot(dsate[, dateTime],dsate[, Voltage], type="l", xlab="datetime", ylab="Voltage")
plot(dsate[, dateTime], dsate[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")

lines(dsate[, dateTime], dsate[, Sub_metering_2], col="red")
lines(dsate[, dateTime], dsate[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 


plot(dsate[, dateTime], dsate[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()



