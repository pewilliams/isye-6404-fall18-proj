my_data = read.csv('enrichment_projects/ep1/data/Friedman.csv')
my_data = my_data[,!names(my_data) %in% c("Patient")]    # Removing extra Varialbe
mymatrix = as.matrix(my_data2)
friedman.test(mymatrix2)