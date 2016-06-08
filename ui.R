# User interface for the demonstration of the Galton Height Regression Builder
# 

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Galton Height Regression Builder"),
  
  # Check box for selecting variables 
  headerPanel("Build your regression using Galton Families data"),
  sidebarLayout(
    sidebarPanel(
      h1('Select the variables for the regression'),
      checkboxGroupInput("id1","Select regressors: ",
                         c("Height of Father"="father",
                           "Height of Mother"="mother",
                           "Mid-Parent Height"="midparentHeight",
                           "Gender of Child"="gender")),
      actionButton("build","Build!"),
      
      #Add a box so the user can enter parents height, gender and personal height
      h1('Add your own data and predict values'),
      numericInput('fatherheight',"Father's height, in",68),
      numericInput('motherheight',"Mother's height, in",64),
      numericInput('userheight',"Your height, in",66),
      selectInput('gender','gender',c('male','female')),
      actionButton("predict","Predict!")
      
    ),
    
    # Show a plot of the generated model
    mainPanel(
      #Regression model 
      h1('Regression Model Output Fitted vs. Actual'),
       plotOutput("distPlot"),
    
       
      #Calculate predicted vs actual
       h3('Results of prediction'),
       h4('You entered:'),
       verbatimTextOutput("inputValue"),
       h4('The predicted value was:'),
       verbatimTextOutput("predicted"),
       h4('Percent difference was:'),
      verbatimTextOutput("predictvar")
    )
  )
))
