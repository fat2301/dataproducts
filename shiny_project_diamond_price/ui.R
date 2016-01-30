
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
library(caret)


diamond_dataset <- diamonds


shinyUI(fluidPage(

  # Application title
  titlePanel("Diamond pricing"),

  # Sidebar with a slider input for number of bins

  
    sidebarLayout(
    sidebarPanel(
      sliderInput('carat', 'Diamond Size', min=min(diamond_dataset$carat), max=max(diamond_dataset$carat), 
                  step=.01, value=.02),
      selectInput('color','Color',levels(diamond_dataset$color)),
      selectInput('cut','Cut',levels(diamond_dataset$cut)),
      selectInput('clarity','Clarity',levels(diamond_dataset$clarity))
      
    ),

    # Show a plot of the generated distribution
    mainPanel(
      h4("Diamond pricing info documentation")
      ,h6("This is a simple app. Here's how to use it:")
      ,h6("Use the left side panel to set the diamond attributes, or 4Cs")
      ,h6("Diamond size denotes the carats, and can be set from 0.2 to 5.01 at 0.01 increments")
      ,h6("Color, cut, and clarity are drop down menus in which you can set the corresponding color, cut, and clarity of the diamond.")
      ,h6("When you set the attributes, the corresponding description will be displayed on the main results area below.")
      ,h6("A price estimate is also provided based on a pricing statistical model that's based on existing data about within the ggplot2 library of R. Price is determined by the 4Cs of the diamond.")
      ,h6("Note: This app is only intended to try out the Shiny feature of R for the Coursera course in Developing Data Products. Minimal effort was taken in building the pricing model and should not be taken seriously.")
      ,h6("Diamond 4C information reference from http://www.4cs.gia.edu/en-us/the-diamond-4-cs.htm")
      ,h6("Enjoy using the app!")

      ,h5("Please wait for entire page to load. Computation of price model takes about less than a minute. You'll know it's fully loaded when you see the diamond descriptions and histogram chart below this text.")
      
      ,h3("Your diamond"),
      h4(textOutput("carattext")),
      h4(textOutput("colortext")),
      h4(textOutput("cuttext")),
      h4(textOutput("claritytext")),
      h4(textOutput("price")),
      plotOutput("comparisonPlot")
    )
  )
))

min(diamonds$price)

