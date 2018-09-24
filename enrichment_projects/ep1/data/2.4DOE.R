df = read.csv('enrichment_projects/ep1/data/Friedman.csv')
df = df[,!names(df) %in% c("Patient")]    # Removing extra Varialbe

r = c(t(as.matrix(df))) # response data 

f1 = c("Treatment.1", "Treatment.2", "Treatment.3")
f2 = c("1", "2","3","4","5","6","7","8","9","10","11","12")
k1 = length(f1)
#k2 = length(f2)
n = 12

tm1 = gl(k1, 1, n*k1, factor(f1))
#tm2 = gl(k2, n*k1, n*k1*k2, factor(f2)) 

av = aov(r ~ tm1 )