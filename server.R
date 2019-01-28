library(shiny)
library(plyr)
data("ChickWeight")
df <- ChickWeight
zero.weight <- df[df$Time==0,]$weight
ratio <- function(x,y){
        A <- x/zero.weight[as.numeric(as.character(y))]
        return(A)
}
Increase <- log(mapply(ratio,df$weight,df$Chick))
df <- cbind(df,Increase)
model <- lm(Increase~Time+Diet,data=df)
shinyServer(function(input,output){
        new.val <- reactive({
                t <- as.numeric(input$slider)
                d <- as.numeric(input$select)
                df.in <- data.frame(cbind(Time=t,Diet=d))
                df.in$Diet <- as.factor(df.in$Diet)
                input$numeric*exp(predict.lm(model,df.in))
        })
        output$value <- renderText(new.val())
        output$plot <- renderPlot({
                t <- as.numeric(input$slider)
                d <- as.numeric(input$select)
                df.plot <- subset(df,Diet==d)
                mod.plot <- data.frame(cbind(0:21,rep(d,22)))
                mod.plot[,2] <- as.factor(mod.plot[,2])
                colnames(mod.plot) <- c("Time","Diet")
                mod.line <- input$numeric*exp(predict.lm(model,mod.plot))
                plot(x=df.plot$Time,y=df.plot$weight,col=df.plot$Chick,xlab="Time (day)",ylab="Weight (g)")
                lines(mod.plot$Time,mod.line,lwd=1.5)
                points(t,new.val(),pch=16,cex=1.5,col="black")
        })          
})