library(tidyverse)
library(ggplot2)

graph1 <- read_csv("huge_csv.csv") |>
  filter(height != 0) |>
  mutate(BMI = (weight/1000)/(height^2)) |>
  mutate(weight_kg = weight/1000)

#Graph BMI/Money
BMI_filtered <- graph1 |> 
  filter(!is.na(BMI)) |> 
  mutate(BMI_bin = round((BMI + 1) / 2) * 2 - 1) |>
  group_by(BMI_bin) |>
  summarise(average_money = mean(prize_money),
            sd_money = sd(prize_money),
            n = n()) |>
  mutate(
    se_money = sd_money / sqrt(n),
    lower_money = average_money - se_money,
    upper_money = average_money + se_money)

ggplot(data = BMI_filtered) +
  aes(x = BMI_bin, y = average_money) +
  theme_light() +
  scale_x_continuous(breaks = seq(15, 35, by = 2)) +
  scale_y_continuous(labels = scales::number_format(scale = 1e-6, accuracy = 1, suffix = "")) + 
  stat_summary_bin(fun = "mean", geom = "col", binwidth = 2) +
  labs(y = "Average Prize Money (in millions USD)",
       x = "BMI") +
  geom_pointrange(aes(ymin = lower_money, ymax = upper_money, na.rm = NULL)) +
  geom_text(aes(label = n),
            y = 5.05e+06)

#Graph Height/Money 
ggplot(data = graph1) +
  aes(x = height, y = prize_money) +
  scale_y_log10() +
  theme_light() +
  geom_point(position = position_jitter(0.008)) +
  geom_smooth(method = "lm") +
  labs(x = "Height (m)",
       y = "Prize Money (usd)")

ggplot(data = graph1) +
  aes(x = weight_kg, y = prize_money) +
  scale_y_log10() +
  theme_light() +
  geom_point(position = position_jitter(0.01)) +
  geom_smooth(method = "lm") +
  labs(x = "Weight (kg)",
       y = "Prize Money (usd)")

ggplot(data = graph1) +
  aes(x = height, y = prize_money) +
  theme_light() +
  scale_x_continuous(breaks = seq(1.5, 2.1, by = 0.05)) +
  stat_summary_bin(fun = "mean", geom = "col", binwidth = 0.05) +
  labs(y = "Average Prize Money (usd)",
       x = "Height (m)")

ggplot(data = graph1) +
  aes(x = weight_kg, y = prize_money) +
  theme_light() +
  scale_x_continuous(breaks = seq(45, 105, by = 5)) +
  stat_summary_bin(fun = "mean", geom = "col", binwidth = 5) +
  labs(y = "Average Prize Money (usd)",
       x = "Weight (kg)")

ggplot(data = graph1) +
  aes(x = year, y = prize_money) +
  theme_light() +
  scale_x_continuous(breaks = seq(1930, 2000, by = 10)) +
  stat_summary_bin(fun = "mean", geom = "col", binwidth = 5) +
  labs(y = "Average Prize Money (usd)",
       x = "Birth Year")

ggplot(data = graph1) +
  aes(x = month, y = prize_money) +
  theme_light() +
  scale_x_continuous(breaks = seq(1, 12, by = 1)) +
  stat_summary_bin(fun = "mean", geom = "col", binwidth = 1) +
  labs(y = "Average Prize Money (usd)",
       x = "Birth Month")
