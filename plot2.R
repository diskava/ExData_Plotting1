library("data.table")
getwd()
#Reads in data from file then subsets data for specified dates
dsate <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")
dsate[,Global_active_power := lapply(.SD, as.numeric),.SDcols = c("Global_active_power")]
# Making a POSIXct date capable of being filtered and graphed by time of day
dsate[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
# Get Dates from 2007-02-01 to 2007-02-02
dsate <- dsate[ (dateTime < "2007-02-03")&(dateTime >= "2007-02-01")]
png("plot2.png", height=480,width=480)
## Plotting 
plot(x = dsate[, dateTime]  , y = dsate[, Global_active_power]  , type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.off()
