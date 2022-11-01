library(lubridate)
library(dplyr)
library(readr)
library(ggplot2)
require(reshape2)

q6_data <- read_csv("data/q6_data.csv")
colnames(q6_data) <- tolower(colnames(q6_data))
q6_data <- melt(q6_data, id = "date")

ggplot() + geom_bar(data = q6_data, aes(x = date, y = value, fill = variable), position = "dodge", stat = "identity")