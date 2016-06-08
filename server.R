#
# This is the server logic of the Galton Height Regression Builder. You can run the 
# application by clicking 'Run App' above.
#

library(shiny)
require(HistData)

appdata<-subset(GaltonFamilies,select=c(father,mother,midparentHeight,gender,childHeight))

# Define server logic required to create a regression using selected variables
# Also, plot the regression line and calculate variance of the user's height given parent's height and gender
shinyServer(function(input, output) {

  #Set defaults if nothing is selected
  
  model<-reactiveValues()
  model$heightmodel<-lm(childHeight~1,data=appdata)
  model$fitted<-lm(childHeight~1,data=appdata)$fitted.values
  model$regressors<-c("1")
  
  #Create model and fitted values for plot
  observeEvent(input$build, {
    regressors<-paste(c(input$id1,"1"),sep="+",collapse="+")
    model$regressors<-paste(c(input$id1,"1"),sep="+",collapse="+")
    model$heightmodel<-lm(as.formula(paste("childHeight","~",regressors)),data=appdata)
    model$fitted<-lm(as.formula(paste("childHeight","~",regressors)),data=appdata)$fitted.values
    })
  
  
  #Create output of plot with Observed vs Predicted
  output$distPlot<-renderPlot({
    
      plot(x=appdata$childHeight,xlab="Observation",ylab="Child Height, in", main="Actual and Predicted Values for Regression", col=3)
      points(model$fitted,col=5)
      legend(x="bottomright",legend=c("Actual","Predicted"),col=c(3,5), pch=c(1))
  })
  
  #create comparison of predicted to actual values.
  
  observeEvent(input$predict, {
    output$inputValue<-renderPrint({input$userheight})
    
    #Create a data frame with the values entered by the user
    
    newvals<-data.frame(father=input$fatherheight,
                        mother=input$motherheight,
                        gender=input$gender,
                        midparentHeight=(input$fatherheight+1.08*input$motherheight)/2,
                        childHeight=input$userheight)
    
    #Predicted value
    
    output$predicted<-renderPrint({
      predict(lm(as.formula(paste("childHeight","~",model$regressors)),data=appdata),newvals)
    })
    
    #Variance from prediction %
    
    output$predictvar<-renderPrint({
      
      paste(round((((predict(lm(as.formula(paste("childHeight","~",model$regressors)),data=appdata),newvals))-input$userheight)/input$userheight)*100,digits=2),"%",sep="")
      
    })
    
  })
  
 
  
})
