
library(ggplot2)
library(dplyr)
library(plotrix)
library(plotly)

source("uvoz/mojuvoz.R")


#1. POVPREČNA STAROST PRI VSTOPU V ZAKONSKO ZVEZO
povpr.starost <- ggplot(tabela1A %>% filter(Spremenljivka %in% c("Povprecna.starost.zenina", "Povprecna.starost.neveste")),
                  aes(x = Leto, y = Vrednost, color = Spremenljivka)) + geom_line() + xlab("Leto") + ylab("Število") 


#==================================================================================================================================================
#2. POROKE PO REGIJAH
#ZEMLJEVID
#source('lib/uvozi.zemljevid.r')

# jočem - ne dela

Slovenija <- uvozi.zemljevid("http://biogeo.ucdavis.edu/data/gadm2.8/shp/SVN_adm_shp.zip",
                             "SVN_adm1", encoding = "Windows-1250") %>% fortify()

graf.slovenija <- ggplot(Slovenija, aes(x=long, y=lat, group=group, fill=NAME_1)) + geom_polygon() +
  labs(title="Slovenija po regijah") + theme(legend.position="none")


# levels(zemljevid$OB_UIME) <- levels(zemljevid$OB_UIME) %>%
# { gsub("Slovenskih", "Slov.", .) } %>% { gsub("-", " - ", .) }
# zemljevid$OB_UIME <- factor(zemljevid$OB_UIME, levels=levels(odseljeni.obcine$obcina))
# zemljevid <- fortify(zemljevid)





#==================================================================================================================================================
#3.TRAJANJE ZAKONSKE ZVEZE DO RAZVEZE

#TRAJANJE ZAKONSKE ZVEZE (ČRTNI DIAGRAM - KAKO ODSTRANIM RAZVEZE Z OTROKI IN BREZ?)
trajanje <- ggplot(tabela3 %>% filter(spremenljivka %in% c("Manj.kot.1.leto", "Od.1-4.leta", "Od.5-9.let", "Od.10-14.let", "15.ali.vec")),
  aes(x = leto, y = vrednost, color = spremenljivka)) + geom_line() + xlab("Leto") + ylab("Število") 
  scale_color_discrete(name = "Trajanje zakonske zveze",
                       breaks = c("Trajanje zakonske zveze manj kot 1 leto", "Trajanje zakonske zveze 1-4 leta","Trajanje zakonske zveze 5-9 let","Trajanje zakonske zveze 10-14 let", "Trajanje zakonske zveze 15 let ali vec"),
                       labels = c("Pod 1 leto", "1-4 leta", "5-9 let", "10-14 let", "15 let ali več"))



#TRAJANJE ZAKONSKE ZVEZE TORTNI DIAGRAM 
trajanje.zveze <- tabela3 %>%  filter(spremenljivka %in% c("Manj.kot.1.leto", "Od.1-4.leta", "Od.5-9.let", "Od.10-14.let", "15.ali.vec")) 

trajanje.z <- tabela3 %>% group_by(spremenljivka) %>% summarise(sestevek=(sum(vrednost)/27))
trajanje.z <- head(trajanje.z, -2)
trajanje.z <- ggplot(trajanje.z, aes(x = spremenljivka, y = sestevek, fill = spremenljivka))+
  geom_bar(width = 1, stat = "identity")
trajanje.z <- trajanje.z + coord_polar("y", start=0)

#ZELO JE GRD, ZIHR JE KKŠNA LEPŠA MOŽNOST

#==================================================================================================================================================
#4. PRIMERJAVA ŠTEVILA ISTOSPOLNIH POROK MED ŽENSKAMI IN MED MOŠKIMI V LETIH 2007 - 2017

istospolne <- ggplot(data=tabela4, aes(x=leto, y=stevilo, fill=spol)) +
  geom_bar(stat="identity", position=position_dodge()) + ggtitle("Istospolne poroke")



#==================================================================================================================================================
#5. STAROST PRI RAZVEZI

starost <- ggplot(data=tabela5, aes(x=Leto, y=Stevilo, fill=starost.pri.razvezi)) +
  geom_bar(stat="identity", position=position_dodge()) + ggtitle("Starost pri razvezi")


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

#==================================================================================================================================================