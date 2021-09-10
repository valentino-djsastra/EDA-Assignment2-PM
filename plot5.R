# Load NEI & SCC RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI data that is related to the vehicles
veh <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehSCC <- SCC[veh,]$SCC
vehNEI <- NEI[NEI$SCC %in% vehSCC,]

# Subset the vehicles NEI data that belongs to Baltimore 
vehNEIbalt <- vehNEI[vehNEI$fips=="24510",]

png("plot5.png",width=640,height=640,units="px",bg="transparent")

library(ggplot2)

g <- ggplot(vehNEIbalt, aes(factor(year), Emissions)) +
      geom_bar(stat="identity", fill="grey", width=0.75) +
      theme_bw() +  guides(fill=FALSE) +
      labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
      labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

print(g)

dev.off()