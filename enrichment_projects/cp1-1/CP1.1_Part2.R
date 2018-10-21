library("survival")
library("survminer")
library("boot")
data("kidney")

# must pass indices argument so that bootstrap can randomly choose
# overly specified model tends to error out due to estimation error
# in this case only using age as a covariate - feel free to add others # with care

#bootstrap function
bs_fun <- function(data, indices){
	bs_dat <- data[indices,]
  	res.cox <- coxph(Surv(time, status) ~ age , data = bs_dat)
  	return(as.numeric(res.cox$coefficients["age"]))
}

bs_res <- boot(kidney, bs_fun, R=2000)
#plot(bs_res) #symmetric - can use percentile approach
# type options include: "norm", "basic", "perc", "stud"
bs_ci <- boot.ci(bs_res, conf = 0.95, var.t0 = NULL, type = 'perc')
