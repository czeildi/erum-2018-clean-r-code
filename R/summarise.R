glimpse_extreme_regions <- function(home_cities, countries, ...) {
    arranged_regions <- home_cities %>% 
        summarize_population_by_region(...) %>% 
        arrange(desc(num_contact))
    
    extreme_regions <- rbind(
        head(arranged_regions, 5),
        tail(arranged_regions, 5)
    )
    use_country_names(extreme_regions, countries)
}

summarize_population_by_region <- function(df, ...) {
    df %>% 
        group_by(...) %>% 
        summarize(num_contact = sum(num_contact)) %>%
        ungroup()
}


use_country_names <- function(df, countries) {
    df %>% 
        attach_country_metadata(countries) %>%
        select(country, everything(), -iso3c, -country_code)
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

keep_cities_for_coverage <- function(df, min_coverage = 0.8) {
    df %>% 
        arrange(country_code, desc(num_contact)) %>% 
        group_by(country_code) %>% 
        mutate(
            contact_coverage = cumsum(num_contact) / country_population,
            city_rank = min_rank(num_contact)
        ) %>%
        filter(contact_coverage >= min_coverage) %>% 
        group_by(country_code) %>% 
        filter(city_rank == min(city_rank))
}

count_missing_by_column <- function(home_cities) {
    apply(home_cities, 2, function(x) sum(is.na(x)) )
}

spread_of_missing_cities <- function(home_cities) {
    home_cities %>%
        group_by(missing_city = is.na(city)) %>% 
        summarize(
            num_contact = sum(num_contact),
            num_country = n_distinct(country_code)
        )
}
