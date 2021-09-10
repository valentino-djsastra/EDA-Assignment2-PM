# Load NEI & SCC RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset data for Maryland
NEI_baltimore <- subset(NEI, fips == "24510")

# Aggregate using sum the Baltimore emissions data by year
aggTotBaltimore <- aggregate(Emissions ~ year, NEI_baltimore, sum)

#Plot the data
png("plot3.png",width=640,height=640,units="px",bg="transparent")

library(ggplot2)

g <- ggplot(NEI_baltimore, aes(factor(year), Emissions, fill = type)) + 
      geom_bar(stat="identity") +
      theme_bw() + guides(fill = FALSE) +
      facet_grid(.~type, scales = "free",space = "free") + 
      labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
      labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

print(g)

dev.off()