#3. faza - VIZUALIZACIJA

library(ggplot2)
library(dplyr)
library(plotrix)
library(plotly)



#=========================================================================================================================================================================================
#1. POVPREČNA STAROST PRI VSTOPU V ZAKONSKO ZVEZO
povpr.starost <- ggplot(tabela1A %>% filter(Spremenljivka %in% c("Povprecna.starost.zenina", "Povprecna.starost.neveste")),
                  aes(x = Leto, y = Vrednost, color = Spremenljivka)) + geom_line() + ggtitle("Povprečna starost ob vstopu v zakonsko zvezo") + xlab("Leto") + ylab("Število porok") 


#=========================================================================================================================================================================================
#2. POROKE PO REGIJAH IN ZEMLJEVID

Slovenija <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
                             "SVN_adm1", encoding = "UTF-8") %>% fortify()

graf.slovenija <- ggplot(Slovenija, aes(x=long, y=lat, group=group, fill=NAME_1)) + geom_polygon() +
  labs(title="Slovenija po regijah") + theme(legend.position="none")

levels(Slovenija$NAME_1)[levels(Slovenija$NAME_1) %in%
                           c("Notranjsko-kraška", "Spodnjeposavska", "Koroška", "Goriška", "Obalno-kraška")] <- c("Primorska","Posavska", "Koroska", "Goriska", "Obalno-kraska")

poroke <- poroceni[, names(poroceni), drop = F]
povprecje <- poroke %>% group_by(regija) %>% summarise(poroke = mean(stevilo))

zemljevid <- ggplot() + geom_polygon(data = povprecje %>% right_join(Slovenija, by = c("regija" = "NAME_1")),
               aes(x = long, y = lat, group = group, fill = poroke)) + xlab("") + ylab("") +
               ggtitle("Število porok po slovenskih regijah")

zemljevid + scale_fill_gradient(low = "#132B43", high = "#56B1F7", space = "Lab",
                                       na.value = "grey50", guide = "colourbar")


#=========================================================================================================================================================================================
#3.TRAJANJE ZAKONSKE ZVEZE DO RAZVEZE

#TRAJANJE ZAKONSKE ZVEZE
trajanje <- ggplot(tabela3 %>% filter(Spremenljivka %in% c("Manj.kot.1.leto", "Od.1-4.leta", "Od.5-9.let", "Od.10-14.let", "15.ali.vec")),
  aes(x = Leto, y = Vrednost, color = Spremenljivka)) + geom_line() + ggtitle("Trajanje zakonske zveze do ločitve") + xlab("Leto") + ylab("Število") 
  scale_color_discrete(name = "Časovno trajanje",
                       breaks = c("Trajanje zakonske zveze manj kot 1 leto", "Trajanje zakonske zveze 1-4 leta","Trajanje zakonske zveze 5-9 let","Trajanje zakonske zveze 10-14 let", "Trajanje zakonske zveze 15 let ali vec"),
                       labels = c("Pod 1 leto", "1-4 leta", "5-9 let", "10-14 let", "15 let ali več"))



#TRAJANJE ZAKONSKE ZVEZE TORTNI DIAGRAM 
trajanje.zveze <- tabela3 %>%  filter(Spremenljivka %in% c("Manj.kot.1.leto", "Od.1-4.leta", "Od.5-9.let", "Od.10-14.let", "15.ali.vec")) 

trajanje.z <- tabela3 %>% group_by(Spremenljivka) %>% summarise(sestevek=(sum(Vrednost)/27))
trajanje.z <- head(trajanje.z, -2)
trajanje.z <- ggplot(trajanje.z, aes(x = factor(1), y = sestevek, fill = Spremenljivka)) + xlab("") + ylab("") +
  geom_bar(width = 1, stat = "identity")
trajanje.z <- trajanje.z + coord_polar("y", start=0)

#=========================================================================================================================================================================================
#4. PRIMERJAVA ŠTEVILA ISTOSPOLNIH POROK MED ŽENSKAMI IN MED MOŠKIMI V LETIH 2007 - 2017

istospolne <- ggplot(data=tabela4, aes(x=leto, y=stevilo, fill=spol)) +
  geom_bar(stat="identity", position=position_dodge()) + ggtitle("Istospolne poroke") + xlab("Leto") + ylab("Število") + labs(fill='Spol')

#=========================================================================================================================================================================================
#5. STAROST PRI RAZVEZI

starost <- ggplot(data=tabela5, aes(x=Leto, y=Stevilo, fill=starost.pri.razvezi)) +
  geom_bar(stat="identity") + ggtitle("Starost pri razvezi") + xlab("Leto") + ylab("Število") + labs(fill='Starost')


#=========================================================================================================================================================================================
#6. razveze z otroki in brez otrok, graf po letih
otroki <- ggplot(tabela3 %>% filter(Spremenljivka %in% c("Razveze.z.otroki", "Razveze.brez.otrok")),
  aes(x = Leto, y = Vrednost, color = Spremenljivka)) + geom_line() +
  xlab("Leto") + ylab("Število") + ggtitle("Razveze z otroki ali brez njih") + 
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
  scale_color_discrete(name = "Legenda",
                       breaks = c("Razveze.z.otroki",
                                  "Razveze.brez.otrok"),
                       labels = c("Razveze.z.otroki", "Razveze.brez.otrok"))


#=========================================================================================================================================================================================

