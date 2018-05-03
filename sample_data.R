library(tidyverse)

countries <- read_csv("data/countries.csv", na = "")
write.csv(countries, "sample_data/countries.csv")

clients <- read_csv("data/clients.csv")
selected_clients <- clients <- clients[1:5, ]
write_csv(selected_clients, "sample_data/clients.csv")

home_cities <- read_csv("data/home_cities_frequent.csv.gz", na = "")

selected_home_cities <- home_cities %>% 
  inner_join(select(selected_clients, client_id), by = "client_id") %>%
  .[sample(nrow(.), 500), ]

write_csv(selected_home_cities, "sample_data/home_cities_frequent.csv.gz")
