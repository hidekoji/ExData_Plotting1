dataframe <- read.csv('~/Downloads/household_power_consumption.txt',header=TRUE,sep=";",as.is=TRUE)
dataframe$Date2 <- as.Date(dataframe$Date, format="%d/%m/%Y")

library(dplyr)
lowedge <- as.Date('2007-02-01', format="%Y-%m-%d")
highedge <- as.Date('2007-02-02', format="%Y-%m-%d")
df2 <- dataframe %>% 
filter( Date2 >= lowedge & Date2 <= highedge)

df2$DateTime <- strptime(paste(df2$Date, df2$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
df2$Global_active_power <- as.numeric(df2$Global_active_power)

library(ggplot2)
ggplot(df2, aes(x=DateTime, y=Global_active_power)) + 
  geom_line() + 
  ylab("Global Active Power (kilowatts)") + 
  theme_classic() +
  xlab("") +
  scale_x_datetime(breaks = "1 day")
ggsave(filename="/tmp/plot2.png", width=4.8, height=4.8, units="in",dpi=100)
