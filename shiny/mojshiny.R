# library(shiny)
# 
# #učenje uporabe
# 
# ui <- fluidPage(
#   sliderInput(inputId = "num",
#               label = "Choose a number",
#               value = 25, min = 1, max = 100),
#   plotOutput("hist")
# )
# 
# server <- function(input, output) {
#   output$hist <- renderPlot({
#     hist(rnorm(input$num))
#   })
#   
# }
# 
# shinyApp(ui = ui, server = server)


#za moj program

library(shiny)
library(readr)
source("uvoz/mojuvoz.R")


ui <- fluidPage(
  titlePanel("Poroke po regijah"),
  uiOutput("poroke")
)


server <- function(input, output) {
  output$poroke = renderUI({
    tabPanel("Graf",
             sidebarPanel(
               selectInput("regija", label = "Izberite regijo:",
                           choices= (sort(unique(poroceni$regija))))),
             mainPanel(plotOutput("poroke1")))
  })
  output$poroke1 <- renderPlot({
    izbrana <- poroceni %>% filter(regija == input$regija)
    print(ggplot(izbrana) + geom_line(aes(x = leto, y = stevilo), group=1) + ylab("Poroke") + xlab("Leto") +
            ggtitle("Poroke po regijah"))
  }) 
}

shinyApp(ui = ui, server = server)

