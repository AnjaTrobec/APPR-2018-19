#2. faza - uvoz podatkov

sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")

install.packages("tidyr")
install.packages("readr")
install.packages("dplyr")
library(readr)
library(tidyr)
library(reshape2)
library(dplyr)

sl <- locale(encoding = "Windows-1250")


#TABELA 1 - podatki o številu skenjenih zvez letno in povprečna starost pri vstopu v zakonsko zvezo
tabela1 <- read.csv2("podatki/poroke-st zvez-povprecna-starost-in-starost-ob-vstopu-v-1-zvezo.csv", skip = 2,dec = ".")
colnames(tabela1) <- c("Leto","Stevilo.sklenjenih.zakonskih.zvez","Prve.sklenitve.zakonskih.zvez.zenina", "Prve.sklenitve.zakonskih.zvez.neveste","Povprecna.starost.zenina","Povprecna.starost.neveste","Povprecna.starost.zenina.prva.zveza","Povprecna.starost.neveste.prva.zveza")


#TABELA 2 IZBOLJŠANA - podatki o porokah po regijah - imam 12 tabel, za vsako regijo posebej - kako naj jih spravim v eno?

poroceni.koroska <- read_csv2("podatki/poroceni-koroska.csv", skip=4, col_names = c("starostni.tip", paste0("", 2011:2018)), locale = locale(decimal_mark = ",", grouping_mark = "."))
poroceni.koroska$regija <- c("Koroška")
poroceni.gorenjska <- read_csv2("podatki/poroceni-gorenjska.csv", skip=5, col_names = c("starostni.tip", paste0("", 2011:2018)), locale = locale(decimal_mark = ",", grouping_mark = "."))
poroceni.gorenjska$regija <- c("Gorenjska")
poroceni.primorska <- read_csv2("podatki/poroceni-primorska.csv", skip=4, col_names = c("starostni.tip", paste0("", 2011:2018)), locale = locale(decimal_mark = ",", grouping_mark = "."))
poroceni.primorska$regija <- c("Primorska")
poroceni.zasavska <- read_csv2("podatki/poroceni-zasavska.csv",skip=4, col_names = c("starostni.tip", paste0("", 2011:2018)), locale = locale(decimal_mark = ",", grouping_mark = "."))
poroceni.zasavska$regija <- c("Zasavska")
poroceni.savinjska <- read_csv2("podatki/poroceni-savinjska.csv", skip=4, col_names = c("starostni.tip", paste0("", 2011:2018)), locale = locale(decimal_mark = ",", grouping_mark = "."))
poroceni.savinjska$regija <- c("Savinjska")
poroceni.posavska <- read_csv2("podatki/poroceni-posavska.csv", skip=4, col_names = c("starostni.tip", paste0("", 2011:2018)), locale = locale(decimal_mark = ",", grouping_mark = "."))
poroceni.posavska$regija <- c("Posavska")
poroceni.pomurska <- read_csv2("podatki/poroceni-pomurska.csv", skip=4, col_names = c("starostni.tip", paste0("", 2011:2018)), locale = locale(decimal_mark = ",", grouping_mark = "."))
poroceni.pomurska$regija <- c("Pomurska")
poroceni.podravska <- read_csv2("podatki/poroceni-podravska.csv", skip=4, col_names = c("starostni.tip", paste0("", 2011:2018)), locale = locale(decimal_mark = ",", grouping_mark = "."))
poroceni.podravska$regija <- c("Podravska")
poroceni.osrednja <- read_csv2("podatki/poroceni-osrednjeslovenska.csv", skip=5, col_names = c("starostni.tip", paste0("", 2011:2018)), locale = locale(decimal_mark = ",", grouping_mark = "."))
poroceni.osrednja$regija <- c("Osrednja Slovenija")
poroceni.obala <- read_csv2("podatki/poroceni-obalnokraska.csv", skip=5, col_names = c("starostni.tip", paste0("", 2011:2018)), locale = locale(decimal_mark = ",", grouping_mark = "."))
poroceni.obala$regija <- c("Obalno-kraška")
poroceni.jugovzhodna <- read_csv2("podatki/poroceni-jugovzhodnaslo.csv", skip=5, col_names = c("starostni.tip", paste0("", 2011:2018)), locale = locale(decimal_mark = ",", grouping_mark = "."))
poroceni.jugovzhodna$regija <- c("Jugovzhodna Slovenija")
poroceni.goriska <- read_csv2("podatki/poroceni-goriska.csv",  skip=5, col_names = c("starostni.tip", paste0("", 2011:2018)), locale = locale(decimal_mark = ",", grouping_mark = "."))
poroceni.goriska$regija <- c("Goriška")
poroceni <- rbind(poroceni.koroska, poroceni.gorenjska, poroceni.primorska, poroceni.zasavska, poroceni.savinjska, poroceni.pomurska, poroceni.posavska,
                  poroceni.osrednja, poroceni.goriska, poroceni.obala, poroceni.jugovzhodna, poroceni.podravska) %>%
  
  melt(id.vars=c("regija", "starostni.tip"), variable.name="leto", value.name = "stevilo")
          

#TABELA 3 - podatki o razvezah
tabela3 <- read.csv2("podatki/razveze-z-otroci-ali-brezbrez-trajanje-zveze.csv", skip=3, dec = ".") 
colnames(tabela3) <- c("Leto","Manj.kot.1.leto","Od.1-4.leta","Od.5-9.let", "Od.10-14.let", "15.ali.vec","Razveze.z.otroki","Razveze.brez.otrok")
                     


#TABELA 4 - podatki o porokah med istospolnimi partnerji
tabela4 <- read.csv2("podatki/zveze-sklenjene-med-istospolnimi-partnerji.csv", skip=3)
colnames(tabela4) <- c("Leto", "Med moskima", "Med zenskama")


#TABELA 5 - razvezani po starostnih skupinah
tabela5 <- read_csv2("podatki/razvezani-starost.csv", skip=3, col_names = c("Leto", paste0("", 2011:2018)),  locale = locale(decimal_mark = ",", grouping_mark = ".")) %>% 
                      melt(id.vars = "Starost pri razvezi", variable.name = "leto", value.name = "stevilo")



#TABELA 6 - vdoveli
tabela6 <- read_csv2("podatki/vdoveli.csv", skip=6, col_names = c("starostni.tip", paste0("", 2011:2018)), locale = locale(decimal_mark = ",", grouping_mark = ".")) %>%
    melt(id.vars = "Starostni tip", variable.name = "leto", value.name = "stevilo")









