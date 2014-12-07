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


# Plot 1. Display and save as image
png("plot1.png", width = 480, height = 480, units = "px")
par(mar = c(4, 4, 3, 2))
hist(X$Global_active_power, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     col = "red")
dev.off()