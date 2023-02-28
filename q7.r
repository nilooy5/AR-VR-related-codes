library(lubridate)
library(dplyr)
library(readr)
library(ggplot2)
require(reshape2)

q7 <- read_csv("data7.csv")
# remove percent sign from 2nd to last column
q7[,2:ncol(q7)] <- sapply(q7[,2:ncol(q7)], function(x) as.numeric(gsub("%", "", x)))
# gather data and plot them
q7 %>%
  rstatix::gather(key = "year", value = "percent", -`Research centre`) %>%
  ggplot(aes(x = year, y = percent, color = `Research centre`, group = `Research centre`)) +
  geom_line() +
  geom_point(size=2) +
  theme(text = element_text(size=15)) +
  labs(title = "Cholesterol rates by Research Center", x = "year", y = "rate of change (%)") +
  theme(plot.title = element_text(hjust = 0.5)) +
  # add trendline to "ALL" data
  geom_smooth(method = "lm", formula = y ~ x, se = FALSE, color = "black", linetype = "dashed", size = .25)
