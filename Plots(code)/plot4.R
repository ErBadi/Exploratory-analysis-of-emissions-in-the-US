library(ggplot2)
library(dplyr)
# Read the data in your working directory
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Have coal emissions decreased?

# Merge datasets and take only the columns needed
mergedDT <- merge(NEI, SCC, by = "SCC")
newMergedDT <- mergedDT[, c(4,6,9)]
# Select coal emissions
newMergedDT <- newMergedDT[grepl("[Cc]oal", newMergedDT$EI.Sector), ]
# Group by year
newMergedDT <- newMergedDT %>% group_by(year) %>% summarise(Emissions = sum(Emissions))
# Plot
qplot(year, Emissions, data = newMergedDT, geom = c("point", "smooth"), se = FALSE, method = "lm", main = "Evolution of coal emissions 1999-2008")
dev.copy(png, file = "plot4.png")
dev.off()