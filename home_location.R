library("tidyverse")
library("plotly")

# load data ---------------------------------------------------------------

countries <- read_csv("data/countries.csv", na = "")
home_cities <- read_csv("data/home_cities_frequent.csv.gz", na = "")

# data preparation -----------------------------------------------------

countries[!complete.cases(countries), ]
home_cities[!complete.cases(home_cities), ]

home_cities %>% 
    group_by(country_code, city) %>% 
    summarize(num_coord_per_city = n_distinct(long, lat)) %>% 
    filter(num_coord_per_city > 1)

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
