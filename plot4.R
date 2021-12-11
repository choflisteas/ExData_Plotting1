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

par(mfrow = c(2,2))

with(subset(data, Date>= start & Date<end),
     {
        plot(DateTime,Global_active_power, type = "l", ylab = "Global Active Power(kilowatts)")
        plot(DateTime,Voltage, type = "l", ylab = "Voltage")
        {
                plot(DateTime, Sub_metering_1, ylab = "Energy sub metering", type = "l", col = "black", main = "")
                lines(DateTime, Sub_metering_2, col = "red")
                lines(DateTime, Sub_metering_3, col = "blue")
                legend("topright",lty = 1, y.intersp = 0.75, bty = "n",cex = 0.5, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_3", "Sub_metering_3"))
        }
        plot(DateTime,Global_reactive_power, type = "l", ylab = "Voltage")
     })

dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()