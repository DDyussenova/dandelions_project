library(tidyverse)
gdp <- read_csv("dandelions_project/data/gdp_with_category.csv") |>
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

data <- read_csv("dandelions_project/data/huge_csv.csv") |>
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

merged <- merge(data, gdp, by="country", all.x = T) |>
  na.omit() |>
  group_by(category) |>
  summarise(mean_prize_money = mean(prize_money), n_players = length(country))

ggplot(data = merged) +
  aes(x = reorder(category, mean_prize_money), y = mean_prize_money) +
  labs(
    x = "Category",
    y = "Average Prize Money"
  ) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = n_players),
            y = 50000, color = "white")

