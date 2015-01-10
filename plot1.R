##------------------------------------------------------------------------------------------------------------------------
## reading a file containing household power consumption data and producing a histogram of the frequency of global active power
##------------------------------------------------------------------------------------------------------------------------

## reading the file
file <- read.table("household_power_consumption.txt",sep=";",header=T,na.strings ="?")

##removing NA values
fileWithoutNA <- file[complete.cases(file),]

##converting Date format
f <- data.frame(fileWithoutNA, formattedDate = as.Date(fileWithoutNA$Date,"%d/%m/%Y"))

##subsetting the data to cover only Feb 1 - Feb 2 of 2007 dates
dataSubset <- subset(f,f$formattedDate >="2007-2-1" & f$formattedDate <="2007-2-2")

##converting "global active power" format
dataSubset <- data.frame(dataSubset, GAP=as.numeric(as.character(dataSubset$Global_active_power)))

##producing the histogram
hist(dataSubset$GAP,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")

##copying to a PNG file
dev.copy(png, file = "plot1.png",width = 480, height = 480)
dev.off()


