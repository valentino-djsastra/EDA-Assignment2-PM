# Load NEI & SCC RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset data for Maryland
NEI_baltimore <- subset(NEI, fips == "24510")

# Aggregate using sum the Baltimore emissions data by year
aggTotBaltimore <- aggregate(Emissions ~ year, NEI_baltimore, sum)

#Plot the data
png("plot2.png",width=640,height=640,units="px",bg="transparent")

barplot((aggTotBaltimore$Emissions), names.arg=aggTotBaltimore$year, xlab="Year",
        ylab="PM2.5 Emissions (in tonnes)",
        main="Total PM2.5 Emissions From Baltimore", ylim = c(0, 6000)
)

dev.off()