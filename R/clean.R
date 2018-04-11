filter_regionless_countries <- function(df) {
    filter(df, country_code == "CX" | country_code == "IO")
}

filter_missing_city <- function(df) {
    filter(df, city == "")
}

filter_small_countries <- function(df, limit = 1000) {
    filter(df, num_contact >= limit)
}
