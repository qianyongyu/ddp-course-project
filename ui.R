
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Effect of Variable Selection on Linear Regression Model"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(width = 5,
      checkboxGroupInput("variable", 
         label = h3("Variables:"), 
         choices = list("Number of cylinders" = "cyl", 
                        "Displacement" = "disp", 
                        "Gross horsepower" = "hp",
                        "Rear axle ratio" = "drat",
                        "Weight" = "wt",
                        "1/4 mile time" = "qsec",
                        "Piston Layout (v-shaped vs. straight)" = "vs",
                        "Transmission (auto / manual)" = "am",
                        "Number of forward gears" = "gear",
                        "Number of carburetors" = "carb"),
         selected = c("cyl", "disp", "hp", "drat", "wt", "qsec", "vs", "am", "gear", "carb"))
    ),

    # Show a plot of the generated distribution
    mainPanel(width = 7,
      
      h2("Introduction"),
      
      p("This application demonstrates the effect of variable selection on linear regression models."),
      p("The dataset we're using is the mtcars dateset built into R. This dataset contains 10 variables 
        and fuel efficiency (in MPG) of 32 motor vehicles."),
      p("When you select some of the variables from the side panel, the 
        application will build a linear regression model using the selected variables. The model's quality 
        and other diagnostic information will be displayed."),
      
      h2("Attempt History"),
      
      p("The chart below plots Adjusted R-squared for your last 20 variable selections. The red line marks highest possible
        value when considering all possible subsets of the variables, so your goal is to get as 
        close to the red line as possible."),
      
      plotOutput("history"),
      
      h2("Attempt Detail"),
      
      p("Adjusted R-squared for your current variable selection is ", span(textOutput("r2", inline = TRUE), style = "color:red"), 
        ". This value indicates how well data fit a statistical model, so the higher the better (it ranges between -1 and 1)."),
      p("The chart below plots the predicted MPGs values vs. actual MPG values. A good model should have the data points form a narrow band around the red diagnoal line."),
      
      plotOutput("r2Plot")
      
    )
  )
))
