
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)

diamond_dataset <- diamonds
fit <- train(price~carat+as.factor(cut)+as.factor(color)+as.factor(clarity), method="glm", data=diamond_dataset)

shinyServer(function(input, output) {


  output$carattext <- renderText({ 
    c("Your chosen size is ", input$carat, " carat.")
  })

  output$colortext <- renderText({ 
    c("Color represents absence of color, with D as the best. ", input$color, " means it is ", switch (input$color , 
                                                              D= "Colorless- whitest color",
                                                       E= "Colorless- 2nd whitest",
                                                       F= "Colorless- 3rd whitest",
                                                       G= "Near Colorless",
                                                       H= "Near Colorless",
                                                       I= "Near Colorless",
                                                       J= "Near Colorless - almost faint") , ".")
      })
  
  output$cuttext <- renderText({
    c("Cut is a description of how well it interacts with light: ",input$cut,".")
  })
  
  output$claritytext <- renderText({ 
    c("Clarity refers to absence of inclusions and blemishes. ", input$clarity, " means ", 
            switch (input$clarity , 
                                                       I1= "Included",
                                                       SI2= "Slightly Included",
                                                       SI1= "Slightly Included",
                                                       VS2= "Very Slightly Included",
                                                       VS1= "Very Slightly Included",
                                                       VVS2= "Very Very Slightly Included",
                                                       VVS1= "Very very Slightly Included",
                                                       IF = "Internally Flawless") , ".")
  })
  
  
    output$price <- renderText({ 
    predicted <- max(predict(fit, data.frame(carat=input$carat, cut=input$cut, 
                                         color=input$color, clarity=input$clarity)
                         ),325)
  c("Price estimate is ",predicted)
  })
  
  
    output$comparisonPlot <- renderPlot({

    
    hist(diamond_dataset$carat, breaks = 20, xlim= c(0,2.5), col = 'darkgray', border = 'white',
         main = "How common is your diamond size?",
         xlab = "Carat Size", ylab = "Number of diamonds for that size")
    abline(v=input$carat,col="red")
  })

    
    
})

