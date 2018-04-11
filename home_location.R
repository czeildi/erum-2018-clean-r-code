library("tidyverse")
purrr::walk(list.files("R", full.names = TRUE), source)

# load data ---------------------------------------------------------------

client_meta_data <- read_csv("data/client_meta_data.csv")
country_meta_data <- read_csv("data/country_meta_data.csv", na = "")
home_cities <- load_home_cities()

# initial exploration -----------------------------------------------------

# possibly use skimr, visdat

country_meta_data[!complete.cases(country_meta_data), ]
filter(home_cities, country_code == "CX" | country_code == "IO")

relevant_country_meta_data <- filter_regionless_countries(country_meta_data)
relevant_home_cities <- filter_regionless_countries(home_cities)

filter(home_cities, country_code == "")

arrange_regions_by_population(home_cities, country_code, city)
arrange_regions_by_population(home_cities, city)
arrange_regions_by_population(home_cities, country_code)

# for the purpose of comparing coutries we do not want to fully filter empty
# city information


# capital city effect -----------------------------------------------------


