#load the data into R.
#PM2.5 Emissions Data (𝚜𝚞𝚖𝚖𝚊𝚛𝚢𝚂𝙲𝙲_𝙿𝙼𝟸𝟻.𝚛𝚍𝚜): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. 
NEI <- readRDS("summarySCC_PM25.rds")
names(NEI)
str(NEI)
head(NEI)
#𝚏𝚒𝚙𝚜: A five-digit number (represented as a string) indicating the U.S. county
#𝚂𝙲𝙲: The name of the source as indicated by a digit string (see source code classification table)
#𝙿𝚘𝚕𝚕𝚞𝚝𝚊𝚗𝚝: A string indicating the pollutant
#𝙴𝚖𝚒𝚜𝚜𝚒𝚘𝚗𝚜: Amount of PM2.5 emitted, in tons
#𝚝𝚢𝚙𝚎: The type of source (point, non-point, on-road, or non-road)
#𝚢𝚎𝚊𝚛: The year of emissions recorded

#get emissions of PM2.5 and years,all year store in "year"
yeartable<- table(NEI$year)
year<-as.numeric(names(yeartable))

#calculate and store the emission of each year
emission<-c()

for (i in year) {
    sub<-subset(NEI,year==i &fips=="24510")
    pm2.5<-sum(sub$Emissions)
    emission<-c(emission,pm2.5)
    print(emission)  }


#plot :x= year andy= emission
#open device
png(filename = 'plot2.png', width = 480, height = 480, units='px')
plot(x=year,y=emission, xlab="year", ylab="PM2.5(tons)",main="Total PM2.5 emission of Baltimore City for each of the years",xlim=c(year[1],year[length(year)]),ylim=c(min(emission),max(emission)),type="l")
# close device
dev.off()

#As the plot shows the emissions have decreased in the Baltimore City, though the emissions in 2005 rebounded. 


