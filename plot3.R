## Plotting script 2
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

# 3. Draw 3 sub metering graphs
dateTime   <- as.POSIXlt(paste(as.Date(data$Date, format="%d/%m/%Y"), 
                               data$Time, sep=" ")
                         )
plot(dateTime, data$Sub_metering_1,type="l",
     xlab="",ylab="Energy sub metering",
     width=480, height=480)
points(dateTime, data$Sub_metering_3,type="l",col="blue")
points(dateTime, data$Sub_metering_2,type="l",col="red")

legend("topright",
       lty=1, # FOr line graph
       col = c("black","blue","red"), 
       legend = c("Sub_metering_1",
                  "Sub_metering_2",
                  "Sub_metering_3")
       )

# 4. Copy histogram into PNG file in the working directory
dev.copy(png, file = "plot3.png")
dev.off()