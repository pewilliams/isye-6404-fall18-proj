
library("survival")
data("kidney")

disease = cbind(with(kidney, model.matrix(~ disease + 0)))
df = as.data.frame(disease)

res.cox <- coxph(Surv(kidney$time, kidney$status) ~ kidney$age + kidney$sex + kidney$frail + df$diseaseOther + df$diseaseGN + df$diseaseAN )