dataframe <- read.csv('~/Downloads/household_power_consumption.txt',header=TRUE,sep=";",as.is=TRUE)
dataframe$Date2 <- as.Date(dataframe$Date, format="%d/%m/%Y")

library(dplyr)
lowedge <- as.Date('2007-02-01', format="%Y-%m-%d")
highedge <- as.Date('2007-02-02', format="%Y-%m-%d")
df2 <- dataframe %>% 
  filter( Date2 >= lowedge & Date2 <= highedge)

df2$DateTime <- strptime(paste(df2$Date, df2$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
df2$Sub_metering_1 <- as.numeric(df2$Sub_metering_1)
df2$Sub_metering_2 <- as.numeric(df2$Sub_metering_2)
df2$Sub_metering_3 <- as.numeric(df2$Sub_metering_3)

library(ggplot2)
ggplot(df2, aes(x=DateTime,color =  )) + 
  geom_line(aes(y = Sub_metering_1, color = "Sub_metering_1")) +  
  geom_line(aes(y = Sub_metering_2, color = "Sub_metering_2")) +  
  geom_line(aes(y = Sub_metering_3, color = "Sub_metering_3")) + 
  theme_classic() +
  xlab("") +
  ylab("Energy sub metering") +
  scale_x_datetime(breaks = "1 day") +
  theme(legend.position = c(0.85, 0.9))
ggsave(filename="/tmp/plot3.png", width=4.8, height=4.8, units="in",dpi=100)
