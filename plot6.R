# Load NEI & SCC RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI data that is related to the vehicles
veh <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
vehSCC <- SCC[veh,]$SCC
vehNEI <- NEI[NEI$SCC %in% vehSCC,]

# Subset the vehicles NEI data that belongs to Baltimore & LA
vehNEIbalt <- vehNEI[vehNEI$fips=="24510",]
vehNEIbalt$city <- "Baltimore City"

vehNEILA <- vehNEI[vehNEI$fips=="06037",]
vehNEILA$city <- "Los Angeles County"

# Combine the two subsets with city name into one data frame
NEIbaltLA <- rbind(vehNEIbalt,vehNEILA)

png("plot6.png",width=640,height=640,units="px",bg="transparent")

library(ggplot2)

g <- ggplot(NEIbaltLA, aes(x=factor(year), y=Emissions, fill=city)) +
      geom_bar(aes(fill=year),stat="identity") +
      facet_grid(scales="free", space="free", .~city) +
      guides(fill=FALSE) + theme_bw() +
      labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
      labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

print(g)

dev.off()