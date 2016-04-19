library(shiny)

## inputs module ---------------------------------------------------------------
setupInput<-function(id){
  ns<-NS(id)
  tagList(
  sliderInput(ns("bins"), "Number of bins:",
              min = 1,  max = 50, value = 30),
  checkboxInput(ns("print"),"Bin Print")
  )
}

setupUI<-function(id){
  ns<-NS(id)
  tagList(tableOutput(ns("inputs")))
}

setup<-function(input,output,session){
  # How to display all input values in a table
  output$inputs<-renderTable({
    as.data.frame(
      reactiveValuesToList(input)
      )
    })
  output$binprint<-renderText({
   req(input$print)
   paste0("Number of bins: ",input$bins)
   })
  return(input)
}

## chart module ----------------------------------------------------------------
chartUI <- function(id) {
  ns <- NS(id)
  plotOutput(ns("distPlot"))
}
chart <- function(input, output, session, setup) {
  output$distPlot <- renderPlot({
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = setup$bins + 1)
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
setupInput("basic")
  ),
  mainPanel(
    setupUI("basic"),
    chartUI("first"),
    chartUI("second")
    ))
))

server <- shinyServer(function(input, output) {
  bins <- callModule(setup,"basic")
  callModule(chart, "first", bins)
  callModule(chart, "second", bins)
})

shinyApp(ui = ui, server = server)
