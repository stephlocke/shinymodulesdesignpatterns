library(shiny)

## chart module ----------------------------------------------------------------
chartUI <- function(id) {
  ns <- NS(id)
  plotOutput(ns("distPlot"))
}
chart <- function(input, output, session, bins) {
  output$distPlot <- renderPlot({
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = bins() + 1)
    hist(x,
         breaks = bins,
         col = 'darkgray',
         border = 'white')
  })
}

## app -------------------------------------------------------------------------
ui <- shinyUI(fluidPage(
  titlePanel("Old Faithful Geyser Data"),
  sidebarLayout(sidebarPanel(
    sliderInput("bins", "Number of bins:",
                min = 1,  max = 50, value = 30)
  ),
  mainPanel(
    chartUI("first"),
    chartUI("second")
    ))
))

server <- shinyServer(function(input, output) {
  bins <- reactive(input$bins)
  callModule(chart, "first", bins)
  callModule(chart, "second", bins)
})

shinyApp(ui = ui, server = server)
