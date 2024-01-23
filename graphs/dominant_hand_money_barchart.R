#dominant hand x money prize 

library(tidyverse)

tennis_players_data <- read_csv("data/huge_csv.csv")

dominant_hand_filtered <- tennis_players_data |> 
  filter(!is.na(dominant_hand)) |> 
  group_by(dominant_hand) |>
  summarise(average_money = mean(prize_money),
            sd_money = sd(prize_money),
            n = n()) |>
  mutate(
    se_money = sd_money / sqrt(n),
    lower_money = average_money - se_money,
    upper_money = average_money + se_money) |>
  print()

ggplot(data = dominant_hand_filtered) +
  aes(x = dominant_hand, y = average_money) +
  theme_light()+
  geom_col()+
  geom_pointrange(aes(ymin = lower_money, ymax = upper_money))+
  annotate("text",                        
           x = 'right', y = 1800000, 
           label = "n = 2584", 
           family = 'sans')+
  annotate("text", 
           x = 'left', y = 2000000, 
           label = "n = 368", 
           family = 'sans') +
  annotate("text", 
           x = 'ambidextrous', y = 660000, 
           label = "n = 5", 
           family = 'sans') + 
  labs(x = 'Dominant hand',                            
       y = 'Average Career Prize Money (USD)') 
  



