library("tidyverse")
purrr::walk(list.files("R", full.names = TRUE), source)

# load data ---------------------------------------------------------------

client_meta_data <- read_csv("data/client_meta_data.csv")
country_meta_data <- read_csv("data/country_meta_data.csv", na = "")
home_cities <- data.table::fread("gunzip -c data/home_cities_frequent.csv.gz") %>%
    as.tibble()

# initial exploration -----------------------------------------------------

# possibly use skimr, visdat

country_meta_data[!complete.cases(country_meta_data), ]
filter(home_cities, country_code == "CX" | country_code == "IO")

relevant_country_meta_data <- filterRegionlessCountries(country_meta_data)
relevant_home_cities <- filterRegionlessCountries(home_cities)

filter(home_cities, country_code == "")

home_cities %>%
    group_by(country_code, city) %>%
    summarise(num_contact = sum(num_contact)) %>%
    arrange(desc(num_contact)) %>%
    head(10)

# for the purpose of comparing coutries we do not want to fully filter empty
# city information

home_cities %>%
    group_by(country_code) %>%
    summarise(num_contact = sum(num_contact)) %>%
    arrange(desc(num_contact)) %>%
    head(10)
