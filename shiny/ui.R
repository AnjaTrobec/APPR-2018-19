# library("shiny")
# library("readr")
# 
# if(grepl("shiny",getwd())){setwd("..")}
# source("uvoz/mojuvoz.R")
# source("lib/libraries.r")
# 
# 
# shinyUI(fluidPage(
#   
#   titlePanel(""),
# 
#   tabsetPanel(
#     tabPanel("Združitev regij v skupine",
#              sidebarPanel(
#                sliderInput(inputId="st", label="Izberi število skupin:",
#                            value=3, min=1, max=6)
#              ),
#              mainPanel(plotOutput("zemljevid"))),
# 
#     tabPanel("Število porok v posameznih regijah",
#              sidebarPanel(
#                checkboxGroupInput(inputId="regija", label="Izberi regije:",
#                                   choiceNames=c("Gorenjska", "Goriška", "Jugovzhodna Slovenija", "Koroška", "Obalno-kraška", "Osrednjeslovenska", "Podravska", "Pomurska", "Posavska", "Primorska", "Savinjska", "Zasavska"),
#                                   choiceValues=c("Gorenjska", "Goriska", "Jugovzhodna_Slovenija", "Koroska", "Obalno-kraska", "Osrednjeslovenska", "Podravska", "Pomurska", "Posavska", "Primorska", "Savinjska", "Zasavska"),
#                                   selected="Osrednjeslovenska")
#              ),
#              mainPanel(plotOutput("regije")))
# 
# 
#   )
# ))

library(shiny)
library("readr")

if(grepl("shiny",getwd())){setwd("..")}
source("uvoz/mojuvoz.R")
source("lib/libraries.r")

shinyUI(fluidPage(
  
  titlePanel(""),
  
  tabsetPanel(
    tabPanel("Statististična regija",
             sidebarPanel(
               selectInput("regija", "Izberi regijo",
                           sort(unique(poroceni$regija)))
             ),
             mainPanel(plotOutput("gostota1"))),
    
    tabPanel("Leto",
             sidebarPanel(
               sliderInput("leto", "Izberi leto", min=2011, max=2017,
                           value=2014, step=1, sep='', animate = 
                             animationOptions(interval = 250))
             ),
             mainPanel(plotOutput("gostota2")))
  )
))
