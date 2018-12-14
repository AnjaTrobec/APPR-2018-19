#2. faza - uvoz podatkov

sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")

library(readr)
# tabela1 <- read_csv2("podatki/poroke-st zvez-povprecna-starost-in-starost-ob-vstopu-v-1-zvezo.csv", 
#                      col_names=c("Leto","Sklenitve zakonskih zvez - Skupaj","Prve sklenitve zakonskih zvez ženina", "Prve sklenitve zakonskih zvez neveste","Povprečna starost ženina ob sklenitvi zakonske zveze","Povprečna starost neveste ob sklenitvi zakonske zveze","Povprečna starost ženina ob sklenitvi prve zakonske zveze","Povprečna starost neveste ob prvi sklenitvi zakonske zveze"), 
#                      na="-",skip=2,locale=locale(encoding="Windows-1250"))

#TABELA 1 - podatki o številu skenjenih zvez letno in povprečna starost pri vstopu v zakonsko zvezo
tabela1 <- read.csv2("podatki/poroke-st zvez-povprecna-starost-in-starost-ob-vstopu-v-1-zvezo.csv",
                    col.names=c("Leto","Sklenitve zakonskih zvez - Skupaj","Prve sklenitve zakonskih zvez ?enina", "Prve sklenitve zakonskih zvez neveste","Povpre?na starost ?enina ob sklenitvi zakonske zveze","Povpre?na starost neveste ob sklenitvi zakonske zveze","Povpre?na starost ?enina ob sklenitvi prve zakonske zveze","Povpre?na starost neveste ob prvi sklenitvi zakonske zveze"),
                    skip = 2,dec = ".")
                    
#TABELA 2 - podatki o porokah po regijah
gorenjska <- read.csv2("podatki/poroceni-gorenjska.csv", skip=2)
goriska <- read.csv2("podatki/poroceni-goriska.csv", skip=2)
jugovzhodna <- read.csv2("podatki/poroceni-jugovzhodnaslo.csv", skip=2)
koroska <- read.csv2("podatki/poroceni-koroska.csv", skip=2)
obala <- read.csv2("podatki/poroceni-obalnokraska.csv", skip=2)
osrednja <- read.csv2("podatki/poroceni-osrednjeslovenska.csv", skip=2)
podravska <- read.csv2("podatki/poroceni-podravska.csv", skip=2)
pomurska <- read.csv2("podatki/poroceni-pomurska.csv", skip=2)
posavska <- read.csv2("podatki/poroceni-posavska.csv", skip=2)
primorska <- read.csv2("podatki/poroceni-primorska.csv", skip=2)
savinjska <- read.csv2("podatki/poroceni-savinjska.csv", skip=2)
zasavska <- read.csv2("podatki/poroceni-zasavska.csv", skip=2)


#TABELA 3 - podatki o razvezah
tabela3 <- read.csv2("podatki/razveze-z-otroci-ali-brezbrez-trajanje-zveze.csv",
                     col.names=c("Leto","Trajanje zakonske zveze pod 1 leto","Trajanje zakonske zveze 1-4 leta","Trajanje zakonske zveze 5-9 let","Trajanje zakonske zveze 10-14 let","Trajanje zakonske zveze 15 let ali več","Razveze zakonskih zvez z otroki","Razveze zakonskih zvez brez otrok"), skip=2, dec = ".")


#TABELA 4 - podatki o porokah med istospolnimi partnerji
tabela4 <- read.csv2("podatki/zveze-sklenjene-med-istospolnimi-partnerji.csv",
                     col.names=c("Leto", "med moškima", "med ženskama"), skip=2)

#TABELA 5 - razvezani po starostnih skupinah
tabela5 <- read.csv2("podatki/razvezani-starost.csv",
                     col.names=c("Leto","2011","2012","2013","2014","2015","2016","2017","2018"), skip=2)

#TABELA 6 - vdoveli
tabela6 <- read.csv2("podatki/vdoveli.csv",
                     col.names=c("Leto","2011","2012","2013","2014","2015","2016","2017","2018"), skip=6)
