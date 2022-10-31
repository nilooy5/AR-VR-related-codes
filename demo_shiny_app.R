library(shiny)
library(plotly)

ui <- fluidPage(
  sidebarPanel("This is a sidebar"),
  mainPanel(plotlyOutput("myplot"))
)

server <- function(input, output, session){

  output$myplot <- renderPlotly({

    gg1 <- ggplotly(
      ggplot(iris, aes(x=Sepal.Length, y=Sepal.Width)) +
        geom_point() +
        theme_minimal()
    ) %>% add_annotations(
      text = "Plot 1",
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
      ggplot(iris, aes(x=Species, y=Sepal.Length)) +
        geom_boxplot() +
        theme_minimal()
    ) %>% add_annotations(
      text = "Plot 2",
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
      ggplot(iris, aes(x=Petal.Width)) +
        geom_histogram()
    ) %>% add_annotations(
      text = "Plot 3",
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
      ggplot(iris, aes(x=Petal.Length)) +
        geom_histogram()
    ) %>% add_annotations(
      text = "Plot 4",
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

    subplot(list(gg1,gg2,gg3,gg4), nrows = 2, margin = 0.06)
  })
}

shinyApp(ui = ui, server = server)
