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

home_cities %>% 
  summarize_population(country_code, city) %>%
  get_population_share_of_top_cities() %>%
  plot_population_share(countries)

# industry comparison based on spread of clients --------------------------

clients <- read_csv("data/clients.csv")
get_rows_with_missing_value(clients)

home_cities %>% 
  count_countries_by_client() %>% 
  plot_country_num_distribution_by_industry(clients)

# eCommerce dominance by country ------------------------------------------

home_cities %>% 
  attach_client_metadata(clients) %>% 
  summarize_population(industry, country_code) %>% 
  add_country_population() %>% 
  filter(industry == 'eCommerce') %>% 
  mutate(industry_share = num_contact / country_population) %>% 
  base_country_plot(countries) %>% 
  add_trace(
    z = ~industry_share, 
    text = ~paste(country, country_population, scales::percent(industry_share), sep = "<br />")
  ) %>% 
  colorbar(title = "", limits = c(0, 1)) %>% 
  layout(title = "Share of eCommerce")


# proceed to next step ----------------------------------------------------

# source("workshop_tools.R")
# proceed_to("5_cleaned_ecommerce_dominance")


# return to beginning -----------------------------------------------------

# source("workshop_tools.R")
# proceed_to("master")


