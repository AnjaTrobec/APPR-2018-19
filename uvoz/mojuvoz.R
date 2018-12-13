#2. faza
sl <- locale("sl", decimal_mark=".")

library(readr)
# tabela1 <- read_csv2("podatki/poroke-st zvez-povprecna-starost-in-starost-ob-vstopu-v-1-zvezo.csv", 
#                      col_names=c("Leto","Sklenitve zakonskih zvez - Skupaj","Prve sklenitve zakonskih zvez Å¾enina", "Prve sklenitve zakonskih zvez neveste","PovpreÄna starost Å¾enina ob sklenitvi zakonske zveze","PovpreÄna starost neveste ob sklenitvi zakonske zveze","PovpreÄna starost Å¾enina ob sklenitvi prve zakonske zveze","PovpreÄna starost neveste ob prvi sklenitvi zakonske zveze"), 
#                      na="-",skip=2,locale=locale(encoding="Windows-1250"))

tabela1 <- read.csv2("podatki/poroke-st zvez-povprecna-starost-in-starost-ob-vstopu-v-1-zvezo.csv",
                    col.names=c("Leto","Sklenitve zakonskih zvez - Skupaj","Prve sklenitve zakonskih zvez ženina", "Prve sklenitve zakonskih zvez neveste","Povpreèna starost ženina ob sklenitvi zakonske zveze","Povpreèna starost neveste ob sklenitvi zakonske zveze","Povpreèna starost ženina ob sklenitvi prve zakonske zveze","Povpreèna starost neveste ob prvi sklenitvi zakonske zveze"),
                    skip = 2,dec = ".")
                    


tabela2 <- read.csv2("podatki/poroceni-regije-spol-starostna-skupina.csv", dec = ".")
