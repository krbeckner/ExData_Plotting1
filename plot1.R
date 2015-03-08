#Download data from url
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "power.zip", mode= "r")

#unzip data and read
power <- read.table(unz("power.zip", "household_power_consumption.txt"),header=True, sep=";")

#subset for just 2/1 and 2/2/07
power2 <- power[as.character(power$Date) %in% c("1/2/2007", "2/2/2007"),]

#concatenate date/time
power2$dateTime = paste(power2$Date, power2$Time)

#change date/time from character to date
power2$dateTime <- strptime(power2$dateTime, "%d/%m/%Y %H:%M:%S")
attach(power2)

png("plot1.png", width=480, height=480, units="px")

# Plot the distribution of global active power
hist(as.numeric(as.character(Global_active_power)), col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()