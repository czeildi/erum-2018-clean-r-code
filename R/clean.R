check_multiple_city_coords <- function(cities) {
    cities %>% 
        group_by(country_code, city) %>% 
        summarize(num_coord_per_city = n_distinct(long, lat)) %>% 
        filter(num_coord_per_city > 1)
}

keep_rows_with_missing_values <- function(df) {
    df[!complete.cases(df), ]
}
