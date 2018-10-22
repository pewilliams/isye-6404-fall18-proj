
library("survival")
library("survminer")
library("boot")
data("kidney")

disease = cbind(with(kidney, model.matrix(~ disease + 0)))
df = as.data.frame(disease)

res.cox <- coxph(Surv(kidney$time, kidney$status) ~ kidney$age + kidney$sex + kidney$frail + df$diseasePKD + df$diseaseGN + df$diseaseAN )
summary(res.cox)

ggsurvplot(survfit(res.cox), color = "#2E9FDF",ggtheme = theme_minimal(), data = kidney)