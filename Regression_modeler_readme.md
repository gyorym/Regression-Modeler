\name{Regression Modeler Shiny App}
\alias{Regression Modeler Shiny App}
\date {June 7, 2016}
\created_by {Matt Gyory}


\title{Regression Modeler Shiny App Readme}

\Intro {

The Regression Modeler Shiny app uses the Galton Families data from the HistData package to create and plot a regression to predict a child's height. It contains 2 reactive sections on the UI and several interesting methodss in the Server function.

}

\UI_description {

The UI has two main sections: The Regression and The Prediction.

The Regression section asks the user to select variables to include in a regression model the Server function creates. Due to the reactive nature, the model is not built and modeled until the user clicks "Build." Prior to clicking the action button, the plot shows all of the values for the childHeight variable and regression created using just the intercept (i.e. the mean of childHeight). This plot is updated each time the regression variables are changes and "Build!" is clicked.

The Prediction section takes input from the user (their height, parents' heights and gender) and then plugs these values into the model created in the Regression section. The defaults are set to the approximate averages of the heights in the data. The prediction and a percentage difference are populated when "Predict!" is clicked.

}

\Server_description {

The server function file requires the HistData package to ensure the GaltonFamilies data is available for use. Outside of the function body, the data are read to minimize the amount of processing time.

The first step in the function is to create a default model (just regressing to the intercept) and a calculation of fitted values (which are all the same). These values are used to populate the initial plot when the app loads. A reactive object is also created to store the model and fitted values.

The second step is an observeEvent function that updates whenevere "Build!" is clicked. The function takes the regressors selected, creates a list of them and then produces a model and fitted values. These entries are used to update the reactive object created at the top of the application. 

The third step is the creation of a scatterplot. The values of childHeight are plotted and then the fitted values are also plotted. A legend is created to allow the user to identify which is which. 

The fourth step is a second observeEvent function. This function uses the information entered to predict the user's height based on the regressors selected and then calculate the percent difference between predicted and actual values. The user's height is printed to the UI. Next, a data frame is created for all possible entries into the regression model (i.e. the various heights and gender). Finally, the predicted value and percent difference are printed to the UI. 

}