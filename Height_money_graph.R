library(tidyverse)
library(ggplot2)

graph1 <- read_csv("huge_csv.csv") |>
  filter(height != 0) |>
  mutate(BMI = (weight/1000)/(height^2))

print(graph1)

ggplot(data = graph1) +
  aes(x = height, y = prize_money) +
  scale_y_log10() +
  theme_light() +
  geom_point(position = position_jitter(0.008)) +
  geom_smooth(method = "lm")

ggplot(data = graph1) +
  aes(x = height, y = prize_money) +
  theme_light() +
  scale_x_continuous(breaks = seq(1.5, 2.1, by = 0.05)) +
  stat_summary_bin(fun = "mean", geom = "col", binwidth = 0.05) +
  labs(y = "Average Prize Money",
       x = "Height")

ggplot(data = graph1) +
  aes(x = BMI, y = prize_money) +
  theme_light() +
  scale_x_continuous(breaks = seq(15, 35, by = 2)) +
  stat_summary_bin(fun = "mean", geom = "col", binwidth = 2) +
  labs(y = "Average Prize Money",
       x = "BMI")

            