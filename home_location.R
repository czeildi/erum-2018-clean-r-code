library("tidyverse")
library("plotly")

source("R/clean.R")

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
  plot_geo(lat = ~lat, lon = ~long) %>%
  add_markers(
    size = ~log10(num_contact),
    color = ~log10(num_contact),
    text = ~str_c(country_code, city, num_contact, sep = "<br />")
  ) %>% 
  colorbar(title = "Population", tickprefix = "10^")

home_cities %>%
  summarize_population(country_code) %>%
  attach_country_metadata(countries) %>%
  plot_geo(locations = ~iso3c) %>% 
  add_trace(
    z = ~log10(num_contact), 
    text = ~paste(country, prettyNum(num_contact, big.mark = " "), sep = "<br />")
  ) %>%
  colorbar(title = "Population", tickprefix = "10^")
