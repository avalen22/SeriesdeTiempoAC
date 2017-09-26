
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {

#RECIBIR EL ARCHIVO 
  
  archivo_in <- reactive({
    
    
    if(is.null(input$archivo))
      
      return(NULL)
      
    archivo<- input$archivo
    read.table(file=archivo$datapath, header=FALSE, sep=",", dec="." )
    
  })

  
  output$contents <- renderTable({

    
    req(input$archivo)
    
    datos <- archivo_in()
    
  })
  
  
  
  
  
  
#PINTAR DATOS INICIALMENTE
 
  
   output$distPlot <- renderPlot({
     if(input$radio==1){
     
          
         if(is.null(archivo_in()))
            {
              return(NULL)   
         }else{
           
         
        births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
         birthstimeseries <- ts(archivo_in(), frequency=12, start=c(1946,1))
        plot(birthstimeseries)

         }
     }else{
       if(input$radio==2){
         births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
         birthstimeseries <- ts(births, frequency=12, start=c(1946,1))
         plot(birthstimeseries)
         birthtimeseriescomponets <- decompose(birthstimeseries)
         plot(birthtimeseriescomponets)
       
       }else{
         if(input$radio==3){
           #input$action== FALSE
           births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
           birthstimeseries <- ts(births, frequency=12, start=c(1946,1))
           acf(birthstimeseries)
           
         
         }
       }
     }   
  })
  
  
   
 
  
  

})
