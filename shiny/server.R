# library(shiny)
# 
# function(input, output, session) {
# 
#   output$regije <- renderPlot({
#     graf.regije(input$regija)
#   })
#   output$zemljevid <- renderPlot({
#     graf.zemljevid(input$st)
#   })
# }
# 
# # )

library(shiny)

function(input, output) {
  
  output$gostota1 <- renderPlot({
    gostota_graf1(input$regija)
  })
  output$gostota2 <- renderPlot({
    gostota_graf2(input$leto) + theme(axis.text.x = element_text(angle = 90, hjust = 1))
  })
}