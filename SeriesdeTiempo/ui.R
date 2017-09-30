
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
                    choices = list("Serie tiempo" = 1,
                                   "Histograma" = 2,
                                   "ACF" = 3,
                                   "pACF" = 4,
                                   "Descomponer" = 5), 
                    selected = 1)
       
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tableOutput("summary"),
      br(),
      br(),
      # tableOutput("contents"), 
      # br(),
      # br(),
      plotOutput("distPlot")
      
    )
  ), 
  
  
  tabPanel( "Ajustes de funciones",
               sidebarPanel(
                 #lo que habrá en este panel
                 radioButtons("radio2", label = h3("Funciones"), 
                              choices = list("Lineal" = 1,
                                             "Cuadrática" = 2,
                                             "Cúbica" = 3,
                                             "Exponencial" = 4), 
                              selected = 1)
                 
               ),
               
               # Show a plot of the generated distribution
               mainPanel(
                 
                 plotOutput("distPlot2"), 
                 tableOutput("contents2")
               )
               
  ),
  
  
  
  tabPanel( "Predicciones",
            
            sidebarPanel(
              
              selectInput("prediccion", "Tipos de predicciones:",
                          choices = list("Elija modelo:" = 1,
                                           "Holt-Winters" = 2,
                                           "ARIMA" = 3)),
              
            
             numericInput("nropreds", "Número de periodos a predecir:", 5, min =1, step = 1),
             numericInput("intervaloconf", "Intervalo  de confianza de la predicción:",0.9, min =0, max=1, step = 0.01),
              
              # Include clarifying text ----
              helpText("Note: while the data view will show only the specified",
                       "number of observations, the summary will still be based",
                       "on the full dataset.")
              
             
            #  actionButton("update", "Update View")
              
              
            ),
            
           mainPanel(
              
            
              plotOutput("distPlot3"),
              tableOutput("contents3") 
              
            )
  )
  
  
  
  
  
))
