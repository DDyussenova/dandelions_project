library(tidyverse)
library(ggplot2)

graph1 <- read_csv("huge_csv.csv") |>
  filter(height != 0)

print(graph1)

ggplot(data = graph1) +
  aes(x = height, y = prize_money) +
  scale_y_log10() +
  theme_light() +
  geom_point()

ggplot(data = graph1) +
  aes(x = height, y = prize_money) +
  theme_light() +
  scale_x_continuous(breaks = seq(1.5, 2.1, by = 0.05)) +
  stat_summary(fun = "mean", geom = "col") +
  geom_col(width = 0.05) +
  labs(y = "Average Prize Money",
       x = "Height")
