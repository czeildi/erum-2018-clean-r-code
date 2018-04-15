library("tidyverse")
library("plotly")
purrr::walk(list.files("R", full.names = TRUE), source)

# load data ---------------------------------------------------------------

countries <- read_csv("data/countries.csv", na = "")
home_cities <- read_csv("data/home_cities_frequent.csv.gz", na = "")

# initial exploration -----------------------------------------------------

countries[!complete.cases(countries), ]
home_cities[!complete.cases(home_cities), ]

countMissingByColumns(home_cities)

home_cities %>%
    group_by(missing_city = is.na(city)) %>% 
    summarize(
        num_contact = sum(num_contact),
        num_country = n_distinct(country_code)
    )

use_country_names <- purrr::partial(use_country_names_from, countries = countries)

glimpse_extreme_regions(home_cities, country_code, city) %>% 
    use_country_names()
glimpse_extreme_regions(home_cities, country_code) %>% 
    use_country_names()

home_cities %>% 
    group_by(country_code, city) %>% 
    summarize(n_coord = n_distinct(long, lat)) %>% 
    filter(n_coord > 1) %>% 
    group_by(missing_city = is.na(city)) %>% 
    summarize(n_city = n(), avg_num_coord = mean(n_coord))

home_cities %>% 
    filter_missing_city() %>% 
    summarize_population_by_region(country_code, city, long, lat) %>% 
    filter(num_contact >= 1000) %>% 
    plot_geo(lat = ~lat, lon = ~long) %>%
    add_markers(
        text = ~str_c(country_code, city, num_contact, sep = "<br />"),
        size = ~log(num_contact)
    )


# TODO plot each city on worldmap
# TODO plot country populations on worldmap

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


