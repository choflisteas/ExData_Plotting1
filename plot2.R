zipfile <- "dataset.zip"
if (!file.exists(zipfile)){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = filename)
        unzip(zipfile, overwrite = TRUE)
}

data <- read.csv("household_power_consumption.txt", na.strings = "?", sep = ';')

data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

start <- as.Date("2007-02-01")
end <- as.Date("2007-02-03")

with(subset(data, Date>= start & Date<end),plot(DateTime,Global_active_power, type = "l", ylab = "Global Active Power(kilowatts)"))

dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()