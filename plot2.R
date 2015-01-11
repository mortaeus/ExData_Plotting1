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

# plot plot2
plot2 <- function(data) {
    png("plot2.png")
    y <- data$Global_active_power
    plot(y, type="n", ylab= "Global Active Power (kilowatts)", xlab="", main=NULL, xaxt="n")
    axis(1, at=seq(0, length(y), by=length(y) / 2), labels=c("Thu", "Fri", "Sat"))
    lines(y)
    dev.off()
}

data <- readData()
plot2(data)
atsss <- seq(0, length(data$Global_active_power), by=length(data$Global_active_power) / 2)
