library("survival")
library("survminer")
library("boot")
data("kidney")


bs.fun1 <- function(kidney_df){
  disease = cbind(with(kidney_df, model.matrix(~ disease + 0)))
  df = as.data.frame(disease)
  res.cox <- coxph(Surv(kidney_df$time, kidney_df$status) ~ kidney_df$age + kidney_df$sex + kidney_df$frail + df$diseasePKD + df$diseaseGN + df$diseaseAN )
  return(res.cox$coefficients["kidney$age"])
}

bs1 <- boot(data = kidney, statistic=bs.fun1, R=2000)
bs.ci1 <- boot.ci(bs1, conf=c(0.9))

print(bs.ci1$normal)
print(bs.ci1$basic)
print(bs.ci1$percentl)
print(bs.ci1$bca)