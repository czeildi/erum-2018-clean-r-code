calculate_relative_city_populations <- function(city_populations) {
    city_populations %>% 
        add_country_population() %>% 
        mutate(relative_population = num_contact / country_population)
}

calculate_relative_country_population <- function(country_populations_by_client) {
    country_populations_by_client %>% 
        group_by(client_id) %>% 
        mutate(client_population = sum(num_contact)) %>% 
        mutate(relative_population = num_contact / client_population)
}

glimpse_extreme_regions <- function(home_cities, countries, ...) {
    arranged_regions <- home_cities %>% 
        summarize_population(...) %>% 
        arrange(desc(num_contact))
    
    extreme_regions <- rbind(
        head(arranged_regions, 5),
        tail(arranged_regions, 5)
    )
    use_country_names(extreme_regions, countries)
}

summarize_population <- function(df, ...) {
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
        group_by(country_code) %>%
        filter(relative_population == max(relative_population))
}

keep_strongest_country <- function(df) {
    df %>% 
        group_by(client_id) %>%
        filter(relative_population == max(relative_population))
}

count_cities_for_coverage <- function(relative_city_populations, min_coverage = 0.8) {
    relative_city_populations %>% 
        filter_cities_for_coverage(min_coverage) %>% 
        group_by(country_code) %>%
        summarise(num_city = n())
}

filter_cities_for_coverage <- function(relative_city_populations, min_coverage) {
    city_coverages <- get_cumulative_coverage_of_cities(relative_city_populations)
    
    coverage_limits <- smallest_coverage_above_limit(city_coverages, min_coverage)
    
    city_coverages %>% 
        inner_join(coverage_limits, by = "country_code") %>% 
        filter(contact_coverage <= coverage_limit)
}

get_cumulative_coverage_of_cities <- function(relative_city_populations) {
    relative_city_populations %>% 
        arrange(country_code, desc(relative_population)) %>% 
        group_by(country_code) %>% 
        mutate(contact_coverage = cumsum(relative_population))
}

smallest_coverage_above_limit <- function(coverages, min_coverage) {
    coverages %>%
        filter(contact_coverage >= min_coverage) %>% 
        group_by(country_code) %>% 
        mutate(city_rank = min_rank(contact_coverage)) %>% 
        filter(city_rank == 1) %>% 
        select(country_code, coverage_limit = contact_coverage)
}

count_countries <- function(df) {
    df %>% 
        group_by(client_id) %>% 
        summarize(num_country = n())
}
