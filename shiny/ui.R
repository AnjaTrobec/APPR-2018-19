library(shiny)
library(dplyr)
library(ggplot2)

shinyUI(fluidPage(
  
  titlePanel("Poroke po regijah"),
  
  tabPanel("Graf",
           
           sidebarPanel(
             selectInput("regija", label = "Izberite regijo:",
                         choices=(sort(unique(poroceni$regija))))),
           
           mainPanel(plotOutput("poroke"))),
  
  uiOutput("izborTabPanel")))

