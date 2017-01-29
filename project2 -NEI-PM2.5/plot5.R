#load the data into R.
#PM2.5 Emissions Data (𝚜𝚞𝚖𝚖𝚊𝚛𝚢𝚂𝙲𝙲_𝙿𝙼𝟸𝟻.𝚛𝚍𝚜): This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008. For each year, the table contains number of tons of PM2.5 emitted from a specific type of source for the entire year. 
library(ggplot2)

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


#Source Classification Code Table (𝚂𝚘𝚞𝚛𝚌𝚎_𝙲𝚕𝚊𝚜𝚜𝚒𝚏𝚒𝚌𝚊𝚝𝚒𝚘𝚗_𝙲𝚘𝚍𝚎.𝚛𝚍𝚜): This table provides a mapping from the SCC digit strings in the Emissions table to the actual name of the PM2.5 source. The sources are categorized in a few different ways from more general to more specific and you may choose to explore whatever categories you think are most useful. For example, source “10100101” is known as “Ext Comb /Electric Gen /Anthracite Coal /Pulverized Coal”
SCC <- readRDS("Source_Classification_Code.rds")
names(SCC)
str(SCC)
head(SCC)

#filter the data according to "vehicles"
motorvehicledata<-grepl("vehicles", SCC$SCC.Level.Three, ignore.case=TRUE) 
filterSCC<-SCC[motorvehicledata,]$SCC

#filter the NEI according to "SCC" and "Baltimore"
filterNEI<-Baltimore_data[Baltimore_data$SCC %in% filterSCC,]

#make the plot, x=year, y= Emissions of Baltimore.
png(filename = 'plot5.png', width = 480, height = 480, units='px')
g<-ggplot(filterNEI,aes(factor(year),Emissions))
g+geom_bar(stat="identity",width=0.75)+ labs(x="year", y="Total pm2.5 emission (tons)",title="Motor vehicle related sources emissions in Baltimore from 1999-2008")

dev.off()

#As the plot shows, the emission decreased.



