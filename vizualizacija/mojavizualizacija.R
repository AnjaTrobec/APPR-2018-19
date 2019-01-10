install.packages("ggplot2")
install.packages("dplyr")
library("ggplot2")
library(dplyr)
library(plotrix)
library(plotly)
source("uvoz/mojuvoz.R")

#1. narisala bom zemljevid, seštela po regijah skupaj poročene in obarvala po številu
poroceni2 <- head(poroceni, 15) 
ggplot(poroceni2, aes(x=starostni.tip, y=stevilo)) + geom_point()

poroceni %>% group_by(regija, leto) %>% summarise(sestevek=sum(stevilo))


#2. primerjava porok med ženskami in moškimi v letih 2007-2017
istospolne.poroke <- tabela4

p <- ggplot(data=istospolne.poroke, aes(x=Leto, y=value, fill=variable)) +
  geom_bar(stat="identity", position=position_dodge())


print(p)

#3. seštela bom po stolpcih in nardila tortni diagram, kako dolga je povprečna zveza
trajanje.zveze <- select(tabela3,"Leto","Manj.kot.1.leto","Od.1-4.leta","Od.5-9.let", "Od.10-14.let", "15.ali.vec")




# #ZEMLJEVID
# library(sp)
# library(maptools)
# library(digest)
# gpclibPermit()
# 
# zemljevid <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
#                              "SVN_adm1", encoding = "") %>% pretvori.zemljevid()
# 
# 
# levels(zemljevid$NAME_1)[levels(zemljevid$NAME_1) %in%
#                            c("Notranjsko-kraška",
#                              "Spodnjeposavska", "Koroška", "Goriška", "Obalno-kraška")] <- c("Primorsko-notranjska",
#                                                                                              "Posavska", "Koroska", "Goriska", "Obalno-kraska")

