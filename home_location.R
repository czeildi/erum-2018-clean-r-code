library("tidyverse")
library("plotly")
purrr::walk(list.files("R", full.names = TRUE), source)

# load data ---------------------------------------------------------------

countries <- read_csv("data/countries.csv", na = "")
home_cities <- read_csv("data/home_cities_frequent.csv.gz", na = "")

# initial exploration -----------------------------------------------------

keep_rows_with_missing_values(countries)
keep_rows_with_missing_values(home_cities)


count_missing_by_column(home_cities)

# TODO coord atlagolas miatt missing city info alapbol eleg fura...
spread_of_missing_cities(home_cities)


glimpse_extreme_regions(home_cities, countries, country_code, city)
glimpse_extreme_regions(home_cities, countries, country_code)


check_multiple_city_coords(home_cities)


city_populations <- summarize_population(home_cities, country_code, city)
country_populations <- summarize_population(home_cities, country_code)


city_populations %>% 
    keep_relevant_cities(population_limit = 1000) %>% 
    plot_city_nums(countries, home_cities, col_name = "num_contact")

plot_country_nums(
    country_populations, countries,
    col_name = "num_contact",
    num_scaler = log10
)

# capital city effect -----------------------------------------------------

relative_city_populations <- calculate_relative_city_populations(city_populations)

relative_city_populations %>% 
    keep_strongest_city() %>% 
    plot_country_nums(countries, "relative_population")

relative_city_populations %>%
    count_cities_for_coverage(min_coverage = 0.8) %>% 
    plot_country_nums(countries, "num_city", num_scaler = log10)

# num countries by clients and industry comparison ---------------------------
clients <- read_csv("data/clients.csv")

relative_country_populations <- home_cities %>% 
    summarize_population(client_id, country_code) %>% 
    calculate_relative_country_population()

relative_country_populations %>% 
    keep_strongest_country() %>% 
    attach_client_metadata(clients) %>% 
    ggplot(aes(x = relative_population, color = industry)) + 
    geom_density() + 
    theme_bw() + 
    scale_x_continuous(labels = scales::percent_format())

relative_country_populations %>% 
    count_countries() %>% 
    attach_client_metadata(clients) %>% 
    ggplot(aes(x = num_country, color = industry)) + 
    geom_density() + 
    theme_bw()

# industry comparison in regions ------------------------------------------

home_cities %>% 
    inner_join(clients, by = "client_id") %>% 
    summarize_population(industry, country_code) %>% 
    add_country_population() %>% 
    mutate(share_of_industry = num_contact / country_population) %>% 
    filter(industry == 'eCommerce') %>% 
    plot_country_nums(countries, "share_of_industry") %>% 
    layout(title = "Share of eCommerce")
