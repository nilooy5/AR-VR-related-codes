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

      textInput("Heading", "Set Title", value = "Histogram of Different Variables", width = NULL, placeholder = NULL)
    ),

    #main panel for plotting the graph
    mainPanel(
      plotOutput(outputId = "main_plot")
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

    filtered_by_species <- iris %>%
      filter(Species %in% input$species)

    updateSliderInput(session,
                      "sepal_length",
                      min = min(filtered_by_species$Sepal.Length),
                      max = max(filtered_by_species$Sepal.Length),
                      step = 0.1,
                      value = mean(filtered_by_species$Sepal.Length))

    updateSliderInput(session,
                      "sepal_width",
                      min = min(filtered_by_species$Sepal.Width),
                      max = max(filtered_by_species$Sepal.Width),
                      step = 0.1,
                      value = mean(filtered_by_species$Sepal.Width))

    updateSliderInput(session,
                      "petal_length",
                      min = min(filtered_by_species$Petal.Length),
                      max = max(filtered_by_species$Petal.Length),
                      step = 0.1,
                      value = mean(filtered_by_species$Petal.Length))

    updateSliderInput(session,
                      "petal_width",
                      min = min(filtered_by_species$Petal.Width),
                      max = max(filtered_by_species$Petal.Width),
                      step = 0.1,
                      value = mean(filtered_by_species$Petal.Width))

  })

  output$main_plot <- renderPlot({
    #render all plots using the dataframes ontained above
    gg1 <- ggplot(
      filtered_by_SL(),
      aes(x = Sepal.Length)) +
      geom_histogram(fill = "yellow", color="black", alpha = 0.5, binwidth = .1) +
      labs(y = paste("count (total = ", nrow(filtered_by_SL()),")")) +
      labs(x = "Sepal Length") +
      theme_classic()

    gg2 <- ggplot(
      filtered_by_SW(),
      aes(x = Sepal.Width)) +
      geom_histogram(fill = "green", color="black", alpha = 0.5, binwidth = .1) +
      labs(y = paste("count (total = ", nrow(filtered_by_SW()), ")")) +
      labs(x = "Sepal Width") +
      theme_classic()

    gg3 <- ggplot(
      filtered_by_PL(),
      aes(x = Petal.Length)) +
      geom_histogram(fill = "blue", color="black", alpha = 0.5, binwidth = .1) +
      labs(y = paste("count (total = ", nrow(filtered_by_PL()), ")")) +
      labs(x = "Petal Length") +
      theme_classic()

    gg4 <- ggplot(
      filtered_by_PW(),
      aes(x = Petal.Width)) +
      geom_histogram(fill = "red", color="black", alpha = 0.5, binwidth = .05) +
      labs(y = paste("count (total = ", nrow(filtered_by_PW()), ")")) +
      labs(x = "Petal Width") +
      theme_classic()

    grid.arrange(gg1, gg2, gg3, gg4, nrow = 2, ncol = 2, top = input$Heading)
  })
}
shinyApp(ui = ui, server = server)
