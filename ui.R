library(shiny)
shinyUI(fluidPage(
        titlePanel(tags$b("Chick Weight Prediction Model")),
        sidebarLayout(
                sidebarPanel(
                        h3("Input Values"),
                        numericInput("numeric","Chick Initial Weight (g)",40),
                        sliderInput("slider","Chick Age (day)",0,21,15),
                        selectInput("select","Chick Diet",list("Diet 1"=1,"Diet 2"=2,"Diet 3"=3,"Diet 4"=4),1),
                        submitButton("Submit"),
                        h3("Output Value"),
                        textOutput("value"),
                        h4(tags$b("Information")),
                        h5("The application calculates the predicted chick weight from a linear model derived using the 'Time' and 'Diet' variables of the built-in data set 'ChickWeight'.")),
                mainPanel(
                        h3("Chick Weight Growth for 21 Days"),
                        plotOutput("plot"),
                        h4(tags$b("Instructions")),
                        tags$ol(
                                tags$li("Type or toggle the arrows to specify the weight of the chick at day 0."),
                                tags$li("Slide the toggle for the age of the chick in days."),
                                tags$li("Choose from the drop-down list the type of diet of the chick."),
                                tags$li("Press the submit button to show the weight of the chick based on its age and diet."))))))