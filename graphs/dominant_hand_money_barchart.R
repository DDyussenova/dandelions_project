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
  scale_y_continuous(labels = scales::number_format(scale = 1e-3, accuracy = 1, suffix = ""))+
  geom_col()+
  geom_pointrange(aes(ymin = lower_money, ymax = upper_money))+
  annotate("text",                        
           x = 'right', y = 200000, 
           label = "n = 2584", 
           family = 'sans', 
           colour = 'white')+
  annotate("text", 
           x = 'left', y = 200000, 
           label = "n = 368", 
           family = 'sans', 
           colour = 'white') +
  annotate("text", 
           x = 'ambidextrous', y = 200000, 
           label = "n = 5", 
           family = 'sans', 
           colour = 'white') + 
  labs(x = 'Dominant hand',                            
       y = 'Average Career Prize Money (USD)') 
  



