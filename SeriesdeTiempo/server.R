
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
    data = read.table(file=archivo$datapath, header=TRUE, sep=",", dec="." )
    
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
      
      datosTS <- ts(archivo_in())
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
       datos <-  archivo_in()
       datosTS <- ts(archivo_in(), frequency=12, start=c(1946,1))
       
      }
      if(input$radio==1){
       plot(datosTS)
     }else{
       if(input$radio==2){
 
        # datosTSdecomp <- decompose(datosTS)
        # plot(datosTSdecomp)
         hist(datosTS)
       #decompose
       }else{
         if(input$radio==3){
           acf(datosTS)
          }else{
           if(input$radio==4){
            pacf(datosTS)
           }else{
             if(input$radio==5){
               datosTSdecomp <- decompose(datosTS)
               plot(datosTSdecomp)
             }
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
         
         t <- seq(1:length(datosTS)) 
         tt <- t*t
         m <- lm(formula = datosTS ~ t +tt)
         
         plot(t,datosTS, type = "l")
         lines(m$fitted.values, col = "red", lwd = 2)
         #plot(datosTS)
   
         
         
       }else{
         if(input$radio2==3){
           
           
           
         }
       }
     }   
   })
   
   
   
   output$distPlot3 <- renderPlot({
     
     
     if(is.null(archivo_in()))
     {
       return(NULL)   
     }else{
       datos <-  archivo_in()
       datosTS <- ts(archivo_in(), frequency=12, start=c(1946,1))
       
     }
     if(input$prediccion==1){
     #Prediccion Series de Tiempo
       
       plot(datosTS)
     }else{
       if(input$prediccion==2){
         #Prediccion Holt-Winters
         
         fit<-HoltWinters(datosTS)
         forecast <- predict(fit, n.ahead = input$nropreds, prediction.interval = T, level = input$intervaloconf)
         plot(fit, forecast)
        
       }else{
         if(input$prediccion==3){
           #Prediccion ARIMA
           
         fit= Arima(datosTS, order = c(0,0,1))
         forecast = forecast(fit,h=input$nropreds)
         plot(forecast, col='green')
        lines(fit$fitted, col='red')
      
   #     plot(datosTS)
   #      LH.pred<-predict(fit,n.ahead=8)
  #      lines(LH.pred$pred , col = 'blue')

         }
       }
     }   
   })

})
