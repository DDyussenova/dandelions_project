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
  scale_y_continuous(labels = scales::number_format(scale = 1e-3, accuracy = 1, suffix = ""))+
  geom_col()+
  geom_pointrange(aes(ymin = lower_money, ymax = upper_money))+
  annotate("text",                        
           x = NA, y = 500000, 
           label = "n = 3362", 
           family = 'sans', 
           colour = 'white')+
  annotate("text", 
           x = 'double', y = 500000, 
           label = "n = 55", 
           family = 'sans', 
           colour = 'white') + 
  labs(y = "Average Career Prize Money \n(in Thousands of USD)",
       x = "Forehand")+
  scale_x_discrete(labels = c("double" = "Double"))
  
                   