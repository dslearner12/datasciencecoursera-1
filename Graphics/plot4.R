## Read in data
pc <- read.table("~/Desktop/powerconsumption.txt", header = TRUE, sep = ";", na.strings = "?")

## Clean data
pc$Date <- as.Date(pc$Date, "%d/%m/%Y")
pc <- subset(pc, (Date >= as.Date("2007-2-1")) & (Date <= as.Date("2007-2-2")))
pc <- pc[complete.cases(pc),]
pc$DT <- paste(pc$Date, pc$Time)
pc$DT <- as.POSIXct(pc$DT)
pc <- pc[,-c(1,2)]

## Create multiple plots
png("plot4.png", bg = "white")
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(pc, plot(DT, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
with(pc, plot(DT, Voltage, type = "l", xlab = "datetime", ylab = "Voltage (volt)"))
with(pc, plot(DT, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(pc, lines(DT, Sub_metering_2, col = "red"))
with(pc, lines(DT, Sub_metering_3, col = "blue"))
legend("topright", col = c("black", "red", "blue"), bty = "n", lwd = 2, lty = 1, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(pc, plot(DT, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power"))
dev.off()