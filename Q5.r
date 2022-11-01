# devtools::install_github("ACEMS/r2vr")
library(r2vr)
library(jsonlite)
library(ggplot2)

a_scatterplot <- function(json_data, x, y, z, ...) {
  ## js sources for scatterplot.
  .scatter_source <- "https://cdn.rawgit.com/zcanter/aframe-scatterplot/master/dist/a-scatterplot.min.js"
  .d3_source <- "https://cdnjs.cloudflare.com/ajax/libs/d3/4.4.1/d3.min.js"
  ## Create in-memory asset for JSON data
  # ## A regular a_asset could be used that points to a real file
  # ## this is necessary in a vignette to avoid CRAN issues.
  json_file_asset <- a_in_mem_asset(id = "scatterdata",
                                    src = "./scatter_data.json",
                                    .data = json_data)
  a_entity(.tag = "scatterplot",
           src = json_file_asset,
           .js_sources = list(.scatter_source, .d3_source),
           x = x, y = y, z = z, ...)
}

# end of function
# convert the dataset into a JSON file
work_data <- iris
# work_data
# change names of columns Petal.Width, Sepal.Width, Petal.Length to x, y, z
names(work_data)[names(work_data) == "Petal.Width"] <- "x"
names(work_data)[names(work_data) == "Sepal.Width"] <- "y"
names(work_data)[names(work_data) == "Petal.Length"] <- "z"
work_data$size <- 0.2
work_data$color <- "#ff0000"
# conver species to factor
# if work_data$Species is setosa, versicolor or virginica, then it will be 1, 2 or 3
work_data$Species <- as.factor(work_data$Species)
# convert factor to numeric
work_data$Species <- as.numeric(work_data$Species)
# if species is 1, 2, 3 then color is #ff0000, #00ff00, #4CC3D9
work_data$color[work_data$Species == 1] <- "#ff0000"
work_data$color[work_data$Species == 2] <- "#00ff00"
work_data$color[work_data$Species == 3] <- "#4CC3D9"
work_data


iris_json <- jsonlite::toJSON(work_data)
# create scene
my_scene <- a_scene(.template = "empty",
                    .children = list(
                      a_scatterplot(iris_json, # dataset
                                    x = "x",
                                    y = "y",
                                    z = "z", # choose columns in your dataset
                                    val = "Species", # colour scale
                                    xlabel = "Petal.Length", ylabel = "Petal.Width", zlabel = "Sepal.Width", #axis labels
                                    showFloor = TRUE,
                                    ycage = TRUE,
                                    title = "Iris dataset with it's species variables",
                                    pointsize = "10", # try different values
                                    position = c(0, 0, -2),
                                    scale = c(2, 2, 2)
                      ),
                      a_pc_control_camera()))
# Serve a scene
my_scene$serve()
# Shift + Click to open it in your web browser # http://127.0.0.1:8080
# Stop serving a scene
# my_scene$stop()
