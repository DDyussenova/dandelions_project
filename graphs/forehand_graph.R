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

ggplot(data = forehand_filtered) +
  aes(x = forehand, y = average_money) +
  theme_light()+
  geom_col()+
  geom_pointrange(aes(ymin = lower_money, ymax = upper_money))+
  annotate("text",                        
           x = NA, y = 1900000, 
           label = "n = 3362", 
           family = 'sans')+
  annotate("text", 
           x = 'double', y = 2100000, 
           label = "n = 55", 
           family = 'sans') + 
  labs(y = "Average Career Prize Money (USD)",
       x = "Forehand")
  