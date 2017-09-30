
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(forecast)

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
  
  output$summary <- renderTable({
    
    if(is.null(archivo_in()))
    {
      return(NULL)   
    }else{
      
      datosTS <- ts(archivo_in())
    }
    

    meanData = mean(datosTS)
    sdData = sd(datosTS)
    quantileData = quantile(datosTS,probs = c(0,0.25,0.5,0.75,1))
    
    summaryTable = data.frame(Min = quantileData[1],
                              PCuartil = quantileData[2],
                              Media = meanData,
                              mediana = quantileData[3],
                              TCuartil = quantileData[4],
                              Max = quantileData[5])
    
    #datos <- archivo_in()
    # summary(datosTS)
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
     



  
     t <- seq(1:length(datosTS))  
     tt <- t*t
     ttt<-t*t*t
     logt <- log(datosTS)
     
     
     m.lin <- lm(formula = datosTS ~ t)
     m.cuad <- lm(formula = datosTS ~ t +tt)
     m.cub <- lm(formula = datosTS ~ t + tt + ttt)
     m.log <- lm(formula = datosTS ~ logt)

     if(input$radio2==1){

       plot(t,datosTS, type = "l")
       lines(m.lin$fitted.values, col = "red", lwd = 2)
       #plot(datosTS)
 
       
     }else{
       if(input$radio2==2){
 
         plot(t,datosTS, type = "l")
         lines(m.cuad$fitted.values, col = "red", lwd = 2)
         #plot(datosTS)


       }else{
         if(input$radio2==3){
  
            plot(t,datosTS, type = "l")
           lines(m.cub$fitted.values, col = "red", lwd = 2)
           #plot(datosTS)
 
         }else{
           if(input$radio2==4){

             plot(t,datosTS, type = "l")
             lines(m.log$fitted.values, col = "red", lwd = 2)
             #plot(datosTS)

           }
         }
       }
     }   
   })
   
#TABLA EN EL CUERPO DEL PANEL DE AJUSTE DE FUNCIONES
   
   
   output$contents2 <- renderTable({
     
     if(is.null(archivo_in()))
     {
       return(NULL)   
     }else{
       
       datosTS <- ts(archivo_in(), frequency=12, start=c(1946,1))
     }
     t <- seq(1:length(datosTS))  
     tt <- t*t
     ttt<-t*t*t
     logt <- log(datosTS)
     
     
     m.lin <- lm(formula = datosTS ~ t)
     m.cuad <- lm(formula = datosTS ~ t +tt)
     m.cub <- lm(formula = datosTS ~ t + tt + ttt)
     m.log <- lm(formula = logt ~ t)
     

    
     mseLM = data.frame(Lineal = sum((m.lin$residuals)^2)/length(m.lin$residuals),
                        Cuadrática =sum((m.cuad$residuals)^2)/length(m.cuad$residuals),
                        Cúbica = sum((m.cub$residuals)^2)/length(m.cub$residuals),
                        Logarítmica = sum((m.log$residuals)^2)/length(m.log$residuals)
     )

   
   rsmeLM = data.frame(sqrt(mseLM), row.names = "srce")
   errores = rbind(mseLM, rsmeLM)


   }
  )

   
   
#CUERPO DEL PANEL DE PREDICCIONES
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
           
         fit= arima(datosTS, order = c(0,0,1))
         forecast = forecast(fit,h=input$nropreds)
         plot(forecast, col='green')
        lines(fit$fitted, col='red')
      


         }
       }
     }   
   })

})
