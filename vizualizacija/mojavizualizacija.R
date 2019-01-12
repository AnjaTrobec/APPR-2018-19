install.packages("ggplot2")
install.packages("dplyr")
install.packages("plotrix")
install.packages("plotly")
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
#torej za vsak stolpec bom seštela vse številke in delila s številom let - dobila bom povprečje

trajanje.zveze <- tabela3 %>% group_by(variable) %>% summarise(sestevek=sum(value) / 27) # kako zaokrožim

                                                               





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

