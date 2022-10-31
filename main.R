install.packages("RCurl")
install.packages("tibble")
install.packages("threejs")
load("tibble")

library("RCurl")
library(threejs)
# read csv from github https://github.com/CSSEGISandData/COVID-19/blob/master/csse_covid_19_data/csse_covid_19_daily_reports/11-03-2020.csv

url <- "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/11-03-2020.csv"
covid <- getURL(url)
covid
download.file("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_daily_reports/11-03-2020.csv", destfile = "covid.csv", method = "curl")
covid <- read.csv("covid.csv")
# sort by confirmed cases
covidOrdered <- covid[order(-covid$Confirmed),]
# sort by confirmed cases in descending order
covid <- covid[order(-covid$Confirmed),]
top20 <- head(covidOrdered, 20)
# plot in globeJS
globejs(lat = top20$Lat, long = top20$Long_, color = "red", size = 0.5, bg = "black")
# plot arc in globeJS with with Canberra as the starting point
# get Canberra coordinates
canberra <- covid[covid$Province_State == "Australian Capital Territory",]
# make a new dataframe with latlong in first two columns of top20 and Canberra in the last two columns
arcLatlong <- cbind(top20$Lat, top20$Long_, canberra$Lat, canberra$Long_)
globejs(lat = top20$Lat,
        long = top20$Long_,
        arcs=arcLatlong,
        arcsHeight=0.5,
        arcsLwd=2,
        arcsColor="#00FF00", #ffff00
        arcsOpacity=0.35,
        atmosphere=TRUE)
