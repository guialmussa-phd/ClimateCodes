setwd("/Users/guial/Desktop/R_para_clima/")

library(RClimDex)
library(readxl)

arquivo_excel <- "/Users/guial/Desktop/R_para_clima/"

dados <- read_excel(Espirito_Santo_do_Pinhal, sheet = 1)

dados_selecionados <- Espirito_Santo_do_Pinhal[, 1:6]

arquivo_csv <- "Espirito_Santo_do_Pinhal_novo.csv"

write.csv(dados_selecionados, arquivo_csv, row.names = FALSE)

rclimdex.start()
