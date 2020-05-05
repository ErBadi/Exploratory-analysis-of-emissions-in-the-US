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
newMergedDT <- newMergedDT %>% filter(fips == "24510" & grepl("[Vv]ehicle", newMergedDT$EI.Sector)) %>% group_by(year) %>% summarise(Emissions = sum(Emissions))
# Plot
qplot(year, Emissions, data = newMergedDT, geom = c("point", "smooth"), se = FALSE, method = "lm")
dev.copy(png, file = "plot5.png")
dev.off()