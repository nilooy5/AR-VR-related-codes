## Only run examples in interactive R sessions
library(shiny)
if (interactive()) {
  options(device.ask.default = FALSE)

  # Define UI
  ui <- fluidPage(

    # Application title
    titlePanel("Hello Shiny!"),

    sidebarLayout(

      # Sidebar with 4 slider inputs of iris data
      sidebarPanel(
        sliderInput("sepal_length", "Sepal Length",
                    min(iris$Sepal.Length), max(iris$Sepal.Length), value = max(iris$Sepal.Length)),
        sliderInput("sepal_width", "Sepal Width",
                    min(iris$Sepal.Width), max(iris$Sepal.Width), value = max(iris$Sepal.Width)),
        sliderInput("petal_length", "Petal Length",
                    min(iris$Petal.Length), max(iris$Petal.Length), value = max(iris$Petal.Length)),
        sliderInput("petal_width", "Petal Width",
                    min(iris$Petal.Width), max(iris$Petal.Width), value = max(iris$Petal.Width))
      ),

      # Show 4 plots of iris data
      mainPanel(
        plotOutput("sepal_length_plot"),
        plotOutput("sepal_width_plot"),
        plotOutput("petal_length_plot"),
        plotOutput("petal_width_plot")
      )
    )
  )

  # Server logic
  server <- function(input, output) {
    output$sepal_length_plot <- renderPlot({
      #   filter rows such that sepal length is less than or equal to the slider value
      filtered_iris <- iris[iris$Sepal.Length <= input$sepal_length,]
      hist(filtered_iris$Sepal.Length, main = "Sepal Length")
    })
    output$sepal_width_plot <- renderPlot({
      filtered_iris <- iris[iris$Sepal.Width <= input$sepal_width,]
      hist(filtered_iris$Sepal.Width, main = "Sepal Width")
      # hist(iris$Sepal.Width, breaks = 20, col = 'darkgray', border = 'white')
    })
    output$petal_length_plot <- renderPlot({
      filtered_iris <- iris[iris$Petal.Length <= input$petal_length,]
      hist(filtered_iris$Petal.Length, main = "Petal Length")
      # hist(iris$Petal.Length, breaks = 20, col = 'darkgray', border = 'white')
    })
    output$petal_width_plot <- renderPlot({
      filtered_iris <- iris[iris$Petal.Width <= input$petal_width,]
      hist(filtered_iris$Petal.Width, main = "Petal Width")
      # hist(iris$Petal.Width, breaks = 20, col = 'darkgray', border = 'white')
    })
  }

  # Complete app with UI and server components
  shinyApp(ui, server)
}
