
library(ggplot2)
library(dplyr)
library(plotrix)
library(plotly)

source("uvoz/mojuvoz.R")


#1. POVPREČNA STAROST PRI VSTOPU V ZAKONSKO ZVEZO
# starost <- ggplot(tabela1A %>% filter(spremenljivka %in% c("Povrecna.starost.zenina", "Povrecna.starost.neveste")),
#                   aes(x= Leto, y = c("Povrecna.starost.zenina", "Povrecna.starost.neveste"), color = spremenljivka)) + geom_line()

#==================================================================================================================================================
#2. POROKE PO REGIJAH

#ZEMLJEVID - 1. poskus - ne dela :(
source('lib/uvozi.zemljevid.r')

Slovenija <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
                             "SVN_adm1") %>% fortify()

ggplot(Slovenija, aes(x=long, y=lat, group=group, fill=NAME_1)) +
  geom_polygon() +
  labs(title="Slovenija - brez podatkov") +
  theme(legend.position="none")


#==================================================================================================================
#ZEMLJEVID - 2. poskus - ne dela
library(sp)
library(maptools)
library(digest)
gpclibPermit()
source('lib/uvozi.zemljevid.r')

zemljevid <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
                             "SVN_adm1", encoding = "") %>% pretvori.zemljevid()


levels(zemljevid$NAME_1)[levels(zemljevid$NAME_1) %in%
                           c("Notranjsko-kraška","Spodnjeposavska", "Koroška", "Goriška", "Obalno-kraška")] <- c("Primorsko-notranjska", "Posavska", "Koroska", "Goriska", "Obalno-kraska")

poroke <- poroceni[, names(poroceni), drop = F] 


zemljevid.poroke <- ggplot() + geom_polygon(data = poroke %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill = poroke)) +
               xlab("") + ylab("") + ggtitle("Število porok po slovenskih regijah")


zemljevid.poroke + scale_fill_gradient(low = "#132B43", high = "#56B1F7", space = "Lab",
                                       na.value = "grey50", guide = "colourbar")

#==================================================================================================================================================
#3.TRAJANJE ZAKONSKE ZVEZE DO RAZVEZE

#TRAJANJE ZAKONSKE ZVEZE (ČRTNI DIAGRAM - KAKO ODSTRANIM RAZVEZE Z OTROKI IN BREZ?)
trajanje <- ggplot(tabela3 %>% filter(spremenljivka %in% c("Manj.kot.1.leto", "Od.1-4.leta", "Od.5-9.let", "Od.10-14.let", "15.ali.vec")),
  aes(x = leto, y = vrednost, color = spremenljivka)) + geom_line() + xlab("Leto") + ylab("Število") 
  scale_color_discrete(name = "Trajanje zakonske zveze",
                       breaks = c("Trajanje zakonske zveze manj kot 1 leto", "Trajanje zakonske zveze 1-4 leta","Trajanje zakonske zveze 5-9 let","Trajanje zakonske zveze 10-14 let", "Trajanje zakonske zveze 15 let ali vec"),
                       labels = c("Pod 1 leto", "1-4 leta", "5-9 let", "10-14 let", "15 let ali več"))
print(trajanje)


#TRAJANJE ZAKONSKE ZVEZE TORTNI DIAGRAM 
trajanje.zveze <- tabela3 %>%  filter(spremenljivka %in% c("Manj.kot.1.leto", "Od.1-4.leta", "Od.5-9.let", "Od.10-14.let", "15.ali.vec")) 

trajanje.z <- tabela3 %>% group_by(spremenljivka) %>% summarise(sestevek=(sum(vrednost)/27))
trajanje.z <- head(trajanje.z, -2)
trajanje.z <- ggplot(trajanje.z, aes(x = spremenljivka, y = sestevek, fill = spremenljivka))+
  geom_bar(width = 1, stat = "identity")
graf <- trajanje.z + coord_polar("y", start=0)
print(graf)
#ZELO JE GRD, ZIHR JE KKŠNA LEPŠA MOŽNOST

#==================================================================================================================================================
#4. PRIMERJAVA ŠTEVILA ISTOSPOLNIH POROK MED ŽENSKAMI IN MED MOŠKIMI V LETIH 2007 - 2017

istospolne <- ggplot(data=tabela4, aes(x=leto, y=stevilo, fill=spol)) +
  geom_bar(stat="identity", position=position_dodge()) + ggtitle("Istospolne poroke")

print(istospolne)

#==================================================================================================================================================
#5. STAROST PRI RAZVEZI

starost <- ggplot(data=tabela5, aes(x=Leto, y=Stevilo, fill=starost.pri.razvezi)) +
  geom_bar(stat="identity", position=position_dodge()) + ggtitle("Starost pri razvezi")
print(starost)

#==================================================================================================================================================
#6. razveze z otroki in brez otrok, graf po letih
otroki <- ggplot(tabela3 %>% filter(spremenljivka %in% c("Razveze.z.otroki", "Razveze.brez.otrok")),
  aes(x = leto, y = vrednost, color = spremenljivka)) + geom_line() +
  xlab("Leto") + ylab("Število") + ggtitle("Razveze z otroki ali brez njih") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
  scale_color_discrete(name = "Legenda",
                       breaks = c("Razveze.z.otroki",
                                  "Razveze.brez.otrok"),
                       labels = c("Razveze.z.otroki", "Razveze.brez.otrok"))

print(otroki)
#==================================================================================================================================================