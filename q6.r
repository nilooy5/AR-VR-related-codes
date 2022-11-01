library(lubridate)
library(dplyr)
library(readr)
library(ggplot2)
require(reshape2)

q6_data <- read_csv("data/q6_data.csv")
colnames(q6_data) <- tolower(colnames(q6_data))
cap <- q6_data$capacity
dem <- q6_data$demand
q6_data <- melt(q6_data, id = "date")

q6_data %>%
  ggplot() +
  geom_bar(aes(x = date, y = value, fill = variable), width = 0.7, position = "dodge", stat = "identity") +
  geom_hline(yintercept = mean(dem), linetype = "dashed", color = "#00bfc4") +
  geom_hline(yintercept = mean(cap), linetype = "dashed", color = "#f8766d") +
  theme(plot.title = element_text(hjust = 0.5)) +
  geom_text(aes(x = date, y = value, label = value), position = position_dodge(width = 0.9), vjust = -0.25, size=4) +
  labs(title = "Capacity and Demand of different months", x = "date", y = "Capacity and Demand") +
  coord_flip()
