
##1. Load and manipulate the data

epc <- read.table("household_power_consumption.txt", na.string ="?", sep=";", header=T)

library(dplyr)
library(lubridate)

# Subset the required date and convert the Date and Time variables to POSIXct format
epc2 <- epc %>%
      filter( Date=="1/2/2007" | Date=="2/2/2007" )  %>%
      mutate( datetime=dmy_hms(paste(Date,Time)) )  %>%
      tbl_df()  %>% 
      print
head(epc2$datetime)  # Right format



##2. Plot 1: Histogram of Global Active Power

png("plot1.png", width = 480, height = 480)
with(epc2, hist(Global_active_power, col="red", main="Global Active Power", 
                xlab="Global Active Power (kilowatts)", xlim=c(0,6), ylim=c(0,1200) ) )
dev.off()


##3. Plot 2: Time-series Plot of Global Active Power

png("plot2.png", width = 480, height = 480)
with(epc2, plot(datetime, Global_active_power, type="l", 
                xlab="", ylab="Global Active Power (kilowatts)" ) )
dev.off()


##4. Plot 3: Time-series Plot of Energy Sub Metering

png("plot3.png", width = 480, height = 480)
par(mfcol=c(1,1))
with(epc2, plot(datetime, Sub_metering_1, type="l", col="black", 
                xlab="", ylab="Energy sub metering" ) )
with(epc2, lines(datetime, Sub_metering_2, type="l", col="red") )
with(epc2, lines(datetime, Sub_metering_3, type="l", col="blue") )
legend("topright", col=c("black", "red", "blue"), lty=1,  
       legend=paste("Sub_metering_", 1:3, sep="") )
dev.off()


##5. Plot 4: 2*2 Panel Plots

png("plot4.png", width = 480, height = 480)
par(mfcol=c(2,2))

# Topleft plot
with(epc2, plot(datetime, Global_active_power, type="l", 
                xlab="", ylab="Global Active Power" ) )

# Bottomleft plot
with(epc2, plot(datetime, Sub_metering_1, type="l", col="black", 
                xlab="", ylab="Energy sub metering" ) )
with(epc2, lines(datetime, Sub_metering_2, type="l", col="red") )
with(epc2, lines(datetime, Sub_metering_3, type="l", col="blue") )
legend("topright", col=c("black", "red", "blue"), lty=1, bty="n",
       legend=paste("Sub_metering_", 1:3, sep="") )

# Topright plot
with(epc2, plot(datetime, Voltage, type="l") )

# Bottompright plot
with(epc2, plot(datetime, Global_reactive_power, type="l") )

dev.off()




