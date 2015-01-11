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

# plot plot1
plot1 <- function(data) {
    png("plot1.png")
    hist(data$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
    dev.off()
}

data <- readData()
plot1(data)
