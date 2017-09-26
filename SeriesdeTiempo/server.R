
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

#RECIBIR EL ARCHIVO 
  
  read_data <- reactive({
    
    
    if(is.null(input$archivo)){
      
      return()
      
    }else{
      
      archivo<- input$archivo
      read.table(file=archivo$datapath, header=TRUE, sep=",", dec="." )
      
    }
    
  })


  
   output$distPlot <- renderPlot({
     
    births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
     birthstimeseries <- ts(births, frequency=12, start=c(1946,1))
    plot(birthstimeseries)
    #kings <- scan("http://robjhyndman.com/tsdldata/misc/kings.dat",skip=3)
    #kingstimeseries <- ts(kings)
    #plot(kingstimeseries)
    
    # generate bins based on input$bins from ui.R
    # x    <- faithful[, 2]
    # bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    # draw the histogram with the specified number of bins
    # hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })

  
  output$distPlot2 <- renderPlot({
   
    if(input$action==TRUE){
    
      births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
      birthstimeseries <- ts(births, frequency=12, start=c(1946,1))
      plot(birthstimeseries)
      birthtimeseriescomponets <- decompose(birthstimeseries)
      plot(birthtimeseriescomponets)
      
    }
    
  })
  
  output$acf <- renderPlot({
    
    if(input$action==TRUE){
      
      input$action== FALSE
      births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
      birthstimeseries <- ts(births, frequency=12, start=c(1946,1))
      acf(birthstimeseries)
      
    }
    
  })
  
  

})
