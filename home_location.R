library("tidyverse")


# load data ---------------------------------------------------------------

client_meta_data <- read_csv("data/client_meta_data.csv")
country_meta_data <- read_csv("data/country_meta_data.csv", na = "")
home_cities <- data.table::fread("gunzip -c data/home_cities_frequent.csv.gz") %>%
    as.tibble()

# initial exploration -----------------------------------------------------

# possibly use skimr, visdat

country_meta_data[!complete.cases(country_meta_data), ] %>% View
