table<- read.table("household_power_consumption.txt", header=TRUE, sep = ";", na.strings  ="?", colClasses= c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

table$Date<- as.Date(table$Date, "%d/%m/%Y")

table<- subset(table,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
table<- table[complete.cases(table),]

dateTime<- paste(table$Date, table$Time)
dateTime<- setNames(dateTime, "DateTime")

table<- table[, !(names(table) %in% c("Date","Time"))]
table<- cbind(dateTime, table)
table$dateTime<- as.POSIXct(dateTime)

with(table,{
  plot(Sub_metering_1~dateTime, type="l", ylab = "Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime, col="red")
  lines(Sub_metering_3~dateTime, col="blue")
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, "plot3.png", height=480, width=480)
dev.off()
