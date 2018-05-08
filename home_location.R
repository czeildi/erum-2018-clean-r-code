library("tidyverse")
library("plotly")

purrr::walk(list.files("R", full.names = TRUE), source)

# load data ---------------------------------------------------------------

# NA is valid country code, stands for Namibia, so should not be read as NA
countries <- read_csv("data/countries.csv", na = "")
home_cities <- read_csv("data/home_cities_frequent.csv.gz", na = "")
clients <- read_csv("data/clients.csv")

# data preparation -----------------------------------------------------

get_rows_with_missing_value(countries)
get_rows_with_missing_value(home_cities)
get_rows_with_missing_value(clients)

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

home_cities %>% 
  summarize_population(country_code, city) %>%
  get_population_share_of_top_cities() %>%
  plot_population_share(countries)

# industry comparison based on spread of clients --------------------------

home_cities %>% 
  count_countries_by_client() %>% 
  plot_country_num_distribution_by_industry(clients)

# eCommerce dominance by country ------------------------------------------

home_cities %>% 
  summarize_industry_population_by_country(clients) %>% 
  get_population_share_of_industry(selected_industry = "eCommerce") %>% 
  plot_ecommerce_share(countries)


# return to beginning -----------------------------------------------------

# source("workshop_tools.R")
# proceed_to("master")
