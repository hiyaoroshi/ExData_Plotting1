## ExData_Protting plot2
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

#make a serial chart and save it as a png file
png("plot2.png",width=600,height=600)
par(cex.axis=1.5,cex.lab=1.5)
with(powerDF,
     plot(ptime,Global_active_power,type="l",
          col="black",xlab="",
          ylab="Global Active Power(kilowatts)",
          ))
dev.off()