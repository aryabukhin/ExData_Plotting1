library(data.table)
library(dplyr)

# for day names in Enlgish
Sys.setlocale(category = "LC_ALL", locale = "en_US.UTF-8")

rawX <- read.table("household_power_consumption.txt", header = TRUE, 
                   sep = ";", na.strings = "?",
                   colClasses = c("character", "character", 
                                  "numeric", "numeric", "numeric", "numeric",
                                  "numeric", "numeric", "numeric"))

X <- data.table(filter(rawX, Date == "1/2/2007" |  Date == "2/2/2007"))
rm(rawX)

X[, TDate := as.Date(Date, format = "%d/%m/%Y")]
X[, TTime := as.POSIXct(strptime(paste(Date, Time, sep=" "), 
                                 format = "%d/%m/%Y %H:%M:%S")) ]


# Plot 4
png("plot4.png", width = 480, height = 480, units = "px")
par(mfrow=c(2,2))
par(mar = c(4, 4, 3, 0))
par(mai = c(0.9, 0.9, 0.4, 0.2))
plot(X$TTime, X$Global_active_power, 
     typ="l", 
     xlab = "", 
     ylab = "Global Active Power")

plot(X$TTime, X$Voltage, 
     typ="l", 
     xlab = "datetime", 
     ylab = "Voltage")

with(X, {plot(TTime, Sub_metering_1, type="l", ylab="Energy sub metering", xlab="")
         points(TTime, Sub_metering_2, type="l", col="red")
         points(TTime, Sub_metering_3, type="l", col="blue")
})
legend("topright", col = c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1)

with(X, plot(TTime, Global_reactive_power, typ="l", xlab = "datetime"))
dev.off()
