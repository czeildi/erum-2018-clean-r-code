library("tidyverse")
purrr::walk(list.files("R", full.names = TRUE), source)

# load data ---------------------------------------------------------------

client_meta_data <- read_csv("data/client_meta_data.csv")
country_meta_data <- read_csv("data/country_meta_data.csv", na = "")
home_cities <- load_home_cities()

# initial exploration -----------------------------------------------------

country_meta_data[!complete.cases(country_meta_data), ]
filter(home_cities, country_code == "CX" | country_code == "IO")

relevant_country_meta_data <- filter_regionless_countries(country_meta_data)
relevant_home_cities <- filter_regionless_countries(home_cities)

filter(home_cities, country_code == "")

arrange_regions_by_population(home_cities, country_code, city)
arrange_regions_by_population(home_cities, country_code, city) %>%
    arrange(num_contact)
arrange_regions_by_population(home_cities, country_code)
arrange_regions_by_population(home_cities, country_code) %>%
    arrange(num_contact)

# for the purpose of comparing coutries we do not want to fully filter empty
# city information

# TODO plot each city on worldmap
# TODO plot country populations on worldmap

# capital city effect -----------------------------------------------------

city_populations <- arrange_regions_by_population(home_cities, country_code, city)

share_of_strongest_city <- city_populations %>%
    arrange_regions_by_population(country_code, city) %>%
    group_by(country_code) %>%
    mutate(country_population = sum(num_contact)) %>%
    filter_small_countries() %>%
    filter_missing_city() %>%
    group_by(country_code) %>%
    mutate(max_city_share = max(num_contact / country_population)) %>%
    filter(num_contact / country_population == max_city_share) %>%
    select(country_code, country_population, city, share_of_contacts = max_city_share) %>%
    arrange(desc(share_of_contacts))
    
num_cities_for_coverage <- city_populations %>%
    arrange_regions_by_population(country_code, city) %>%
    group_by(country_code) %>%
    mutate(country_population = sum(num_contact)) %>%
    filter_small_countries() %>%
    filter_missing_city() %>%
    arrange(country_code, desc(num_contact)) %>% 
    group_by(country_code) %>% 
    mutate(contact_coverage = cumsum(num_contact) / country_population, city_rank = min_rank(num_contact)) %>%
    filter(contact_coverage <= 0.8 | city_rank == 1) %>%
    group_by(country_code) %>%
    summarise(country_population = mean(country_population), num_city = n(), coverage = max(contact_coverage)) %>%
    arrange(num_city)
