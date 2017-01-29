#load the data into R.
#PM2.5 Emissions Data (𝚜𝚞𝚖𝚖𝚊𝚛𝚢𝚂𝙲𝙲_𝙿𝙼𝟸𝟻.𝚛𝚍𝚜): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. 
library("ggplot2", lib.loc="/Library/Frameworks/R.framework/Versions/3.3/Resources/library")

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

#subset of Baltimore data
Baltimore_data<-subset(NEI,fips=="24510")

#the year to check
yeartable<- table(Baltimore_data$year)
year<-as.numeric(names(yeartable))

#the type to check
typetable<-table(Baltimore_data$type)
type<-names(typetable)

#build a new dataset to store the data used
temp_emissions<-c()
for (j in type){
    print(j)
    sub_type<-subset(Baltimore_data,type==j)
    for (i in year) {
        print(i)
        sub_year<-subset(sub_type,year==i)
        pm2.5<-sum (sub_year$Emissions)
        temp_emissions<-c(temp_emissions,pm2.5)
        print(temp_emissions)  
    }
}
mergedata<-data.frame(year=rep(year,times=4),type=rep(type,each=4),emissions=temp_emissions)

#make the plot to answer this question
png(filename = 'plot3.png', width = 480, height = 480, units='px')
g<-ggplot(mergedata, aes(year, emissions))
g + geom_point()+geom_smooth(method = "lm")+facet_grid(. ~ type)

# close device
dev.off()

#As the plot show, only "point" increased. "nonroad","nonpoint" and "onroad" decreased.  





