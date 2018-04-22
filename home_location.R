library("tidyverse")
library("plotly")

purrr::walk(list.files("R", full.names = TRUE), source)

# load data ---------------------------------------------------------------

# NA is valid country code, stands for Namibia, so should not be read as NA
countries <- read_csv("data/countries.csv", na = "")
home_cities <- read_csv("data/home_cities_frequent.csv.gz", na = "")

# data preparation -----------------------------------------------------

get_rows_with_missing_value(countries)
get_rows_with_missing_value(home_cities)

get_cities_with_multiple_coords(home_cities)

# data exploration --------------------------------------------------------

glimpse_extreme_regions(home_cities, countries, country_code, city)
glimpse_extreme_regions(home_cities, countries, country_code)

home_cities %>% 
  summarize_population(country_code, city, long, lat) %>%
  filter(num_contact >= 1000) %>%
  plot_city_populations()

home_cities %>%
  summarize_population(country_code) %>%
  plot_country_populations(countries)

# capital city effect -----------------------------------------------------

population_share_of_strongest_city_in_country <- home_cities %>% 
  summarize_population(country_code, city) %>%
  group_by(country_code) %>%
  mutate(country_population = sum(num_contact)) %>%
  mutate(city_rank_in_country = min_rank(desc(num_contact))) %>%
  ungroup() %>%
  filter(city_rank_in_country == 1) %>%
  mutate(population_share = num_contact / country_population)

population_share_of_strongest_city_in_country %>%
  attach_country_metadata(countries) %>%
  plot_geo(locations = ~iso3c) %>% 
  add_trace(
    z = ~population_share, 
    text = ~paste(country, country_population, scales::percent(population_share), sep = "<br />")
  )
  
