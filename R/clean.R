filterRegionlessCountries <- function(df) {
    filter(df, country_code == "CX" | country_code == "IO")
}
