library(shiny)

## app -------------------------------------------------------------------------
ui <- shinyUI(fluidPage(
   titlePanel("Old Faithful Geyser Data"),
   sidebarLayout(
      sidebarPanel(
         sliderInput("bins", "Number of bins:",
                     min = 1,  max = 50, value = 30)
      ),
      mainPanel(
         plotOutput("distPlot")
      )
   )
))

server <- shinyServer(function(input, output) {
   output$distPlot <- renderPlot({
      x    <- faithful[, 2]
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      hist(x, breaks = bins, col = 'darkgray', border = 'white')
   })
})

shinyApp(ui = ui, server = server)

