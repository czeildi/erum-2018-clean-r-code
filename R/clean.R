filter_missing_city <- function(df) {
    filter(df, !is.na(city))
}

filter_small_countries <- function(df, limit = 1000) {
    filter(df, country_population >= limit)
}


check_multiple_city_coords <- function(cities) {
    cities %>% 
        group_by(country_code, city) %>% 
        summarize(n_coord = n_distinct(long, lat)) %>% 
        filter(n_coord > 1) %>% 
        group_by(missing_city = is.na(city)) %>% 
        summarize(n_city = n(), avg_num_coord = mean(n_coord))
}

keep_relevant_cities <- function(cities, population_limit = 1000) {
    cities %>% 
        filter_missing_city() %>% 
        filter(num_contact >= population_limit)
}
