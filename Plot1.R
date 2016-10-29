# Import data

# This command imports the data only for the specified dates 2007-02-01 and 2007-02-02.
# The "?" character is specified as NA
PowerData<-read.csv(file="household_power_consumption.txt",sep=";", header = FALSE, skip = 66637, nrows = (69517-66638),stringsAsFactors = FALSE,na.strings = "?")

# We have to import the header separately, since R is apparently incapable of importing a header line AND a separate range of rows.
headers<-scan(file="household_power_consumption.txt",what="character",sep=";",nlines = 1)
names(PowerData)<-headers

# Now we have to convert the separate date & time column to a single column containing date objects, since R is apparently inapcable of doing this on import
PowerData$Date.time<-strptime(paste(PowerData$Date,PowerData$Time),format = "%d/%m/%Y %H:%M:%S")

#Generate and save the plot as PNG
png("plot1.png")
hist(PowerData$Global_active_power, col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()
