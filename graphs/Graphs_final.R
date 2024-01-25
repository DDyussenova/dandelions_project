library(tidyverse)
library(ggplot2)

color_low = "lightskyblue2"
color_high = "lightskyblue4"

graph1 <- read_csv("huge_csv.csv") |>
  filter(height != 0) |>
  mutate(BMI = (weight/1000)/(height^2)) |>
  mutate(weight_kg = weight/1000)

#BMI
BMI_filtered <- graph1 |> 
  filter(!is.na(BMI)) |> 
  mutate(BMI_bin = case_when(
    BMI < 18.5 ~ "<18",
    BMI >= 25.5 ~ "26>",
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
  aes(x = BMI_bin, y = average_money, fill =n) +
  scale_fill_gradient(low=color_low, high= color_high) +
  theme_light() +
  scale_x_discrete() +
  
  scale_y_continuous(labels = scales::number_format(scale = 1e-6, accuracy = 1, suffix = "")) + 
  stat_summary_bin(fun = "mean", geom = "col", binwidth = 1) +
  labs(y = "Average prize money (in millions USD)",
       x = "BMI") +
  geom_pointrange(aes(ymin = lower_money, ymax = upper_money, na.rm = NULL)) +
  geom_text(aes(label = n), y = 300000, color = 'white')

#HEIGHT
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
  aes(x = height_bin, y = average_money, fill =n) +
  scale_fill_gradient(low=color_low, high= color_high) +
  theme_light() +
  scale_x_discrete() +
  scale_y_continuous(labels = scales::number_format(scale = 1e-6, accuracy = 1, suffix = "")) + 
  stat_summary_bin(fun = "mean", geom = "col", binwidth = 5) +
  labs(y = "Average prize money (in millions USD)",
       x = "Height") +
  geom_pointrange(aes(ymin = lower_money, ymax = upper_money, na.rm = NULL)) +
  geom_text(aes(label = n), y = 170000, color = 'white')

#FOREHAND
forehand_filtered <- read_csv("huge_csv.csv") |> 
  group_by(forehand) |> 
  summarise(average_money = mean(prize_money),
            sd_money = sd(prize_money),
            n = n()) |>
  mutate(
    se_money = sd_money / sqrt(n),
    lower_money = average_money - se_money,
    upper_money = average_money + se_money)

ggplot(data = forehand_filtered) +
  aes(x = forehand, y = average_money, fill =n) +
  scale_fill_gradient(low=color_low, high= color_high) +
  theme_light()+
  scale_y_continuous(labels = scales::number_format(scale = 1e-6, accuracy = 0.1, suffix = ""))+
  geom_col()+
  geom_pointrange(aes(ymin = lower_money, ymax = upper_money))+
  annotate("text",                        
           x = NA, y = 150000, 
           label = "3362", 
           family = 'sans', 
           colour = 'white')+
  annotate("text", 
           x = 'double', y = 150000, 
           label = "55", 
           family = 'sans', 
           colour = 'white') + 
  labs(y = "Average career prize money (in million USD)",
       x = "Forehand")+
  scale_x_discrete(labels = c("double" = "Double"))

#BACKHAND
backhand_filtered <- read_csv('huge_csv.csv') |> 
  filter(!is.na(backhand)) |> 
  group_by(backhand) |>
  summarise(average_money = mean(prize_money),
            sd_money = sd(prize_money),
            n = n()) |>
  mutate(
    se_money = sd_money / sqrt(n),
    lower_money = average_money - se_money,
    upper_money = average_money + se_money)

ggplot(data = backhand_filtered) +
  aes(x = backhand, y = average_money, fill =n) +
  scale_fill_gradient(low=color_low, high= color_high) +
  theme_light()+
  geom_col()+
  geom_pointrange(aes(ymin = lower_money, ymax = upper_money))+
  scale_y_continuous(labels = scales::number_format(scale = 1e-6, accuracy = 0.1, suffix = ""))+
  annotate("text",                        
           x = 'single', y = 250000, 
           label = "480", 
           family = 'sans',
           color = 'white')+
  annotate("text", 
           x = 'double', y = 250000, 
           label = "1757", 
           family = 'sans',
           color = 'white') + 
  labs(y = "Average career prize money (in millions USD)",
       x = "Backhand") +
  scale_x_discrete(labels = c("double" = "Double", "single" = "Single"))

#DOMINANT_HAND
dominant_hand_filtered <- read_csv("huge_csv.csv") |> 
  filter(!is.na(dominant_hand)) |> 
  group_by(dominant_hand) |>
  summarise(average_money = mean(prize_money),
            sd_money = sd(prize_money),
            n = n()) |>
  mutate(
    se_money = sd_money / sqrt(n),
    lower_money = average_money - se_money,
    upper_money = average_money + se_money)

ggplot(data = dominant_hand_filtered) +
  aes(x = dominant_hand, y = average_money, fill =n) +
  scale_fill_gradient(low=color_low, high= color_high) +
  theme_light()+
  scale_y_continuous(labels = scales::number_format(scale = 1e-6, accuracy = 0.1, suffix = ""))+
  geom_col()+
  geom_pointrange(aes(ymin = lower_money, ymax = upper_money))+
  annotate("text",                        
           x = 'right', y = 100000, 
           label = "2584", 
           family = 'sans', 
           colour = 'white')+
  annotate("text", 
           x = 'left', y = 100000, 
           label = "368", 
           family = 'sans', 
           colour = 'white') +
  annotate("text", 
           x = 'ambidextrous', y = 100000, 
           label = "5", 
           family = 'sans', 
           colour = 'white') + 
  labs(x = 'Dominant hand',                                                    
       y = 'Average career prize money (in millions USD)') +
  scale_x_discrete(labels = c("ambidextrous" = "Ambidextrous", "left" = "Left", "right" = "Right"))

#COUNTRIES
gdp <- read_csv("gdp_with_category.csv") |>
  select(country = "Country Name", category) |>
  mutate(country = recode(country,
                          "Czechia" = "Czech Republic",
                          "Egypt, Arab Rep." = "Egypt",
                          "Hong Kong SAR, China" = "Hong Kong",
                          "Iran, Islamic Rep." = "Iran",
                          "Russian Federation" = "Russia",
                          "Cote d'Ivoire" = "Ivory Coast",
                          "Kyrgyz Republic" = "Kyrgyzstan",
                          "North Macedonia" = "Macedonia",
                          "Slovak Republic" = "Slovakia",
                          "Korea, Rep." = "South Korea",
                          "Bahamas, The" = "The Bahamas",
                          "Turkiye" = "Turkey",
                          "Viet Nam" = "Vietnam"))

countries_filtered <- read_csv("huge_csv.csv") |> 
  filter(!is.na(dominant_hand)) |> 
  group_by(dominant_hand) |>
  summarise(average_money = mean(prize_money),
            sd_money = sd(prize_money),
            n = n()) |>
  mutate(
    se_money = sd_money / sqrt(n),
    lower_money = average_money - se_money,
    upper_money = average_money + se_money)

data <- read_csv("huge_csv.csv") |>
  select(country, prize_money) |>
  na.omit() |>
  mutate(country = recode(country,
                          "Kingdom of Romania" = "Romania",
                          "Great Britain" = "United Kingdom",
                          "Chinese Taipei" = "Taiwan",
                          "Republic of Ireland" = "Ireland",
                          "Serbia and Montenegro" = "Serbia",
                          "Czechoslovakia" = "Czech Republic",
                          "Union of South Africa" = "South Africa"))

all_data <-merge(data, gdp, by="country", all.x = T) |>
  na.omit()

countries_filtered <- all_data |> 
  filter(!is.na(category)) |> 
  group_by(category) |>
  summarise(average_money = mean(prize_money),
            sd_money = sd(prize_money),
            n = n()) |>
  mutate(
    se_money = sd_money / sqrt(n),
    lower_money = average_money - se_money,
    upper_money = average_money + se_money)

merged <- merge(data, gdp, by="country", all.x = T) |>
  na.omit() |>
  group_by(category) |>
  summarise(mean_prize_money = mean(prize_money), n_players = length(country))

ggplot(data = countries_filtered) +
  aes(x = reorder(category, average_money), y = average_money, fill =n) +
  scale_fill_gradient(low=color_low, high= color_high) +
  labs(
    x = "Countries grouped by income",
    y = "Average prize money (in millions USD)"
  ) +
  geom_col()+
  geom_pointrange(aes(ymin = lower_money, ymax = upper_money))+
  theme_light() +
  scale_y_continuous(labels = scales::number_format(scale = 1e-6, accuracy = 0.1, suffix = ""))+
  geom_text(aes(label = n),
            y = 50000, color = "white")
