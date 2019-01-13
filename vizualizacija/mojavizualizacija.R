install.packages("ggplot2")
install.packages("dplyr")
install.packages("plotrix")
install.packages("plotly")
library(ggplot2)
library(dplyr)
library(plotrix)
library(plotly)

source("uvoz/mojuvoz.R")



#1. primerjava porok med ženskami in moškimi v letih 2007-2017
istospolne.poroke <- tabela4

p <- ggplot(data=istospolne.poroke, aes(x=Leto, y=value, fill=variable)) +
  geom_bar(stat="identity", position=position_dodge())

print(p)



#2. seštela bom po stolpcih in nardila tortni diagram, kako dolga je povprečna zveza
#torej za vsak stolpec bom seštela vse številke in delila s številom let - dobila bom povprečje

#TRAJANJE ZAKONSKE ZVEZE (ČRTNI DIAGRAM)
trajanje <- ggplot(otroci %>% filter(spremenljivka %in% c("Manj.kot.1.leto", "Od.1-4.leta", "Od.5-9.let", "Od.10-14.let", "15.ali.vec")),
  aes(x = leto, y = vrednost, color = spremenljivka)) + geom_line() + xlab("Leto") + ylab("Število") 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
  scale_color_discrete(name = "Trajanje zakonske zveze",
                       breaks = c("Manj.kot.1.leto", "Trajanje zakonske zveze 1-4 leta","Trajanje zakonske zveze 5-9 let","Trajanje zakonske zveze 10-14 let", "Trajanje zakonske zveze 15 let ali vec"),
                       labels = c("Pod 1 leto", "1-4 leta", "5-9 let", "10-14 let", "15 let ali več"))

#TRAJANJE ZAKONSKE ZVEZE TORTNI DIAGRAM
trajanje.zveze <- otroci %>%  filter(spremenljivka %in% c("Manj.kot.1.leto", "Od.1-4.leta", "Od.5-9.let", "Od.10-14.let", "15.ali.vec")) 

trajanje.z <- otroci %>% group_by(spremenljivka) %>% summarise(sestevek=sum(vrednost))
trajanje <- ggplot(trajanje.z, aes(x= spremenljivka, y=sestevek, fill=spremenljivka))+
  geom_bar(width = 1, stat = "identity")
graf <- trajanje + coord_polar("y", start=0)
#treba je popraviti ena velika katastrofa je nastala


#3. narisala bom zemljevid, seštela po regijah skupaj poročene in obarvala po številu
# poroceni2 <- head(poroceni, 15) 
# ggplot(poroceni2, aes(x=starostni.tip, y=stevilo)) + geom_point()

poroceni %>% group_by(regija, leto) %>% summarise(sestevek=sum(stevilo))
poroceni <- poroceni %>% group_by(regija) %>% summarise(sestevek=(sum(stevilo)/8))



# #ZEMLJEVID
install.packages("maptools")
library(sp)
library(maptools)
library(digest)
gpclibPermit()

zemljevid <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
                             "SVN_adm1", encoding = "") %>% pretvori.zemljevid()


levels(zemljevid$NAME_1)[levels(zemljevid$NAME_1) %in%
                           c("Notranjsko-kraška",
                             "Spodnjeposavska", "Koroška", "Goriška", "Obalno-kraška")] <- c("Primorsko-notranjska",
                                                                                             "Posavska", "Koroska", "Goriska", "Obalno-kraska")


poroke <- poroceni[, names(poroceni), drop = F] 

povprecje <- poroke %>% group_by(regija) %>% summarise(poroke = mean(stevilo))

zemljevid.poroke <- ggplot() +
  geom_polygon(data = povprecje %>% right_join(zemljevid, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill = poroke))+
  xlab("") + ylab("") + ggtitle("Število porok po slovenskih regijah")

zemljevid.poroke + scale_fill_gradient(low='green', high='red')

zemljevid.poroke + scale_fill_gradient(low = "#132B43", high = "#56B1F7", space = "Lab",
                                       na.value = "grey50", guide = "colourbar")





#4. razveze z otroki in brez otrok, graf po letih
otroki <- ggplot(otroci %>% filter(spremenljivka %in% c("Razveze.z.otroki", "Razveze.brez.otrok")),
  aes(x = Leto, y = vrednost, color = spremenljivka)) + geom_line() +
  xlab("Leto") + ylab("Število") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
  scale_color_discrete(name = "Legenda",
                       breaks = c("Razveze.z.otroki",
                                  "Razveze.brez.otrok"),
                       labels = c("Razveze.z.otroki", "Razveze.brez.otrok"))
