
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
    head(datos)
  })
  
  output$summary <- renderPrint({
    
    if(is.null(archivo_in()))
    {
      return(NULL)   
    }else{
      
      datosTS <- ts(archivo_in(), frequency=12, start=c(1946,1))
    }
    
    
    
    #datos <- archivo_in()
    summary(datosTS)
  })
  
  
  
  
#CUERPO DEL PANEL DE ESTADÍSTICOS
 
   output$distPlot <- renderPlot({
     
     
     if(is.null(archivo_in()))
     {
       return(NULL)   
     }else{
       
       datosTS <- ts(archivo_in(), frequency=12, start=c(1946,1))
      }
      if(input$radio==1){
       plot(datosTS)
     }else{
       if(input$radio==2){
         #births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
         #birthstimeseries <- ts(births, frequency=12, start=c(1946,1))
         #plot(birthstimeseries)
         datosTSdecomp <- decompose(datosTS)
         plot(datosTSdecomp)
       
       }else{
         if(input$radio==3){
           acf(datosTS)
          }else{
           if(input$radio==4){
            pacf(datosTS)
           }
         }
       }
     }   
  })
  
  
 
 #CUERPO DEL PANEL DE AJUSTE DE FUNCIONES  
   
   output$distPlot2 <- renderPlot({
     
     
     if(is.null(archivo_in()))
     {
       return(NULL)   
     }else{
       
       datosTS <- ts(archivo_in(), frequency=12, start=c(1946,1))
     }
     if(input$radio2==1){
      
       t <- seq(1:length(datosTS))                     
       m <- lm(formula = datosTS ~ t)
       
       plot(t,datosTS, type = "l")
       lines(m$fitted.values, col = "red", lwd = 2)
       #plot(datosTS)
     }else{
       if(input$radio2==2){
   
         
         
       }else{
         if(input$radio2==3){
           
           
           
         }
       }
     }   
   })  
 
  
  

})
