##---------------------------------------------------------------------------------------------------------------------
## reading a file containing household power consumption data and producing four graphs that are placed in one PNG file 
##---------------------------------------------------------------------------------------------------------------------

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

##converting variables to numeric format
dataSubset <- data.frame(dataSubset, GAP=as.numeric(as.character(dataSubset$Global_active_power)))
dataSubset <- data.frame(dataSubset, GRP=as.numeric(as.character(dataSubset$Global_reactive_power)))
dataSubset <- data.frame(dataSubset, SB1=as.numeric(as.character(dataSubset$Sub_metering_1)))
dataSubset <- data.frame(dataSubset, SB2=as.numeric(as.character(dataSubset$Sub_metering_2)))
dataSubset <- data.frame(dataSubset, Vol=as.numeric(as.character(dataSubset$Voltage)))

##preparing for a 2x2 graph layout
par(mfrow=c(2,2))

##creating four graphs
##Graph 1
plot(dataSubset$DateTime,dataSubset$GAP,type="l",ylab="Global Active Power",xlab="",lwd=1.5)

##Graph 2
plot(dataSubset$DateTime,dataSubset$Vol,type="l",ylab="Voltage",xlab="datetime",lwd=1.5)

##Graph 3
plot(dataSubset$DateTime,dataSubset$Sub_metering_3,type="n",ylim=c(0,38),ylab="Energy sub metering",xlab="")
lines(dataSubset$DateTime,dataSubset$SB1)
lines(dataSubset$DateTime,dataSubset$SB2,col="red")
lines(dataSubset$DateTime,dataSubset$Sub_metering_3,col="blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),bty="n")

##Graph 4
plot(dataSubset$DateTime,dataSubset$GRP,type="l",ylab="Global_reactive_power",xlab="datetime",lwd=1.5)

##copying to a PNG file
dev.copy(png, file = "plot4.png",width = 480, height = 480)
dev.off()



