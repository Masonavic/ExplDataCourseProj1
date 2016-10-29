# This command imports the data only for the specified dates 2007-02-01 and 2007-02-02.
# The "?" character is specified as NA
PowerData<-read.csv(file="household_power_consumption.txt",sep=";", header = FALSE, skip = 66637, nrows = (69517-66638),stringsAsFactors = FALSE,na.strings = "?")

# We have to import the header separately, since R is apparently incapable of importing a header line AND a separate range of rows.
headers<-scan(file="household_power_consumption.txt",what="character",sep=";",nlines = 1)
names(PowerData)<-headers

# Now we have to convert the separate date & time column to a single column containing date objects, since R is apparently inapcable of doing this on import
PowerData$Date.time<-strptime(paste(PowerData$Date,PowerData$Time),format = "%d/%m/%Y %H:%M:%S")

#Generate and save the plot as PNG
png("plot4.png")
par(mfrow=c(2,2))
with(PowerData, {
  #Plot1
  plot(Date.time,Global_active_power,ylab = "Global Active Power (kilowatt)",xlab="",type = "l")
  
  #Plot2
  plot(Date.time,Voltage,ylab = "Voltage",xlab="datetime",type = "l")
  
  #Plot3
  plot(Date.time,Sub_metering_1,ylab = "Energy sub metering",xlab="",type = "l")
  lines(Date.time,Sub_metering_2,col="red")
  lines(Date.time,Sub_metering_3,col="blue")
  legend("topright",legend=names(PowerData)[7:9],col=c("black","red","blue"),lwd=1,bty="n")
  
  #Plot4
  plot(Date.time,Global_reactive_power,xlab="datetime",type = "l")
  })
dev.off()