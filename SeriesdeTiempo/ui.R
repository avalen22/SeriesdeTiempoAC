
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(
  
  #fluidPage(
  navbarPage("Series de Tiempo y modelado predictivo",
  # Application title
  #titlePanel("Series de Tiempo"),

 
  #sidebarLayout(
  tabPanel( "Estadísticos",
    
    sidebarPanel(
       fileInput("archivo", label = h3("Seleccione datos:")), 
       radioButtons("radio", label = h3("Gráficas"), 
                    choices = list("Plot" = 1,
                                   "Decompose" = 2,
                                   "acf" = 3,
                                   "pacf" = 4), 
                    selected = 1),
       verbatimTextOutput("summary")
    ),

    # Show a plot of the generated distribution
    mainPanel(
      
      tableOutput("contents"), 
      plotOutput("distPlot")
      
    )
  ), 
  
  tabPanel( "Predicciones",
            
            sidebarPanel(
              #lo que habrá en este panel
            ),
            
            # Show a plot of the generated distribution
            mainPanel(
              
              tableOutput("contents1"), 
              plotOutput("distPlot1")
              
            )
  ),
  
  tabPanel( "Ajustes de funciones",
            sidebarPanel(
              #lo que habrá en este panel
              radioButtons("radio2", label = h3("Funciones"), 
                           choices = list("Lineal" = 1,
                                          "Logaritmica" = 2,
                                          "exponencial" = 3), 
                           selected = 1)
              
            ),
            
            # Show a plot of the generated distribution
            mainPanel(
              
              tableOutput("contents2"), 
              plotOutput("distPlot2")
              
            )
            
    )
  
  
  
))
