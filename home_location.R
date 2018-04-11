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
    add_country_population() %>%
    filter_small_countries() %>%
    filter_missing_city() %>%
    keep_strongest_city()
    
num_cities_for_coverage <- city_populations %>%
    add_country_population() %>%
    filter_small_countries() %>%
    filter_missing_city() %>%
    keep_cities_for_coverage() %>%
    group_by(country_code) %>%
    summarise(
        country_population = mean(country_population),
        num_city = n(),
        coverage = max(contact_coverage)
    )


# num countries by clients ------------------------------------------------


# industry comparison in regions ------------------------------------------


# emarsys contacts vs population ------------------------------------------


