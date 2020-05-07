data<-read.table("household_power_consumption.txt",stringsAsFactors=FALSE,header=TRUE,sep=";")

# merge date and time column together
DateTime<-strptime(paste(data$Date,data$Time,sep=" "),"%d/%m/%Y %H:%M:%S")
data<-cbind(data,DateTime)

# convert the columns into their appropriate data type
data$Date<-as.Date(data$Date,format = "%d/%m/%Y")
data$Time<-format(data$Time,format = "%H:%M:%S")
data$Global_active_power<-as.numeric(data$Global_active_power)
data$Global_reactive_power<-as.numeric(data$Global_reactive_power)
data$Voltage<-as.numeric(data$Voltage)
data$Global_intensity<-as.numeric(data$Global_intensity)
data$Sub_metering_1<-as.numeric(data$Sub_metering_1)
data$Sub_metering_2<-as.numeric(data$Sub_metering_2)
data$Sub_metering_3<-as.numeric(data$Sub_metering_3)

# subset the data for the dates 01/02/2007 and 02/02/2007
power<-subset(data,Date=="2007-02-01" | Date=="2007-02-02")

# plot Sub_metering vs DateTime
png("plot3.png", width=480, height=480)
with(power,plot(DateTime,Sub_metering_1,type = "l",xlab="Day", ylab="Energy Sub Metering"))
lines(power$DateTime,power$Sub_metering_2,type="l",col="red")
lines(power$DateTime,power$Sub_metering_3,type="l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,lwd=2,col=c("black","red","blue"))
dev.off()