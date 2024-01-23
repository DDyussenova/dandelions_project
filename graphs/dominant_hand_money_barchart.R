#dominant hand x money prize 

library(tidyverse)

tennis_players_data <- read_csv("data/huge_csv.csv")

dominant_hand_filtered <- tennis_players_data |> 
  filter(!is.na(dominant_hand)) |> 
  print()

count(dominant_hand_filtered, dominant_hand)

ggplot(data = dominant_hand_filtered) +
  aes(x = dominant_hand, y = prize_money) +
  theme_light()+
  geom_bar(stat = "summary", fun = mean) + 
  annotate("text",                        
           x = 'right', y = 1550000, 
           label = "n = 2584", 
           family = 'sans')+
  annotate("text", 
           x = 'left', y = 1700000, 
           label = "n = 368", 
           family = 'sans') +
  annotate("text", 
           x = 'ambidextrous', y = 440000, 
           label = "n = 5", 
           family = 'sans') + 
  labs(x = 'Dominant hand',                            
       y = 'Average Career Prize Money (USD)') 
  



