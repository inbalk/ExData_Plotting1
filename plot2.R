##----------------------------------------------------------------------------------------------------------------------------------
## reading a file containing household power consumption data and producing a graph of global active power consumption per date/time
##----------------------------------------------------------------------------------------------------------------------------------

## reading the file
file <- read.table("household_power_consumption.txt",sep=";",header=T,na.strings ="?")

##removing NA values
fileWithoutNA <- file[complete.cases(file),]

##converting Date format
f <- data.frame(fileWithoutNA, formattedDate = as.Date(fileWithoutNA$Date,"%d/%m/%Y"))

##subsetting the data to cover only Feb 1 - Feb 2 of 2007 dates
dataSubset <- subset(f,f$formattedDate >="2007-2-1" & f$formattedDate <="2007-2-2")

##concatenating Date and Time to one variable
dataSubset$DateTime <- strptime(paste(dataSubset$Date, dataSubset$Time), format="%d/%m/%Y %H:%M:%S") 

##converting "global active power" format
dataSubset <- data.frame(dataSubset, GAP=as.numeric(as.character(dataSubset$Global_active_power)))

##producing the graph
plot(dataSubset$DateTime,dataSubset$GAP,type="l",ylab="Global Active Power (kilowatts)",xlab="",lwd=1.5)

##copying to a PNG file
dev.copy(png, file = "plot2.png",width = 480, height = 480)
dev.off()



