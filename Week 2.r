#***********************************************************************
#   AR/VR for Data Analysis and Communication
#      
#   Week 2 - Take home exercise
#
#   Dr Raul Fernandez-Rojas
#***********************************************************************

# clear global environment
rm(list=ls())

# Clear plots
if(!is.null(dev.list())) dev.off()

#clean Console  as command (CTRL + L)
cat("\014") 


# load library
library(threejs)

# Plot flights to frequent destinations from
# Callum Prentice's global flight data set,
# http://callumprentice.github.io/apps/flight_stream/index.html
data(flights)


# combine the destination coordinates with a precision of two decimals
dest <- sprintf("%.2f:%.2f",flights[,3], flights[,4])

# convert to factor - make sure your variable can be used for the remaining operations
dest2 <- factor(dest)

# count the number of flights with the same destination
counts <- table(dest2)

# Obtain the top-10 most frequent destinations
freq <- sort(counts, decreasing=TRUE)
frequent_destinations <- names(freq)[1:10]
View(frequent_destinations)

# Find the indexes from the flight data by destination frequency
idx <- dest2 %in% frequent_destinations
frequent_flights <- flights[idx, ]

# Obtain the Lat/long of frequent destinations
latlong <- unique(frequent_flights[,3:4])
View(latlong)

# Plot frequent destinations as bars, and the flights to and from
# them as arcs. Adjust arc width and color by frequency.
earth <- system.file("images/world.jpg",  package="threejs")

globejs(lat=latlong[,1], 
        long=latlong[,2], 
        arcs=frequent_flights,
        arcsHeight=0.5, 
        arcsLwd=2,
        arcsColor="#00FF00", #ffff00 
        arcsOpacity=0.15,
        atmosphere=TRUE)

# for more information about globejs
?globejs