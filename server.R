
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyServer(function(input, output) {
  
  r2 <- c() # last 20 adj r2 values will be stored here
  attempts <- 0 # total number of attempts in the session
  
  # builds a lm with selected variables
  buildModel <- reactive({
    d <- mtcars
    d$am <- as.factor(d$am)
    d$vs <- as.factor(d$vs)
    lm(mpg ~ ., data = d[,c("mpg", input$variable)])
  })
  
  # displays actual adj.R2 values
  output$r2 <- renderText(summary(buildModel())$adj.r.squared)
  
  # renders correlation plot of predictions vs actual values
  output$r2Plot <- renderPlot({
    plot(buildModel()$fitted.values, mtcars$mpg, 
         xlab = "Predicted MPG",
         xlim = c(10, 35),
         ylab = "Actual MPG",
         ylim = c(10, 35),
         main = "Predicted vs. Actual")
    abline(a = 0, b = 1, col = "red", lwd = 2)
    })
  
  # renders adj.R2 of last 20 attempts in a line chart
  # this chart starts plotting from the left and when more than 20 attempts are made, scroll the attempt window
  # to the right accordingly
  output$history <- renderPlot({
    # keep the last 10 records
    r2 <<- tail(append(r2, summary(buildModel())$adj.r.squared), 20)
    attempts <<- attempts + 1
    plot(if (attempts <= 20) { 1:attempts } else { (attempts - 19) : attempts }, 
         r2,
         ylab = "Adjusted R-Squared", 
         ylim = c(0.75, 0.85),
         xlab = "Attempt",
         xlim = if (attempts <= 20) { c(1,20) } else { c(attempts - 20, attempts) },
         main = "Attempt History",
         pch = 19,
         type = "l")
    
    # the optimal value comes from the result of the regsubsets function
    abline(h = 0.8375334, lwd = 2, col = "red")
  })

})
