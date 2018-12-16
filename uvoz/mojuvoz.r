#2. faza - uvoz podatkov

sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")

install.packages("tidyr")
library(readr)
library(tidyr)
library(reshape2)

sl <- locale(encoding = "Windows-1250")


#TABELA 1 - podatki o številu skenjenih zvez letno in povprečna starost pri vstopu v zakonsko zvezo
tabela1 <- read.csv2("podatki/poroke-st zvez-povprecna-starost-in-starost-ob-vstopu-v-1-zvezo.csv",
                    col.names=c("Leto","Sklenitve zakonskih zvez - Skupaj","Prve sklenitve zakonskih zvez ženina", "Prve sklenitve zakonskih zvez neveste","Povpre?na starost ?enina ob sklenitvi zakonske zveze","Povpre?na starost neveste ob sklenitvi zakonske zveze","Povpre?na starost ?enina ob sklenitvi prve zakonske zveze","Povpre?na starost neveste ob prvi sklenitvi zakonske zveze"),
                    skip = 2,dec = ".")
          

#zakaj mi naredi pikice namesto presledkov v col.names


          
#TABELA 2 - podatki o porokah po starostnih skupinah
tabela2 <- read.csv2("podatki/poroceni-starost.csv", skip=5, header = TRUE, dec = ".")
                     #fill = TRUE, blank.lines.skip = TRUE)

#kako se znebim X pred številkami in kako poimenujem prvi stolpec <- leto



#TABELA 3 - podatki o razvezah
tabela3 <- read.csv2("podatki/razveze-z-otroci-ali-brezbrez-trajanje-zveze.csv", skip=2, header = TRUE, dec = ".")
                     


#TABELA 4 - podatki o porokah med istospolnimi partnerji
tabela4 <- read.csv2("podatki/zveze-sklenjene-med-istospolnimi-partnerji.csv", skip=2, header = TRUE)

#kako dobim šumnike, poznam samo locale = locale(encoding = "Windows-1250"), kar pa tukaj ne deluje



#TABELA 5 - razvezani po starostnih skupinah
tabela5 <- read.csv2("podatki/razvezani-starost.csv", header = TRUE, skip=2)


#TABELA 6 - vdoveli
tabela6 <- read.csv2("podatki/vdoveli.csv", header = TRUE, skip=6)






# #TABELA 2 - podatki o porokah po regijah - imam 12 tabel, za vsako regijo posebej - kako naj jih spravim v eno?

# gorenjska <- read.csv2("podatki/poroceni-gorenjska.csv", skip=2)
# goriska <- read.csv2("podatki/poroceni-goriska.csv", skip=2)
# jugovzhodna <- read.csv2("podatki/poroceni-jugovzhodnaslo.csv", skip=2)
# koroska <- read.csv2("podatki/poroceni-koroska.csv", skip=2)
# obala <- read.csv2("podatki/poroceni-obalnokraska.csv", skip=2)
# osrednja <- read.csv2("podatki/poroceni-osrednjeslovenska.csv", skip=2)
# podravska <- read.csv2("podatki/poroceni-podravska.csv", skip=2)
# pomurska <- read.csv2("podatki/poroceni-pomurska.csv", skip=2)
# posavska <- read.csv2("podatki/poroceni-posavska.csv", skip=2)
# primorska <- read.csv2("podatki/poroceni-primorska.csv", skip=2)
# savinjska <- read.csv2("podatki/poroceni-savinjska.csv", skip=2)
# zasavska <- read.csv2("podatki/poroceni-zasavska.csv", skip=2)

