## Tarea de Power Compsumption
## Primero importar los datos que me interesan de un archivo muy grande
setwd("D:/cpinilla/Datascience/ExploratoryAnalisis/Semanna1/Trabajo1")
if(!file.exists("household_power_consumption.txt")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}
rm(list=ls())
HPC <- read.table("household_power_consumption.txt",sep=";",header=TRUE)
HPC_T <- HPC
HPC_T$Date <- as.Date(HPC_T$Date, format ="%d/%m/%Y")
head(HPC_T)
HPC_Work <- HPC_T[(HPC_T$Date =="2007-02-01") | (HPC_T$Date =="2007-02-02"),]
HPC_Work$Global_active_power <- as.numeric(HPC_Work$Global_active_power)
HPC_Work <- transform(HPC_Work,x=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(HPC_Work, {
  hist(HPC_Work$Global_active_power, col = "red", xlab="Global active power (Kilowatts)",ylab="Frequency")
  with(HPC_Work,plot(x,Global_active_power,type="n",ylab="Global Active Power (Kilowatts)"))
  lines(HPC_Work$Global_active_power~HPC_Work$x,lwd=2)
  with(HPC_Work,plot(x,Sub_metering_1,type="n",ylab="Energy Submetering"))
  lines(HPC_Work$Sub_metering_1~HPC_Work$x,lwd=2,col="black")
  lines(HPC_Work$Sub_metering_2~HPC_Work$x,lwd=2,col="red")
  lines(HPC_Work$Sub_metering_3~HPC_Work$x,lwd=3,col="blue")
  lines(HPC_Work$Global_active_power~HPC_Work$x,lwd=2)
  with(HPC_Work,plot(x,Voltage,type="n",ylab="Voltage"))
  lines(HPC_Work$Voltage~HPC_Work$x,lwd=2)
  '  legend("topright", pch = "-", col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))'
  
})
dev.copy(png, file = "Plot4.png", width = 480, height = 480)
dev.off()
