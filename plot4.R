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

png("plot4.png", width=480, height=480, units="px")

par(mfrow=c(2,2))
plot(dateTime, as.numeric(as.character(Global_active_power)), type="l", xlab="", ylab="Global Active Power")

plot(dateTime, as.numeric(as.character(Voltage)), type="l", xlab="datetime", ylab="Voltage")

plot(dateTime, as.numeric(as.character(Sub_metering_1)), type="l", xlab="", ylab="Energy sub metering", ylim=c(0,40))
lines(dateTime, as.numeric(as.character(Sub_metering_2)), col="red")
lines(dateTime, as.numeric(as.character(Sub_metering_3)), col="blue")
legend("topright", lty=1, bty="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))

plot(dateTime, as.numeric(as.character(Global_reactive_power)), type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()