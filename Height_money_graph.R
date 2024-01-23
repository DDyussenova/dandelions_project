library(tidyverse)

graph1 <- read_csv("height_money.csv") |>
  filter(Height != 0) |>
  filter(Title != 'Andrei_Chesnokov')
  

print(graph1)

ggplot(data = graph1) +
  aes(x = Height, y = Money) +
  scale_y_log10() +
  theme_light() +
  geom_point()
