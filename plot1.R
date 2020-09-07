library("data.table")
getwd()

#Reads in data from file then subsets data for specified dates
powerDT <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

# Prevents histogram from printing in scientific notation
powerDT[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Change Date Column to Date Type
powerDT[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Get Dates from 2007-02-01 to 2007-02-02
powerDT <- powerDT[(Date <= "2007-02-02")&(Date >= "2007-02-01")]

png("plot1.png", width=480, height=480)

## Plotting 
hist(powerDT[, Global_active_power], main="Global Active Power Usage", 
     xlab="Global Active Power - kW", ylab="Frequency", col="Red")

dev.off()

