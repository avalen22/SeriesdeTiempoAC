
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Series de Tiempo"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
       fileInput("archivo", label = h3("File input")), 
       radioButtons("radio", label = h3("Radio buttons"), 
                    choices = list("Plot" = 1, "Decompose" = 2, "acf" = 3), 
                                                                    selected = 1)
    ),

    # Show a plot of the generated distribution
    mainPanel(
      
      tableOutput("contents"), 
      plotOutput("distPlot")
      
    )
  )
  
  #  , actionButton("action", label = "Action")
  
  
))
