zipfile <- "dataset.zip"
dest <- paste0(getwd(), "/", zipfile)
if (!file.exists(zipfile)){
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = dest)
        unzip(zipfile, overwrite = TRUE)
}
data <- read.csv(paste0(getwd(),"/","household_power_consumption.txt"), na.strings = "?", sep = ';')

data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

start <- as.Date("2007-02-01")
end <- as.Date("2007-02-03")

with(subset(data, Date>= start & Date<end),plot(DateTime, Sub_metering_1,xlab = " ", ylab = "Energy sub meterin", type = "l", col = "black", main = ""))
with(subset(data, Date>= start & Date<end),lines(DateTime, Sub_metering_2, col = "red"))
with(subset(data, Date>= start & Date<end),lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright",lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_3", "Sub_metering_3"))

dev.copy(png, file = paste0(getwd(), "/", "plot3.png"), width = 480, height = 480)
dev.off()

