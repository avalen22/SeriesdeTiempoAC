



mseLM = data.frame(sum((m.lin$residuals)^2)/length(m.lin$residuals),
                   sum((m.cuad$residuals)^2)/length(m.cuad$residuals),
                   sum((m.cub$residuals)^2)/length(m.cub$residuals),
                   sum((m.log$residuals)^2)/length(m.log$residuals)
)
names(mseLM) = c("Lineal","Cuadrática","Cúbica","Logarítmica")

rsmeLM = data.frame(sqrt(mseLM))

mseLM[2,] = rsmeLM

row.names(mseLM) <- c("rsmeLM","smeLM")

rsmeLM = data.frame(sqrt(mseLM))
errores = rbind(mseLM, rsmeLM)

datosTS

logt <- log(datosTS)

plot(datosTS)
lines(logt)