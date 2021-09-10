# Load NEI & SCC RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Determine the aggregate sum of the total emissions by year
aggTot <- aggregate(Emissions ~ year, NEI, sum)

#Plot the data
png("plot1.png",width=640,height=640,units="px",bg="transparent")

barplot((aggTot$Emissions), names.arg=aggTot$year, xlab="Year", 
        ylab="PM2.5 Emissions (in tonnes)",
        main="Total PM2.5 Emissions From All US Sources"
)

dev.off()
