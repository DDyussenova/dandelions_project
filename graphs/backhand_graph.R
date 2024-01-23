#backhand_type and money barchart

library(tidyverse)

tennis_players_data <- read_csv('data/huge_csv.csv')

backhand_filtered <- tennis_players_data |> 
  filter(!is.na(backhand)) |> 
  group_by(backhand) |>
  summarise(average_money = mean(prize_money),
            sd_money = sd(prize_money),
            n = n()) |>
  #mutate(margin_of_error = qt(0.975, df = n - 1) * (sd_money / sqrt(n)))
  mutate(
    se_money = sd_money / sqrt(n),
    lower_money = average_money - se_money,
    upper_money = average_money + se_money
  )

ggplot(data = backhand_filtered) +
  aes(x = backhand, y = average_money) +
  theme_light()+
  geom_col()+
  geom_pointrange(aes(ymin = lower_money, ymax = upper_money))


  
  annotate("text",                        
           x = 'single', y = 3000000, 
           label = "n = 480", 
           family = 'sans')+
  annotate("text", 
           x = 'double', y = 1700000, 
           label = "n = 1759", 
           family = 'sans') 