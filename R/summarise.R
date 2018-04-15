glimpseExtremeRegions <- function(home_cities, ...) {
    top <- summarize_population_by_region(home_cities, ...) %>% 
        arrange(desc(num_contact)) %>%
        head(5)
    
    bottom <- summarize_population_by_region(home_cities, ...) %>% 
        arrange(num_contact) %>%
        head(5)
    rbind(top, bottom)
}

summarize_population_by_region <- function(df, ...) {
    df %>% 
        group_by(...) %>% 
        summarize(num_contact = sum(num_contact))
}

add_country_population <- function(df) {
    df %>% 
        group_by(country_code) %>%
        mutate(country_population = sum(num_contact))
}

keep_strongest_city <- function(df) {
    df %>% 
        mutate(share_of_contacts = num_contact / country_population) %>% 
        group_by(country_code) %>%
        filter(share_of_contacts == max(share_of_contacts))
}

keep_cities_for_coverage <- function(df) {
    df %>% 
        arrange(country_code, desc(num_contact)) %>% 
        group_by(country_code) %>% 
        mutate(
            contact_coverage = cumsum(num_contact) / country_population,
            city_rank = min_rank(num_contact)
        ) %>%
        filter(contact_coverage <= 0.8 | city_rank == 1)
}

countMissingByColumns <- function(home_cities) {
    apply(home_cities, 2, function(x) sum(is.na(x)) )
}
