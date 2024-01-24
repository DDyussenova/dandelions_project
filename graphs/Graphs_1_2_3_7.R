library(tidyverse)
library(ggplot2)

graph1 <- read_csv("huge_csv.csv") |>
  filter(height != 0) |>
  mutate(BMI = (weight/1000)/(height^2)) |>
  mutate(weight_kg = weight/1000)

#Graph BMI/Money
BMI_filtered <- graph1 |> 
  filter(!is.na(BMI)) |> 
  mutate(BMI_bin = case_when(
    BMI < 18.5 ~ "<18",
    BMI >= 27.5 ~ "28>",
    TRUE ~ as.character(round(BMI))
  )) |>
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
  scale_x_discrete() +
  scale_y_continuous(labels = scales::number_format(scale = 1e-6, accuracy = 1, suffix = "")) + 
  stat_summary_bin(fun = "mean", geom = "col", binwidth = 1) +
  labs(y = "Average prize money (in millions USD)",
       x = "BMI") +
  geom_pointrange(aes(ymin = lower_money, ymax = upper_money, na.rm = NULL)) +
  geom_text(aes(label = n), y = 300000, color = 'white')

# #Graph Height/Money 
# ggplot(data = graph1) +
#   aes(x = height, y = prize_money) +
#   scale_y_log10() +
#   theme_light() +
#   geom_point(position = position_jitter(0.008)) +
#   geom_smooth(method = "lm") +
#   labs(x = "Height (m)",
#        y = "Prize Money (usd)")

# ggplot(data = graph1) +
#   aes(x = weight_kg, y = prize_money) +
#   scale_y_log10() +
#   theme_light() +
#   geom_point(position = position_jitter(0.01)) +
#   geom_smooth(method = "lm") +
#   labs(x = "Weight (kg)",
#        y = "Prize Money (usd)")

height_filtered <- graph1 |> 
  filter(!is.na(height)) |> 
  mutate(height_bin = case_when(
    height >= 1.975 ~ "200>",
    height < 1.625 ~ "<160",
    TRUE ~ as.character(round(height*20)*5)
  )) |>
  group_by(height_bin) |>
  summarise(average_money = mean(prize_money),
            sd_money = sd(prize_money),
            n = n()) |>
  mutate(
    se_money = sd_money / sqrt(n),
    lower_money = average_money - se_money,
    upper_money = average_money + se_money)

ggplot(data = height_filtered) +
  aes(x = height_bin, y = average_money) +
  theme_light() +
  scale_x_discrete() +
  scale_y_continuous(labels = scales::number_format(scale = 1e-6, accuracy = 1, suffix = "")) + 
  stat_summary_bin(fun = "mean", geom = "col", binwidth = 5) +
  labs(y = "Average prize money (in millions USD)",
       x = "Height") +
  geom_pointrange(aes(ymin = lower_money, ymax = upper_money, na.rm = NULL)) +
  geom_text(aes(label = n), y = 170000, color = 'white')

# ggplot(data = graph1) +
#   aes(x = weight_kg, y = prize_money) +
#   theme_light() +
#   scale_x_continuous(breaks = seq(45, 105, by = 5)) +
#   stat_summary_bin(fun = "mean", geom = "col", binwidth = 5) +
#   labs(y = "Average Prize Money (usd)",
#        x = "Weight (kg)")

# ggplot(data = graph1) +
#   aes(x = year, y = prize_money) +
#   theme_light() +
#   scale_x_continuous(breaks = seq(1930, 2000, by = 10)) +
#   stat_summary_bin(fun = "mean", geom = "col", binwidth = 5) +
#   labs(y = "Average Prize Money (usd)",
#        x = "Birth Year")

# ggplot(data = graph1) +
#   aes(x = month, y = prize_money) +
#   theme_light() +
#   scale_x_continuous(breaks = seq(1, 12, by = 1)) +
#   stat_summary_bin(fun = "mean", geom = "col", binwidth = 1) +
#   labs(y = "Average Prize Money (usd)",
#        x = "Birth Month")

