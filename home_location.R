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
    summarize_population_by_region(country_code, city) %>% 
    keep_relevant_cities(population_limit = 1000) %>% 
    attach_city_metadata(countries, home_cities) %>% 
    plot_city_nums(col_name = "num_contact")

home_cities %>% 
    summarize_population_by_region(country_code) %>% 
    attach_country_metadata(countries) %>% 
    plot_country_nums(col_name = "num_contact")

# capital city effect -----------------------------------------------------

city_populations <- arrange_regions_by_population(home_cities, country_code, city)
# legyen kulon rendezett es nem rendezett fuggveny
share_of_strongest_city <- city_populations %>%
    add_country_population() %>%
    filter_small_countries() %>%
    filter_missing_city() %>%
    keep_strongest_city()
    
# itt is ki akarjuk szurni missing cityket?
# first after 0.8 would make more sense

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

# move group by + sumarise to function

# num countries by clients and industry comparison ------------------------------------------------


# industry comparison in regions ------------------------------------------
# ez mar inkabb backupnak vszeg nem lesz ra ido

# emarsys contacts vs population ------------------------------------------


