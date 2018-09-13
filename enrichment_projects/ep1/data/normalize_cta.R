#transformations to make rider data normal
setwd('~/Projects/isye-6404-fall18-proj/enrichment_projects/ep1')
rider_data <- read.csv(
     'data/CTA_-_Ridership_-_Daily_Boarding_Totals.csv',
                          header = T,stringsAsFactors = F)
#normalize bus based on sd and mean
sr <- rider_data
sr$bus <- round(rnorm(nrow(sr), mean = mean(sr$bus), sd = sd(sr$bus)),digits = 0)
#regress both to retain some relationships
lmod <- lm(rail_boardings~bus, data = rider_data)

sr$rail_boardings <- round(predict(lmod, newdata = sr))
sr$rail_boardings <- sr$rail_boardings + round(rnorm(nrow(sr), mean = 0, sd = 170000) ,digits = 0)
with(sr, plot(bus, rail_boardings))
sr$total_rides <- NULL;

sr$total_rides <- sr$bus + sr$rail_boardings
write.csv(sr, file = 'data/CTA_Ridership_Normalized.csv',row.names=F)