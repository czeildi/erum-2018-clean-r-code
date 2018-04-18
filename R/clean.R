filter_missing_city <- function(df) {
    filter(df, !is.na(city))
}

check_multiple_city_coords <- function(cities) {
    cities %>% 
        group_by(country_code, city) %>% 
        summarize(num_coord_per_city = n_distinct(long, lat)) %>% 
        filter(num_coord_per_city > 1) %>% 
        group_by(is_missing_city = is.na(city)) %>% 
        summarize(
            number_of_cities = n(),
            avg_num_coord_per_city = mean(num_coord_per_city)
        )
}

keep_relevant_cities <- function(cities, population_limit = 1000) {
    cities %>% 
        filter_missing_city() %>% 
        filter(num_contact >= population_limit)
}

keep_rows_with_missing_values <- function(df) {
    df[!complete.cases(df), ]
}
