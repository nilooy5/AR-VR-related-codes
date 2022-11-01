# ========================================
# Check and install the required packages
# ========================================
# list of required packages
requiredPackages <- c("ggplot2", "shiny", "ggplot2", "gridExtra", "dplyr")

# check for each package and install if not present
# and display in console if already installed
for (pkg in requiredPackages) {
  #if the package is not installed then install the package
  if (!(pkg %in% rownames(installed.packages()))) {
    install.packages(pkg)
  }
  else {
    print(paste(pkg, "is already installed..."))
  }
}

# ==============
# load packages
# ==============
for (pkg in requiredPackages) {
  lapply(pkg, require, character.only = TRUE)
}

# load dataset
data(iris)


#UI page
ui <- fluidPage(

  titlePanel("IRIS Data"),

  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "species",
        label = "select species",
        choices = c("setosa", "versicolor", "virginica")
      ),

      #set slider inputs for varying all 4 values in the iris dataset
      sliderInput("sepal_length", "Sepal length",
                  min = 0.1, max = 5.0,
                  value = 0.5, step = 0.1),

      sliderInput("sepal_width", "Sepal Width",
                  min = 0.1, max = 5.0,
                  value = 0.5, step = 0.1),
      sliderInput("petal_length", "Petal length",
                  min = 0.1, max = 5.0,
                  value = 0.5, step = 0.1),

      sliderInput("petal_width", "Petal Width",
                  min = 0.1, max = 5.0,
                  value = 0.5, step = 0.1),

      textInput("Heading", "Title", value = "Enter the title", width = NULL, placeholder = NULL)
    ),

    #main panel for plotting the graph
    mainPanel(
      plotOutput(outputId = "plot1")
    )
  )
)


#server function
server <- function(input, output, session) {

  #filter the data set iris using species and sepal length
  filtered_by_SL <- reactive({
    iris %>%
      filter(Species %in% input$species) %>%
      filter(Sepal.Length <= input$sepal_length)

  })

  #filter the data set iris using species and sepal width
  filtered_by_SW <- reactive({
    iris %>%
      filter(Species %in% input$species) %>%
      filter(Sepal.Width <= input$sepal_width)

  })

  #filter the data set iris using species and petal length
  filtered_by_PL <- reactive({
    iris %>%
      filter(Species %in% input$species) %>%
      filter(Petal.Length <= input$petal_length)

  })
  #filter the data set iris using species and petal width
  filtered_by_PW <- reactive({
    iris %>%
      filter(Species %in% input$species) %>%
      filter(Petal.Width <= input$petal_width)

  })

  #function for updating slider inputs
  observe({

    d <- iris %>%
      filter(Species %in% input$species)

    updateSliderInput(session,
                      "sepal_length",
                      min = min(d$Sepal.Length),
                      max = max(d$Sepal.Length),
                      step = 0.1,
                      value = (min(d$Sepal.Length) + max(d$Sepal.Length)) / 2)

    updateSliderInput(session,
                      "sepal_width",
                      min = min(d$Sepal.Width),
                      max = max(d$Sepal.Width),
                      step = 0.1,
                      value = (min(d$Sepal.Width) + max(d$Sepal.Width)) / 2)

    updateSliderInput(session,
                      "petal_length",
                      min = min(d$Petal.Length),
                      max = max(d$Petal.Length),
                      step = 0.1,
                      value = (min(d$Petal.Length) + max(d$Petal.Length)) / 2)

    updateSliderInput(session,
                      "petal_width",
                      min = min(d$Petal.Width),
                      max = max(d$Petal.Width),
                      step = 0.1,
                      value = (min(d$Petal.Width) + max(d$Petal.Width)) / 2)

  })

  output$plot1 <- renderPlot({

    #render all plots using the dataframes ontained above
    gg1 <- ggplot(
      filtered_by_SL(),
      aes(x = seq(1, length(Sepal.Length)), y = Sepal.Length)) +
      geom_bar(stat = "identity",
               fill = "yellow",
               color = "black",
               alpha = .3) +
      labs(y = "Sepal Length") +
      labs(x = paste("total_count", nrow(filtered_by_SL()))) +
      theme_classic()

    gg2 <- ggplot(
      filtered_by_SW(),
      aes(x = seq(1, length(Sepal.Width)), y = Sepal.Width)) +
      geom_bar(stat = "identity",
               fill = "green",
               color = "black",
               alpha = .2) +
      labs(y = "Sepal Width") +
      labs(x = paste("total_count", nrow(filtered_by_SW()))) +
      theme_classic()

    gg3 <- ggplot(
      filtered_by_PL(),
      aes(x = seq(1, length(Petal.Length)), y = Petal.Length)) +
      geom_bar(stat = "identity",
               fill = "blue",
               color = "black",
               alpha = .3) +
      labs(y = "Petal Length") +
      labs(x = paste("total_count", nrow(filtered_by_PL()))) +
      theme_classic()

    gg4 <- ggplot(
      filtered_by_PW(),
      aes(x = seq(1, length(Petal.Width)), y = Petal.Width)) +
      geom_bar(stat = "identity",
               fill = "red",
               color = "black",
               alpha = .2) +
      labs(y = "Petal Width") +
      labs(x = paste("total_count", nrow(filtered_by_PW()))) +
      theme_classic()

    grid.arrange(gg1, gg2, gg3, gg4, nrow = 2, ncol = 2, top = input$Heading)
  })
}
shinyApp(ui = ui, server = server)
