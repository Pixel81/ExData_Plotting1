## Plotting script 4
## Written by Pixel
## Last update : 2015.6.6

# 0. Load optional library
library(sqldf)

# 1. Load & unzip file needed into sub './data'
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

if (!file.exists("data")) { dir.create("data") } #Create sub data if not exist

if (!file.exists("./data/household_power_consumption.zip")) {
        download.file(fileUrl, "./data/household_power_consumption.zip") 
} 

unzip("./data/household_power_consumption.zip", exdir = "./data")

# 2. Load the file in data, separators = ";"
data <- read.csv.sql( "./data/household_power_consumption.txt",
                      sep = ";",
                      header = TRUE,
                      stringsAsFactors = FALSE,
                      sql = 'select * from file where Date in 
                      ("1/2/2007","2/2/2007") '
                      )

# Add dateTime values to create plot
dateTime   <- as.POSIXlt(paste(as.Date(data$Date, format = "%d/%m/%Y"), 
                               data$Time, sep = " ")
                         )

# 3. Draw 4 graphes in plot4.png

png("plot4.png", width = 480, height = 480) # Create PNG file
par(mfrow = c(2,2))

# 3.1 First graph : Global Active Power
plot(dateTime,data$Global_active_power,
     type = "l", # Type l = line
     xlab="",ylab="Global Active Power (kilowatts)")

# 3.2 Second graph : Voltage
plot(dateTime,data$Voltage,
     type = "l", # Type l = line
     xlab="datetime",ylab="Voltage")

# 3.3 Third graph : Sub metering
plot(dateTime, data$Sub_metering_1,type = "l",
     xlab = "",ylab = "Energy sub metering") # Line 1
points(dateTime, data$Sub_metering_3,type = "l",col = "blue") # Add second line
points(dateTime, data$Sub_metering_2,type = "l",col = "red") # Add third line

legend("topright", # Add legend
       lty = 1, # For line graph
       col = c("black", # Line 1 color legend
               "blue", # Line 2 color legend
               "red"), # Line 3 color legend
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3"),
       bty = "n" # No line around the legend box
       )

# 3.4 Fourth graph : Global reactive power
plot(dateTime,data$Global_reactive_power,
     type = "l", # Type l = line
     xlab="datetime",ylab="Global_reactive_power")

# 4. Close connexion of PNG file
dev.off()