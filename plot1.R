df <- read.csv('~/Downloads/household_power_consumption.txt',header=TRUE,sep=";",as.is=TRUE)
df$Date <- as.Date(df$Date, format="%d/%m/%Y") 
df$Global_active_power <- as.numeric(df$Global_active_power)
library(dplyr)
data <- df %>% filter(Date >= as.Date('2007-02-01',format="%Y-%m-%d") & as.Date(Date) <= as.Date('2007-02-02', format="%Y-%m-%d"))
library(ggplot2)
ggplot(data, aes(x=Global_active_power)) + 
  geom_histogram(binwidth=0.5,fill="red") + 
  xlab("Global Active Power (kilowatts)") +
  ylab("Frequency") + theme_classic() +
  ggtitle("Global Active Power")
ggsave(filename="/tmp/plot1.png", width=4.8, height=4.8, units="in",dpi=100)
