install.packages("lubridate")
library(lubridate)

#Read data
data_raw <- read.table("household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep = ";")
data_clean <- data_raw

#Convert to date
data_clean$Date <- as.Date(data_raw$Date, format = "%d/%m/%Y")

#Subset for two chosen dates
data <- subset(data_clean, Date=="2007-02-01" | Date=="2007-02-02")

#Remove unnecessary variables to free up memory
rm(data_raw, data_clean)

#Convert to times and dates
data$Date_Time <- with(data, paste(Date, Time))
data$Date_Time <- ymd_hms(data$Date_Time)
data$Time <- strptime(data$Time, format = "%H:%M:%S")


#convert variables to relevant classes
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)


#Plot 3 - Plot (Energy sub meterings per Day, with legend)
#Defaults in png are width 480 pixels and height 480 pixels
png(filename = "plot3.png")
par(mar = c(5,5,4,4))
with(data, {
        plot(Date_Time, Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = "")
        points(Date_Time, Sub_metering_2, type="l", col="red")
        points(Date_Time, Sub_metering_3, type="l", col="blue")
        legend("topright", legend=names(data)[7:9],lty=c(1,1,1), col = c("black", "red","blue"), cex=0.75)
})
dev.off()
