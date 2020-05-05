# Has the number of emissions decreased over the years?

# Read the data in your working directory
NEI <- readRDS("summarySCC_PM25.rds")

# First, sum the emissions for each year
em1999 <- sum(NEI$Emissions[(NEI$year == 1999)])
em2002 <- sum(NEI$Emissions[(NEI$year == 2002)])
em2005 <- sum(NEI$Emissions[(NEI$year == 2005)])
em2008 <- sum(NEI$Emissions[(NEI$year == 2008)])
# Add them in a data frame with its respective year to plot them 
totalEM <- data.frame(emissions = c(em1999, em2002, em2005, em2008), year = c(1999, 2002, 2005, 2008))
# Sccatterplot
plot(totalEM$year, totalEM$emissions, xlab = "Year", ylab = "Total number of emissions", pch = 19, main = "Evolution of emissions from 1999 to 2008")
# Adding a linear regression line to show the trend
fit <- glm(totalEM$emissions~totalEM$year)
co <- coef(fit)
abline(fit, col="blue", lwd=2)
# Make a copy of your plot in PNG
dev.copy(png, file = "plot1.png")
dev.off()