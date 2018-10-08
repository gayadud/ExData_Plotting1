##set the working directory
setwd("C:/Users/vinip/Desktop/Gayatri/DATA SCIENTIST COURSE/Exploratory Data Analysis/Week-1/Project")

##download the zip file
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, "data.zip")

##unzip the downloaded fil,
Data <- unzip("data.zip")

##memory required
data_size <- object.size(Data)

##read dataset in R
data <- read.table("household_power_consumption.txt", header = TRUE, na.strings = "?", as.is = TRUE, sep = ";")

##specify column names
colnames(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

##subset the data where date = 01/02/2007 and 02/02/2007
data_specific_dates <- rbind(data[data$Date == "1/2/2007",], data[data$Date == "2/2/2007",])

##transform date format
data_specific_dates$Date <- as.Date(data_specific_dates$Date, "%d/%m/%y")

##combine date and time column to create a new column
data_specific_dates <- cbind(data_specific_dates, "datetime" = as.POSIXct(paste(data_specific_dates$Date, data_specific_dates$Time)))

##open graphic device png
png("plot3.png", width = 480, height = 480)

##create time-series plot3
plot(data_specific_dates$Sub_metering_1 ~ data_specific_dates$datetime, type = "l", col = "black", ylab = "Energy sub metering", xlab = "")
lines(data_specific_dates$Sub_metering_2 ~ data_specific_dates$datetime, type = "l", col = "red")
lines(data_specific_dates$Sub_metering_3 ~ data_specific_dates$datetime, type = "l", col = "blue")
legend("topright", lty=1, lwd =3, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

dev.off()