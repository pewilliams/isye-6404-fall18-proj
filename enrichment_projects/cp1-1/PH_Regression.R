
library("survival")
library("survminer")
data("kidney")

disease = cbind(with(kidney, model.matrix(~ disease + 0)))
df = as.data.frame(disease)
df_kidney = merge(kidney, df)

res.cox <- coxph(Surv(time, status) ~ age + sex + frail + diseasePKD + diseaseGN + diseaseAN , data = df_kidney)
summary(res.cox)

ggsurvplot(survfit(res.cox), palette = "#2E9FDF",ggtheme = theme_minimal(), data = df_kidney)