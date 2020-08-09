## ExData_Protting plot4
##

library(data.table)
library(dplyr)

#download, unzip, and read data.frame
powerDFurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(powerDFurl,temp)
powerDF<-read.table(unz(temp, "household_power_consumption.txt"),
                    sep=";", header=TRUE, na.strings="?")
unlink(temp)

#extract 1/2/2007 or 2/2/2007
powerDF<-filter(powerDF, Date=="1/2/2007" | 
                  Date=="2/2/2007")
powerDF<-as.data.frame(powerDF)

#add posixtime column
powerDF$ptime<-
  strptime(paste0(powerDF$Date,powerDF$Time),
           format="%d/%m/%Y%H:%M:%S")

## change locale to English
Sys.setlocale("LC_ALL", "English")

#make a 4-charts-frame and save it as a png file
png("plot4.png",width=600,height=600)
par(cex.axis=1.5,cex.lab=1.5)
par(mfcol=c(2,2))
with(powerDF,{
  plot(ptime,Global_active_power,type="l",
       col="black",xlab="",
       ylab="Global Active Power"
  )
  plot(ptime,Sub_metering_1,type="l",
       col="black",xlab="",
       ylab="Energy sub metering",
       ylim=c(0,40))
  par(new="T")
  plot(ptime,Sub_metering_2,type="l",
          col="red",xlab="",ylab="",
          ylim=c(0,40))
  par(new="T")
  plot(ptime,Sub_metering_3,type="l",
          col="blue",xlab="",ylab="",
          ylim=c(0,40))
  par(new="T")
  legend("topright",col=c("black","red","blue"),
       lty=1,cex=1,
       legend=c("Sub_metering_1",
                "Sub_metering_2",
                "Sub_metering_3"))
  plot(ptime,Voltage,type="l",
       col="black",xlab="datetime",
       ylab="Voltage"
  )
  plot(ptime,Global_reactive_power,type="l",
       col="black",xlab="datetime",
       ylab="Global Reactive Power"
  )
  })

dev.off()