
Url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(Url, destfile = "./data/power_consumption.zip", method = "auto")

unzip("./data/power_consumption.zip", exdir = "./data/Data")

dataSize = 2075259 * 9 * 8 / 2^20
memoryNeed

File <- file("./data/Data/household_power_consumption.txt")
DataFile <- read.table(text = grep("^[1,2]/2/2007", readLines(File), value = TRUE), 
                       col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                       sep = ";", header = TRUE)

DataFile$Date <- as.Date(DataFile$Date, format = "%d/%m/%Y")

dateTime <- paste(as.Date(DataFile$Date), DataFile$Time)

DataFile$DateTime <- as.POSIXct(dateTime)


# Creating Plot # 4

png(file = "./plot4.png")
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(DataFile, {
        plot(Global_active_power ~ DateTime, type = "l", 
             ylab = "Global Active Power", xlab = "")
        plot(Voltage ~ DateTime, type = "l", ylab = "Voltage", xlab = "DateTime")
        plot(Sub_metering_1 ~ DateTime, type = "l", ylab = "Energy sub metering",
             xlab = "")
        lines(Sub_metering_2 ~ DateTime, col = "Red")
        lines(Sub_metering_3 ~ DateTime, col = "Blue")
        legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
               bty = "n",
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power ~ DateTime, type = "l", 
             ylab = "Global_rective_power", xlab = "DateTime")
})
dev.off()
