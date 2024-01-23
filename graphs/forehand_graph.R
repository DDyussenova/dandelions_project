#forehand type x money 

library(tidyverse)

tennis_players_data <- read_csv("data/huge_csv.csv")

forehand_filtered <- tennis_players_data |> 
  group_by(forehand) |> 
  summarise(average_money = mean(prize_money),
            sd_money = sd(prize_money),
            n = n()) |>
  mutate(
    se_money = sd_money / sqrt(n),
    lower_money = average_money - se_money,
    upper_money = average_money + se_money) |>
  print()
  print()
  