my_data = read.csv('enrichment_projects/ep1/data/Friedman.csv')
my_data = my_data[,!names(my_data) %in% c("Patient")]    # Removing extra Varialbe
mymatrix = as.matrix(my_data2)
result = friedman.test(t(mymatrix))
print(result)

S <- as.numeric(result$statistic)
b <- dim(t(mymatrix))[1];
k <- dim(t(mymatrix))[2];
F <- (b-1)*S/(b*(k-1)-S);
pF <- 1-pf(F,k-1,(b-1)*(k-1));

print(c(F,pF))
