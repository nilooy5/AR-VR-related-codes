# clear global environment
rm(list=ls())

# Clear plots
if(!is.null(dev.list())) dev.off()

#clean Console  as command (CTRL + L)
cat("\014") 


# load dataset
data("iris")
# explore dataset
View(iris)

# create vectors 
x <- iris$Sepal.Length
y <- iris$Petal.Length
z <- iris$Sepal.Width


#************************ shiny package **********************
# load package
library(shiny)

ui <- fluidPage(
        titlePanel("My Take Home Shiny App!"),
        sidebarLayout(
                sidebarPanel(
                        selectInput("dataSet", 
                                    "Select the mumeric variable to plot:",
                                    choices = colnames(iris[1:4]))),
                mainPanel(plotOutput("plotOutput"))
        )
)

server <- function(input, output){
        output$plotOutput<-renderPlot({
                hist(iris[ ,input$dataSet],
                     main =paste("Histogram of", input$dataSet),
                     xlab=input$dataSet)
        })
}

shinyApp(ui = ui, server = server)
