load_home_cities <- function() {
    data.table::fread("gunzip -c data/home_cities_frequent.csv.gz") %>%
        as.tibble()
}
