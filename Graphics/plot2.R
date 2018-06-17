## Read in data
pc <- read.table("~/Desktop/powerconsumption.txt", header = TRUE, sep = ";", na.strings = "?")

## Clean data
pc$Date <- as.Date(pc$Date, "%d/%m/%Y")
pc <- subset(pc, (Date >= as.Date("2007-2-1")) & (Date <= as.Date("2007-2-2")))
pc <- pc[complete.cases(pc),]
pc$DT <- paste(pc$Date, pc$Time)
pc$DT <- as.POSIXct(pc$DT)
pc <- pc[,-c(1,2)]

## Create a Time Series Plot
png("plot2.png", bg = "white")
with(pc, plot(DT, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"))
dev.off()