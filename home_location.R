library("tidyverse")

source("R/clean.R")

# load data ---------------------------------------------------------------

# NA is valid country code, stands for Namibia, so should not be read as NA
countries <- read_csv("data/countries.csv", na = "")
home_cities <- read_csv("data/home_cities_frequent.csv.gz", na = "")

# data preparation -------------------------------------------------------

get_rows_with_missing_value(countries)
get_rows_with_missing_value(home_cities)

get_cities_with_multiple_coords(home_cities)

# data exploration --------------------------------------------------------

ordered_city_populations <- home_cities %>% 
  group_by(country_code, city) %>% 
  summarize(num_contact = sum(num_contact)) %>% 
  ungroup() %>% 
  arrange(desc(num_contact))

top_cities <- head(ordered_city_populations)
bottom_cities <- tail(ordered_city_populations)

rbind(top_cities, bottom_cities) %>% 
  inner_join(countries, by = "country_code") %>% 
  select(country, everything(), -iso3c, -country_code)


ordered_country_populations <- home_cities %>% 
  group_by(country_code) %>% 
  summarize(num_contact = sum(num_contact)) %>% 
  ungroup() %>% 
  arrange(desc(num_contact))

top_countries <- head(ordered_country_populations)
bottom_countries <- tail(ordered_country_populations)

rbind(top_countries, bottom_countries) %>% 
  inner_join(countries, by = "country_code") %>% 
  select(country, everything(), -iso3c, -country_code)



# example of function grouping on variable number of columns
max_latitude_by_groups <- function(home_cities, ...) {
  home_cities %>% 
    group_by(...) %>% 
    summarize(max_latitude = max(lat)) %>% 
    ungroup()
}

max_latitude_by_groups(home_cities)
max_latitude_by_groups(home_cities, client_id)
max_latitude_by_groups(home_cities, country_code, city)
max_latitude_by_groups(home_cities, client_id, country_code, city)

# proceed to next step ----------------------------------------------------

# source("workshop_tools.R")
# proceed_to("1_cleaned_preparation")


# return to beginning -----------------------------------------------------

# source("workshop_tools.R")
# proceed_to("master")
