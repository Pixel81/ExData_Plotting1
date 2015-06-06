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

# 3. Draw timeline graph
dateTime   <- as.POSIXlt(paste(as.Date(data$Date, format="%d/%m/%Y"), 
                               data$Time, sep=" ")
                         )
plot(dateTime,data$Global_active_power,
     type = "l", # Type l = line
     xlab="",ylab="Global Active Power (kilowatts)")

# 4. Copy histogram into PNG file in the working directory
dev.copy(png, file = "plot2.png")
dev.off()