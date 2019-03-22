library(shiny)
library(readr)
library(ggplot2)

source("uvoz/mojuvoz.R")


ui <- fluidPage(
  titlePanel("Poroke po regijah"),
  uiOutput("izborTabPanel"))

server <- function(input, output) {
  output$izborTabPanel = renderUI({
    tabPanel("Graf",
             sidebarPanel(selectInput("regija", label = "Izberite regijo:",
                           choices=(sort(unique(poroceni$regija))))),
             mainPanel(plotOutput("poroke")))
  })
  
  output$poroke <- renderPlot({
    tabela__1 <- poroceni %>% filter(regija == input$regija)
    print(ggplot(tabela__1) + geom_line(aes(x = leto, y = stevilo), group=1) + 
            ylab("Poroke") + xlab("Leto") + ggtitle("Poroke po regijah"))
  }) 
}

shinyApp(ui = ui, server = server)
