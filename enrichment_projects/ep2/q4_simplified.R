library(np)
library(survival)
library(reshape2)
hdat <- read.csv('data/heart_transplant.csv',header=T,stringsAsFactors=F)

km_fit <- survfit(Surv(time = Days, event = Status) ~ 1, data = hdat, 
                  type = 'kaplan-meier') #only one group of patients
km_dat <- data.frame(time=km_fit$time,
                     survival=km_fit$surv,
                     upper_ci = km_fit$upper, 
                     lower_ci = km_fit$lower) #model results
melted_km_dat <- melt(km_dat, id.vars = c('time')) #transform for viz

#Finding the Standard Error and survival
s_error = summary(km_fit)$std.err

#Calculate pointwise CI
CI_lower = km_fit$surv - 1.645*km_fit$std.err
CI_upper = km_fit$surv + 1.645*km_fit$std.err

km_dat1 <- data.frame(time=km_fit$time,
                      survival=km_fit$surv,
                      upper_ci = CI_upper, 
                      lower_ci = CI_lower)

melted_km_dat1 <- melt(km_dat1, id.vars = c('time'))

# Table for 1st version of CI


#ggplot(aes(x=time,y=value, color = variable ,group = variable), data=melted_km_dat1) +
#  geom_step(size = 1.25) + theme_bw() + xlab('Time (days)') + 
#  ylab('Survival Function') + 
#  ggtitle('90% CI using the standard error') + 
#  labs(color='Curve')

############Function for bootstrapping Estimates for the Median 
km_est_boot <- function(data, indices){
  bs_dat <- data[indices,]
  km_fitbs <- survfit(Surv(time = Days, event = Status) ~ 1, data = bs_dat, 
                      type = 'kaplan-meier') #only one group of patients
  km_datbs <- data.frame(time=km_fitbs$time,
                         survival=km_fitbs$surv) #model results
  return(median(km_datbs$time))
  ### INCOMPLETE
}
library(boot)
B <- 1e04
bs_CI <- boot(hdat, km_est_boot, R=B,parallel = 'multicore',
              ncpus = 10)
#plot(bs_CI)
bs_df <- data.frame(
  median_estimate = bs_CI$t
)


#bca_res <- boot.ci(boot.out = bs_CI,type = 'bca')

# Standard error of Bootstrap samples of Median
se <- sd(bs_CI$t)

#Bias calculation (Mean of bootstrap estimates - Median of KM estimator)
bias <- mean(bs_CI$t) - median(km_dat$time)


