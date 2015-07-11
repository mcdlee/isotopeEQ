
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(
  fluidPage(
    sidebarLayout(
      sidebarPanel(
        numericInput("parHL", "Half-life of Parent Isotope", 67),
        numericInput("dauHL", "Half-life of Daughter Isotope", 6),
        numericInput("parInit", "Initial Activity of Parent Isotope", 500),
        numericInput("dauInit", "Initial Activity of Daughter Isotope", 0),
        numericInput("ratio", "Ratio of branching fraction", 0.86),
        numericInput("from", "Plot from", 0),
        numericInput("to", "Plot to", 500)
      ),
      mainPanel(
        plotOutput("plot"),
        plotOutput("plotLog")
      )
    )
  )
)