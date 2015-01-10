##----------------------------------------------------------------------------------------------------------------------
## reading a file containing household power consumption data and producing a graph of energy sub metering per date/time
##----------------------------------------------------------------------------------------------------------------------

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
dataSubset <- data.frame(dataSubset, SB1=as.numeric(as.character(dataSubset$Sub_metering_1)))
dataSubset <- data.frame(dataSubset, SB2=as.numeric(as.character(dataSubset$Sub_metering_2)))

##initializing the graph
plot(dataSubset$DateTime,dataSubset$Sub_metering_3,type="n",ylim=c(0,38),ylab="Energy sub metering",xlab="")

##adding data to the graph
lines(dataSubset$DateTime,dataSubset$SB1)
lines(dataSubset$DateTime,dataSubset$SB2,col="red")
lines(dataSubset$DateTime,dataSubset$Sub_metering_3,col="blue")

##adding a legend to the graph
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,col=c("black","red","blue"),cex=1.2)
       
##copying to a PNG file
dev.copy(png, file = "plot3.png",width = 480, height = 480)
dev.off()


