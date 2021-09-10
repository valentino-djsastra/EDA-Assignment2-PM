# Load NEI & SCC RDS
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset coal combustion from NEI data
combRel <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRel <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalComb <- (coalRel & combRel)
combSCC <- SCC[coalComb, ]$SCC
combNEI <- NEI[NEI$SCC %in% combSCC,]

# Generate the ggplot
png("plot4.png",width=640,height=640,units="px",bg="transparent")

library(ggplot2)

g <- ggplot(combNEI, aes(factor(year), Emissions/10^5)) +
      geom_bar(stat="identity",fill="grey",width=0.75) +
      theme_bw() +  guides(fill=FALSE) +
      labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
      labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

print(g)

dev.off()