## ExData_Protting plot1
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

#change format from dd/mm/YYYY to YYYY-mm-dd 
powerDF$Date<-as.Date(powerDF$Date,format="%d/%m/%Y")

#extract 2007-02-01 and 2007-02-02
powerDF<-filter(powerDF, Date=="2007-02-01" | 
                  Date=="2007-02-02")

#make histogram and save as png file
png("plot1.png",width=600,height=600)
par(cex.axis=1.5,cex.lab=1.5)
hist(powerDF$Global_active_power,col="red",
     xlab="Global Active Power(kilowatts)",
     main="")
title(main="Global Active Power")

dev.off()