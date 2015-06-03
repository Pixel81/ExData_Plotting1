## Plotting script 1
## Written by Pixel
## Last update : 2015.6.3

## The file need to be unzipped in the working directory

# 0. Load usefull library
library(sqldf)

# 1. Load the file in data, separators = ";"
data <- read.csv.sql("household_power_consumption.txt", 
                     sep = ";",
                     header = TRUE,
                     stringsAsFactors = FALSE,
                     sql = 'select * from file where Date in 
                                ("1/2/2007","2/2/2007") ')

# 2. Draw histogram
hist(data$Global_active_power,
     main = "Global Active Power",
     col = "red",
     xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency"
     )

# 3. Copy histogram into PNG file in the working directory
dev.copy(png, file = "plot1.png")
dev.off()