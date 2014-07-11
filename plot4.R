dataframe <- read.csv('~/Downloads/household_power_consumption.txt',header=TRUE,sep=";",as.is=TRUE)
dataframe$Date2 <- as.Date(dataframe$Date, format="%d/%m/%Y")

library(dplyr)
lowedge <- as.Date('2007-02-01', format="%Y-%m-%d")
highedge <- as.Date('2007-02-02', format="%Y-%m-%d")
df2 <- dataframe %>% 
  filter( Date2 >= lowedge & Date2 <= highedge)

df2$DateTime <- strptime(paste(df2$Date, df2$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
df2$Global_active_power <- as.numeric(df2$Global_active_power)
df2$Global_reactive_power <- as.numeric(df2$Global_reactive_power)
df2$Voltage <- as.numeric(df2$Voltage)
df2$Sub_metering_1 <- as.numeric(df2$Sub_metering_1)
df2$Sub_metering_2 <- as.numeric(df2$Sub_metering_2)
df2$Sub_metering_3 <- as.numeric(df2$Sub_metering_3)

library(ggplot2)
plot1 <- ggplot(df2, aes(x=DateTime, y=Global_active_power)) + 
  geom_line() + 
  ylab("Global Active Power (kilowatts)") + 
  theme_classic() +
  xlab("") +
  scale_x_datetime(breaks = "1 day")

plot2 <- ggplot(df2, aes(x=DateTime, y=Voltage)) + 
  geom_line() + 
  ylab("Voltage") + 
  theme_classic() +
  xlab("") +
  scale_x_datetime(breaks = "1 day")

plot3 <- ggplot(df2, aes(x=DateTime,color =  )) + 
  geom_line(aes(y = Sub_metering_1, color = "Sub_metering_1")) +  
  geom_line(aes(y = Sub_metering_2, color = "Sub_metering_2")) +  
  geom_line(aes(y = Sub_metering_3, color = "Sub_metering_3")) + 
  theme_classic() +
  xlab("") +
  ylab("Energy sub metering") +
  scale_x_datetime(breaks = "1 day") +
  theme(legend.position = c(0.85, 0.9))

plot4 <- ggplot(df2, aes(x=DateTime, y=Global_reactive_power)) + 
  geom_line() + 
  ylab("Global Reactive Power (kilowatts)") + 
  theme_classic() +
  xlab("") +
  scale_x_datetime(breaks = "1 day")

library(gridExtra)
png(filename="/tmp/plot4.png", width=480, height=480)
grid.arrange(plot1, plot2, plot3, plot4)
dev.off()
