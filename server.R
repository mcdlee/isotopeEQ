library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
  # define the function of A(t) for both parent and daughter
  parentActivity <-function(parLambda, parInit, t){
    parInit * exp(-parLambda *t)
  }
  
  daughterActivity <- function(parLambda, dauLambda, parInit, dauInit, ratio, t){
    dauInit * exp(-dauLambda * t) + ratio * dauLambda/(dauLambda-parLambda)*parInit*(exp(-parLambda* t)-exp(-dauLambda* t))
  }
  

  
  parLambda <- reactive(0.693/input$parHL)
  dauLambda <- reactive(0.693/input$dauHL)
  parInit <- reactive(input$parInit)
  dauInit <- reactive(input$dauInit)
  ratio <- reactive(input$ratio)
  from <- reactive(input$from)
  to <- reactive(input$to)
  
  output$plot <-renderPlot({
    ggplot(data.frame(x=c(from(), to())), aes(x, ymin=0)) +
      stat_function(fun=function(x)parentActivity(parLambda(), parInit(), x), geom = "line", aes(color="Parent")) +
      stat_function(fun=function(x)daughterActivity(parLambda(), dauLambda(), parInit(), dauInit(),  ratio(), x), geom = "line", aes(color="Daughter")) +
      labs(color="Isotopes") +
      xlab("Time") +
      ylab("Activity")  
  })
  output$plotLog <-renderPlot({
    ggplot(data.frame(x=c(from(), to())), aes(x, ymin=0)) +
      stat_function(fun=function(x)parentActivity(parLambda(), parInit(), x), geom = "line", aes(color="Parent")) +
      stat_function(fun=function(x)daughterActivity(parLambda(), dauLambda(), parInit(),dauInit(), ratio(), x), geom = "line", aes(color="Daughter")) +
      labs(color="Isotopes") +
      xlab("Time") +
      ylab("Activity") +
      scale_y_log10()
  })
})