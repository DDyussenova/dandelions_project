library(tidyverse)

graph1 <- read_csv("height_money.csv") |>
  

print(graph1)

ggplot(data = graph1) +
  aes(x = Height, y = Money) +
  # labs(title = "Scatterplot of the total graduation rate vs the percentage of grants",
  #     x = "Total graduation rate",
  #     y = "Percentage of students with a grant") +
  geom_point()

