# Read the data in your working directory
NEI <- readRDS("summarySCC_PM25.rds")

# Change in emissions by type in Baltimore using ggplot2
library(ggplot2)
library(dplyr)
# Prepare the graphics device to export since we have to change its dimensions
png(filename="plot3.png", width=1200, height=900)
# Create the data frame 
myfips = NEI$fips == "24510"
# We group it by year and type of emission
baltimore <- data.frame(Emissions = NEI$Emissions[myfips], year = NEI$year[myfips], type = NEI$type[myfips] )
baltimore <-  baltimore %>% group_by(type, year) %>% summarise(Emissions = sum(Emissions))
# Plot
qplot(year, Emissions, data = baltimore, facets = .~type, geom = c("point", "smooth"), se = FALSE, method = "lm")

dev.off() 