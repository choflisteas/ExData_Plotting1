zipfile <- "dataset.zip"
if (!file.exists(zipfile)){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = filename)
        unzip(zipfile, overwrite = TRUE)
}

data <- read.csv("household_power_consumption.txt", na.strings = "?", sep = ';')
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$Time <- strptime(data$Time, format = "%H:%M:%S")
start <- as.Date("2007-02-01")
end <- as.Date("2007-02-03")
with(subset(data, Date>= start & Date<end),hist(feb$Global_active_power, xlab = "Global Active Power(kilowatts)", col = "red", main = "Global Active Power",xlim = c(0,6), ylim = c(0,1200)))
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()