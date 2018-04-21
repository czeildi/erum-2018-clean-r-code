library("tidyverse")
library("plotly")

source("R/clean.R")

# load data ---------------------------------------------------------------

countries <- read_csv("data/countries.csv", na = "")
home_cities <- read_csv("data/home_cities_frequent.csv.gz", na = "")

# data preparation -----------------------------------------------------

show_rows_with_missing_value(countries)
show_rows_with_missing_value(home_cities)

show_cities_with_multiple_coords(home_cities)

# data exploration --------------------------------------------------------

ordered_city_populations <- home_cities %>% 
    group_by(country_code, city) %>% 
    summarize(num_contact = sum(num_contact)) %>% 
    arrange(desc(num_contact))

head(ordered_city_populations) %>% 
    inner_join(countries, by = "country_code")
tail(ordered_city_populations) %>% 
    inner_join(countries, by = "country_code")

ordered_country_populations <- home_cities %>% 
    group_by(country_code) %>% 
    summarize(num_contact = sum(num_contact)) %>% 
    arrange(desc(num_contact))

head(ordered_country_populations) %>% 
    inner_join(countries, by = "country_code")
tail(ordered_country_populations) %>% 
    inner_join(countries, by = "country_code")
