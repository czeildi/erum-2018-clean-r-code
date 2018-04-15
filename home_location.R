library("tidyverse")
library("plotly")
purrr::walk(list.files("R", full.names = TRUE), source)

# load data ---------------------------------------------------------------

countries <- read_csv("data/countries.csv", na = "")
home_cities <- read_csv("data/home_cities_frequent.csv.gz", na = "")

# initial exploration -----------------------------------------------------

countries[!complete.cases(countries), ]
home_cities[!complete.cases(home_cities), ]

count_missing_by_column(home_cities)

# coord atlagolas miatt missing city info alapbol eleg fura...
spread_of_missing_cities(home_cities)

glimpse_extreme_regions(home_cities, countries, country_code, city)
glimpse_extreme_regions(home_cities, countries, country_code)

check_multiple_city_coords(home_cities)

home_cities %>% 
    summarize_population(country_code, city) %>% 
    keep_relevant_cities(population_limit = 1000) %>% 
    attach_city_metadata(countries, home_cities) %>% 
    plot_city_nums(col_name = "num_contact")

home_cities %>% 
    summarize_population(country_code) %>% 
    plot_country_nums(countries, col_name = "num_contact", num_scaler = log10)

# capital city effect -----------------------------------------------------

relative_city_populations <- home_cities %>% 
    summarize_population(country_code, city) %>% 
    calculate_relative_city_populations()

relative_city_populations %>% 
    keep_strongest_city() %>% 
    plot_country_nums(countries, "relative_population")

relative_city_populations %>%
    count_cities_for_coverage(min_coverage = 0.8) %>% 
    plot_country_nums(countries, "num_city", num_scaler = log10)




# num countries by clients and industry comparison ------------------------------------------------
clients <- read_csv("data/clients.csv")


# industry comparison in regions ------------------------------------------

home_cities %>% 
    inner_join(clients, by = "client_id") %>% 
    summarize_population(industry, country_code) %>% 
    add_country_population() %>% 
    mutate(share_of_industry = num_contact / country_population) %>% 
    filter(industry == 'eCommerce') %>% 
    plot_country_nums(countries, "share_of_industry") %>% 
    layout(title = "Share of eCommerce")
