use_country_names_from <- function(df, countries) {
    df %>% 
        inner_join(countries, by = "country_code") %>%
        select(-iso3c, -country_code) %>% 
        select(country, everything())
}
