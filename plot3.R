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


# plot plot3
plot3 <- function(data) {

    png("plot3.png")
    y1 <- data$Sub_metering_1
    y2 <- data$Sub_metering_2
    y3 <- data$Sub_metering_3
    plot(y1, type="n", ylab= "Energy sub metering", xlab="", main=NULL, xaxt="n")
    lines(y1)
    lines(y2, col="red")
    lines(y3, col="blue")
    axis(1, at=seq(0, length(y1), by=length(y1) / 2), labels=c("Thu", "Fri", "Sat"))
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), col=c("black", "red", "blue"))
    dev.off()
}

data <- readData()
plot3(data)
