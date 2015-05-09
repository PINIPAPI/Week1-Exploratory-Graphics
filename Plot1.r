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
hist(HPC_Work$Global_active_power, col = "red", main = "Global Active Power", xlab="Global active power (Kilowatts)",ylab="Frequency")
dev.copy(png, file = "Plot1.png", width = 480, height = 480)
dev.off()
