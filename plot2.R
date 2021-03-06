## Load the data

epc <- read.table("household_power_consumption.txt", na.string ="?", sep=";", header=T)

library(dplyr)
library(lubridate)

## Subset the required date and convert the Date and Time variables to POSIXct format
epc2 <- epc %>%
      filter( Date=="1/2/2007" | Date=="2/2/2007" )  %>%
      mutate( datetime=dmy_hms(paste(Date,Time)) )  %>%
      tbl_df()  %>% 
      print
summary(epc2$datetime)  # Right format


## Plot 2: Time-series Plot of Global Active Power

png("plot2.png", width = 480, height = 480)
with(epc2, plot(datetime, Global_active_power, type="l", 
                xlab="", ylab="Global Active Power (kilowatts)" ) )
dev.off()



