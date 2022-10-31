## Only run examples in interactive R sessions
library(shiny)
library(plotly)
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
      mainPanel(plotlyOutput("myplot"))
    )
  )

  # Server logic
  server <- function(input, output) {

    output$myplot <- renderPlotly({
      gg1 <- ggplotly(
        # Filter iris data by slider inputs
        ggplot(iris, aes(x = Sepal.Length)) +
          geom_histogram(binwidth = 1) +
          xlim(min(iris$Sepal.Length), input$sepal_length)
      ) %>% add_annotations(
        text = "Sepal.Length",
        x = 0,
        y = 1,
        yref = "paper",
        xref = "paper",
        xanchor = "left",
        yanchor = "top",
        yshift = 20,
        showarrow = FALSE,
        font = list(size = 15)
      )
      gg2 <- ggplotly(
        ggplot(iris, aes(x = Sepal.Width)) +
          geom_histogram(binwidth = 1) +
          xlim(min(iris$Sepal.Width), input$sepal_width)
      ) %>% add_annotations(
        text = "Sepal.Width",
        x = 0,
        y = 1,
        yref = "paper",
        xref = "paper",
        xanchor = "left",
        yanchor = "top",
        yshift = 20,
        showarrow = FALSE,
        font = list(size = 15)
      )
      gg3 <- ggplotly(
        ggplot(iris, aes(x = Petal.Length)) +
          geom_histogram(binwidth = 1) +
          xlim(min(iris$Petal.Length), input$petal_length)
      ) %>% add_annotations(
        text = "Petal.Length",
        x = 0,
        y = 1,
        yref = "paper",
        xref = "paper",
        xanchor = "left",
        yanchor = "top",
        yshift = 20,
        showarrow = FALSE,
        font = list(size = 15)
      )
      gg4 <- ggplotly(
        ggplot(iris, aes(x = Petal.Width)) +
          geom_histogram(binwidth = 1) +
          xlim(min(iris$Petal.Width), input$petal_width)
      ) %>% add_annotations(
        text = "Petal.Width",
        x = 0,
        y = 1,
        yref = "paper",
        xref = "paper",
        xanchor = "left",
        yanchor = "top",
        yshift = 20,
        showarrow = FALSE,
        font = list(size = 15)
      )

      subplot(list(gg1, gg2, gg3, gg4), nrows = 2, margin = 0.06)
    })
  }

  # Complete app with UI and server components
  shinyApp(ui, server)
}
