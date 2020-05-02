table<- read.table("household_power_consumption.txt", header=TRUE, sep = ";", na.strings  ="?", colClasses= c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

table$Date<- as.Date(table$Date, "%d/%m/%Y")

table<- subset(table,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
table<- table[complete.cases(table),]

dateTime<- paste(table$Date, table$Time)
dateTime<- setNames(dateTime, "DateTime")

table<- table[, !(names(table) %in% c("Date","Time"))]
table<- cbind(dateTime, table)
table$dateTime<- as.POSIXct(dateTime)

plot(table$Global_active_power~table$dateTime, type="l", ylab = "Global Active Power (kilowatts)", xlab="")

dev.copy(png, "plot2.png", width=480, height=480)
dev.off()