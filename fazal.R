install.packages("threejs")
library("plot3D")
# load("iris")
data("iris")
x <- iris$Sepal.Length
y <- iris$Petal.Length
z <- iris$Sepal.Width
library(threejs)
N <- length((levels(iris$Species)))
scatterplot3js(x,y,z, size = 0.6, color = rainbow(N)[iris$Species])
scatterplot3js(x,y,z, size = 0.6, color = rainbow(N)[iris$Species])
scatterplot3js(x,y,z, size = 0.6, color = rainbow(N)[iris$Species], pch = "@")
data(ego)
graphjs(ego, bg = "black")
install.packages("maps")
data(world.cities, package = "maps")
cities <- world.cities[order(world.cities$pop, decreasing = TRUE)[1:"500"],]
value <- 100 * cities$pop / max(cities$pop)
globejs(bg = "white", lat = cities$lat, long = cities$long, rotationlat = -.34, rotationlong = -0.38, fov = 30)
# savehistory("//studentfiles.win.canberra.edu.au/Homes$/u3228358/My Documents/fazal.R")


# order status