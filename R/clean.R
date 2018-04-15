filter_missing_city <- function(df) {
    filter(df, !is.na(city))
}

filter_small_countries <- function(df, limit = 1000) {
    filter(df, country_population >= limit)
}
