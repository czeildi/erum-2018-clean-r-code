attach_human_readable_country_metadata <- function(df, countries) {
  df %>%
    attach_country_metadata(countries) %>%
    select(country, everything(), -iso3c, -country_code)
}

attach_country_metadata <- function(df, countries) {
  inner_join(df, countries, by = "country_code")
}
