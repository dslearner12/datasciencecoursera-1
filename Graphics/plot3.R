## Read in data
pc <- read.table("~/Desktop/powerconsumption.txt", header = TRUE, sep = ";", na.strings = "?")

## Clean data
pc$Date <- as.Date(pc$Date, "%d/%m/%Y")
pc <- subset(pc, (Date >= as.Date("2007-2-1")) & (Date <= as.Date("2007-2-2")))
pc <- pc[complete.cases(pc),]
pc$DT <- paste(pc$Date, pc$Time)
pc$DT <- as.POSIXct(pc$DT)
pc <- pc[,-c(1,2)]

## Create a colored Time Series Plot
png("plot3.png", bg = "white")
with(pc, plot(DT, Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering"))
with(pc, lines(DT, Sub_metering_2, col = "red"))
with(pc, lines(DT, Sub_metering_3, col = "blue"))
legend("topright", col = c("black", "red", "blue"), lwd = c(1, 1, 1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()