library("tidyverse")
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

glimpseExtremeRegions(home_cities, country_code, city)
glimpseExtremeRegions(home_cities, country_code)

# for the purpose of comparing coutries we do not want to fully filter empty
# city information

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


