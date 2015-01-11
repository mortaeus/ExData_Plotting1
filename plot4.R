# downloads and unzips data, then extracts rows corresponding to dates 2007-02-01 and 2007-02-02 and returns result
readData <- function() {
    # download
    temp <- tempfile()
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp, method="curl")

    #unzip and read
    data <- read.csv(unz(temp, "household_power_consumption.txt"), sep=";", colClasses=c("character", "character", rep("numeric", 7)), na.strings="?")

    #delete zip file
    unlink(temp)

    #extract relevant rows
    d1 <- as.Date("2007-02-01")
    d2 <- as.Date("2007-02-02")
    extractedData <- data[as.Date(data$Date, format="%d/%m/%Y") == d1 | as.Date(data$Date, format="%d/%m/%Y") == d2,]
    extractedData
}

# plot plot4
plot4 <- function(data) {
    png("plot4.png")
    par(mfcol=c(2, 2))

    #first plot
    y <- data$Global_active_power
    plot(y, type="n", ylab= "Global Active Power", xlab="", main=NULL, xaxt="n")
    axis(1, at=seq(0, length(y), by=length(y) / 2), labels=c("Thu", "Fri", "Sat"))
    lines(y)

    #second plot
    y1 <- data$Sub_metering_1
    y2 <- data$Sub_metering_2
    y3 <- data$Sub_metering_3
    plot(y1, type="n", ylab= "Energy sub metering", xlab=NULL, main=NULL, xaxt="n")
    lines(y1)
    lines(y2, col="red")
    lines(y3, col="blue")
    axis(1, at=seq(0, length(y1), by=length(y1) / 2), labels=c("Thu", "Fri", "Sat"))
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), col=c("black", "red", "blue"), bty="n")

    #third plot
    y <- data$Voltage
    plot(y, type="n", ylab="Voltage", xlab="datetime", main=NULL, xaxt="n")
    axis(1, at=seq(0, length(y), by=length(y) / 2), labels=c("Thu", "Fri", "Sat"))
    lines(y)

    #fourth plot
    y <- data$Global_reactive_power
    plot(y, type="n", ylab="Global_reactive_power", xlab="datetime", main=NULL, xaxt="n")
    axis(1, at=seq(0, length(y), by=length(y) / 2), labels=c("Thu", "Fri", "Sat"))
    lines(y)

    dev.off()
}

data <- readData()
plot4(data)

