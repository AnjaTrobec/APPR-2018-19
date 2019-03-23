library(datasets)

function(input, output) {
  output$poroke <- renderPlot({
    tabela__1 <- poroceni %>% filter(regija == input$regija)

    print(ggplot(data=tabela__1, aes(x = leto, y = stevilo), group=1) + geom_bar(colour="black", stat="identity") +
            ylab("Število porok") + xlab("Leto"))
  }) 
}

