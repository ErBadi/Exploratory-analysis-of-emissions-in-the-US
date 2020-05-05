library(dplyr)
library(ggplot2)
# Read the data in your working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
# Emissions from motor vehicle in Baltimore

# Merge datasets and take only the columns needed
mergedDT <- merge(NEI, SCC, by = "SCC")
newMergedDT <- mergedDT[, c(2,4,6,9)]
# Apply our filters for the data we want
newMergedDT <- newMergedDT %>% filter(fips == "24510" | fips == "06037" & grepl("[Vv]ehicle", newMergedDT$EI.Sector)) %>% group_by(year, fips) %>% summarise(Emissions = sum(Emissions))
# Plot by color 
g <- ggplot(newMergedDT, aes(year, Emissions, color = fips))
g+geom_point()+geom_smooth(method = "lm", se = FALSE)+scale_color_manual(labels = c("Los Angeles", "Baltimore"), values = c("red2", "turquoise"))+labs(title = "Vehicle emissions evolution comparison")

dev.copy(png, file = "plot6.png")
dev.off()