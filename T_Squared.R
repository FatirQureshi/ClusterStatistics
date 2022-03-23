library("Hotelling")
library("readxl")
group_x <- read_excel("C:/Users/RPI/Documents/Qureshi Backup/MATLAB/MHahn/groupX.xlsx")
group_y <- read_excel("C:/Users/RPI/Documents/Qureshi Backup/MATLAB/MHahn/groupY.xlsx")

sta=hotelling.test(group_x, group_y, shrinkage = FALSE, var.equal = FALSE)

print(sta[["pval"]])
if (sta[["pval"]]>0){
  write.csv(sta[["pval"]],"p_value_statR.csv",row.names = FALSE)
}else{
  write.csv(sta[["pval"]],"p_value_statR.csv",row.names = FALSE)
}
  