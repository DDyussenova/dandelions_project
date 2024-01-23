library(tidyverse)
library(ggplot2)

graph1 <- read_csv("huge_csv.csv") |>
  filter(height != 0) |>
  mutate(BMI = (weight/1000)/(height^2)) |>
  mutate(weight_kg = weight/1000)

ggplot(data = graph1) +
  aes(x = height, y = prize_money) +
  scale_y_log10() +
  theme_light() +
  geom_point(position = position_jitter(0.008)) +
  geom_smooth(method = "lm") +
  labs(x = "Height",
       y = "Prize Money")

ggplot(data = graph1) +
  aes(x = weight_kg, y = prize_money) +
  scale_y_log10() +
  theme_light() +
  geom_point(position = position_jitter(0.01)) +
  geom_smooth(method = "lm") +
  labs(x = "Weight",
       y = "Prize Money")

ggplot(data = graph1) +
  aes(x = height, y = prize_money) +
  theme_light() +
  scale_x_continuous(breaks = seq(1.5, 2.1, by = 0.05)) +
  stat_summary_bin(fun = "mean", geom = "col", binwidth = 0.05) +
  labs(y = "Average Prize Money",
       x = "Height")

ggplot(data = graph1) +
  aes(x = weight_kg, y = prize_money) +
  theme_light() +
  scale_x_continuous(breaks = seq(45, 105, by = 5)) +
  stat_summary_bin(fun = "mean", geom = "col", binwidth = 5) +
  labs(y = "Average Prize Money",
       x = "Weight")

ggplot(data = graph1) +
  aes(x = BMI, y = prize_money) +
  theme_light() +
  scale_x_continuous(breaks = seq(15, 35, by = 2)) +
  stat_summary_bin(fun = "mean", geom = "col", binwidth = 2) +
  labs(y = "Average Prize Money",
       x = "BMI")

ggplot(data = graph1) +
  aes(x = year, y = prize_money) +
  theme_light() +
  scale_x_continuous(breaks = seq(1930, 2000, by = 10)) +
  stat_summary_bin(fun = "mean", geom = "col", binwidth = 5) +
  labs(y = "Average Prize Money",
       x = "Birth Year")

ggplot(data = graph1) +
  aes(x = month, y = prize_money) +
  theme_light() +
  scale_x_continuous(breaks = seq(1, 12, by = 1)) +
  stat_summary_bin(fun = "mean", geom = "col", binwidth = 1) +
  labs(y = "Average Prize Money",
       x = "Birth Month")
