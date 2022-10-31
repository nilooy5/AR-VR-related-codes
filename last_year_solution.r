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
      sliderInput("lengths1", "Sepal length",
                  min = 0.1, max = 5.0,
                  value = 0.5, step = 0.1),

      sliderInput("lengths2", "Sepal Width",
                  min = 0.1, max = 5.0,
                  value = 0.5, step = 0.1),
      sliderInput("lengths3", "Petal length",
                  min = 0.1, max = 5.0,
                  value = 0.5, step = 0.1),

      sliderInput("lengths4", "Petal Width",
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
  dff1 <- reactive({
    iris %>%
      filter(Species %in% input$species) %>%
      filter(Sepal.Length <= input$lengths1)

  })

  #filter the data set iris using species and sepal width
  dff2 <- reactive({
    iris %>%
      filter(Species %in% input$species) %>%
      filter(Sepal.Width <= input$lengths2)

  })

  #filter the data set iris using species and petal length
  dff3 <- reactive({
    iris %>%
      filter(Species %in% input$species) %>%
      filter(Petal.Length <= input$lengths3)

  })
  #filter the data set iris using species and petal width
  dff4 <- reactive({
    iris %>%
      filter(Species %in% input$species) %>%
      filter(Petal.Width <= input$lengths4)

  })

  #function for updating slider inputs
  observe({

    d <- iris %>%
      filter(Species %in% input$species)

    updateSliderInput(session, "lengths1", min = min(d$Sepal.Length),
                      max = max(d$Sepal.Length), step = 0.1, value = (min(d$Sepal.Length) + max(d$Sepal.Length)) / 2)

    updateSliderInput(session, "lengths2", min = min(d$Sepal.Width),
                      max = max(d$Sepal.Width), step = 0.1, value = (min(d$Sepal.Width) + max(d$Sepal.Width)) / 2)

    updateSliderInput(session, "lengths3", min = min(d$Petal.Length),
                      max = max(d$Petal.Length), step = 0.1, value = (min(d$Petal.Length) + max(d$Petal.Length)) / 2)

    updateSliderInput(session, "lengths4", min = min(d$Petal.Width),
                      max = max(d$Petal.Width), step = 0.1, value = (min(d$Petal.Width) + max(d$Petal.Width)) / 2)

  }

  )


  output$plot1 <- renderPlot({

    #render all plots using the dataframes ontained above
    gg1 <- ggplot(
      dff1(),
      aes(x = seq(1, length(Sepal.Length)), y = Sepal.Length)) +
      geom_bar(stat = "identity", fill = "yellow", color = "black", alpha = .3) +
      labs(y = "Sepal Length") +
      labs(x = paste("total_count", nrow(dff1()))) +
      theme_classic()

    gg2 <- ggplot(
      dff2(),
      aes(x = seq(1, length(Sepal.Width)), y = Sepal.Width)) +
      geom_bar(stat = "identity", fill = "green", color = "black", alpha = .2) +
      labs(y = "Sepal Width") +
      labs(x = paste("total_count", nrow(dff2()))) +
      theme_classic()

    gg3 <- ggplot(
      dff3(),
      aes(x = seq(1, length(Petal.Length)), y = Petal.Length)) +
      geom_bar(stat = "identity", fill = "blue", color = "black", alpha = .3) +
      labs(y = "Petal Length") +
      labs(x = paste("total_count", nrow(dff3()))) +
      theme_classic()

    gg4 <- ggplot(
      dff4(),
      aes(x = seq(1, length(Petal.Width)), y = Petal.Width)) +
      geom_bar(stat = "identity", fill = "red", color = "black", alpha = .2) +
      labs(y = "Petal Width") +
      labs(x = paste("total_count", nrow(dff4()))) +
      theme_classic()

    grid.arrange(gg1, gg2, gg3, gg4, nrow = 2, ncol = 2, top = input$Heading)
  })
}
shinyApp(ui = ui, server = server)
