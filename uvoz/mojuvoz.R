#2. faza
sl <- locale("sl", decimal_mark=",", grouping_mark=".")

library(readr)
tabela1 <- read_csv2("poroke - št zvez, povprečna starost in starost ob vstopu v 1. zvezo.csv", 
                     col_names=c("Sklenitve zakonskih zvez - Skupaj","Prve sklenitve zakonskih zvez ženina", "Prve sklenitve zakonskih zvez neveste","Povprečna starost ženina ob sklenitvi zakonske zveze","Povprečna starost neveste ob sklenitvi zakonske zveze","Povprečna starost ženina ob sklenitvi prve zakonske zveze","Povprečna starost neveste ob prvi sklenitvi zakonske zveze"),
                     locale=locale(encoding="Windows-1250"))
