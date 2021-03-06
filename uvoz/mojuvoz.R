#2. faza - uvoz podatkov

sl <- locale("sl", decimal_mark = ",", grouping_mark = ".")

# install.packages("gsubfn")
# install.packages("dplyr")
# install.packages("colorspace")
library(colorspace)
library(gsubfn)
library(readr)
library(tidyr)
library(reshape2)
library(dplyr)

sl <- locale(encoding = "UTF-8")

#=========================================================================================================================================================================================================================================================================================
#TABELA 1 - podatki o številu skenjenih zvez letno in povprečna starost pri vstopu v zakonsko zvezo
tabela1 <- read.csv2("podatki/poroke-st zvez-povprecna-starost-in-starost-ob-vstopu-v-1-zvezo.csv", skip = 2,dec = ".")
colnames(tabela1) <- c("Leto","Stevilo.sklenjenih.zakonskih.zvez","Prve.sklenitve.zakonskih.zvez.zenina", "Prve.sklenitve.zakonskih.zvez.neveste","Povprecna.starost.zenina","Povprecna.starost.neveste","Povprecna.starost.zenina.prva.zveza","Povprecna.starost.neveste.prva.zveza")

tabela1A <- subset(tabela1, select = c("Leto","Stevilo.sklenjenih.zakonskih.zvez", "Povprecna.starost.zenina", "Povprecna.starost.neveste"))
tabela1A <- tabela1A %>% melt(value.name = "Vrednost", variable.name = "Spremenljivka", id.vars = 1)

#=========================================================================================================================================================================================================================================================================================
#TABELA 2 - podatki o porokah po regijah

poroceni.koroska <- read_csv2("podatki/poroceni-koroska.csv", skip=4, col_names = c("starostni.tip", paste0("", 2011:2018)), locale = locale(decimal_mark = ",", grouping_mark = "."))
poroceni.koroska$regija <- c("Koroska")
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
poroceni.osrednja$regija <- c("Osrednjeslovenska")
poroceni.obala <- read_csv2("podatki/poroceni-obalnokraska.csv", skip=5, col_names = c("starostni.tip", paste0("", 2011:2018)), locale = locale(decimal_mark = ",", grouping_mark = "."))
poroceni.obala$regija <- c("Obalno-kraska")
poroceni.jugovzhodna <- read_csv2("podatki/poroceni-jugovzhodnaslo.csv", skip=5, col_names = c("starostni.tip", paste0("", 2011:2018)), locale = locale(decimal_mark = ",", grouping_mark = "."))
poroceni.jugovzhodna$regija <- c("Jugovzhodna Slovenija")
poroceni.goriska <- read_csv2("podatki/poroceni-goriska.csv",  skip=5, col_names = c("starostni.tip", paste0("", 2011:2018)), locale = locale(decimal_mark = ",", grouping_mark = "."))
poroceni.goriska$regija <- c("Goriska")

poroceni <- rbind(poroceni.koroska, poroceni.gorenjska, poroceni.primorska, poroceni.zasavska, poroceni.savinjska, poroceni.pomurska, poroceni.posavska,
                  poroceni.osrednja, poroceni.goriska, poroceni.obala, poroceni.jugovzhodna, poroceni.podravska) %>% 
            melt(id.vars=c("regija", "starostni.tip"), variable.name="leto", value.name = "stevilo")
          

#=========================================================================================================================================================================================================================================================================================
#TABELA 3 - podatki o razvezah
tabela3 <- read.csv2("podatki/razveze-z-otroci-ali-brezbrez-trajanje-zveze.csv", skip=3, dec = ".") 
colnames(tabela3) <- c("Leto","Manj.kot.1.leto","Od.1-4.leta","Od.5-9.let", "Od.10-14.let", "15.ali.vec","Razveze.z.otroki","Razveze.brez.otrok")
tabela3 <- tabela3 %>% melt(value.name = "Vrednost", variable.name = "Spremenljivka", id.vars = 1)
colnames(tabela3)[1] <- "Leto"

#=========================================================================================================================================================================================================================================================================================
#TABELA 4 - podatki o porokah med istospolnimi partnerji
tabela4 <- read.csv2("podatki/zveze-sklenjene-med-istospolnimi-partnerji.csv", skip=3)
colnames(tabela4) <- c("Leto", "moski", "zenske") 
tabela4 <- tabela4 %>% melt(measure.vars=c("moski", "zenske"))
colnames(tabela4) <- c("leto", "spol", "stevilo")

#=========================================================================================================================================================================================================================================================================================
#TABELA 5 - razvezani po starostnih skupinah
tabela5 <- read_csv2("podatki/razvezani-starost.csv", skip=4, col_names = c("starost.pri.razvezi", paste0("", 2011:2018)),  locale = locale(decimal_mark = ",", grouping_mark = ".")) %>% 
                      melt(id.vars = "starost.pri.razvezi", variable.name = "Leto", value.name = "Stevilo")

tabela5$starost.pri.razvezi <- factor(tabela5$starost.pri.razvezi,
                                      levels=unique(tabela5$starost.pri.razvezi),
                                      ordered=TRUE)

#=========================================================================================================================================================================================================================================================================================
#TABELA 6 - vdoveli
tabela6 <- read_csv2("podatki/vdoveli.csv", skip=7, col_names = c("starostni.tip", paste0("", 2011:2018)), locale = locale(decimal_mark = ",", grouping_mark = ".")) %>%
                      melt(id.vars = "starostni.tip", variable.name = "leto", value.name = "stevilo")

#=========================================================================================================================================================================================================================================================================================


