plot_country_nums <- function(country_nums, countries, col_name, num_scaler = identity) {
    country_nums %>% 
        attach_country_metadata(countries) %>% 
        plot_geo(locations = ~iso3c) %>% 
        add_trace(
            z = ~num_scaler(get(col_name)), 
            text = ~paste(country, prettyNum(get(col_name), big.mark = " "), sep = "<br />"),
            showscale = FALSE
        )
}

plot_city_nums <- function(city_nums, col_name) {
    city_nums %>% 
        plot_geo(lat = ~lat, lon = ~long) %>%
        add_markers(
            size = ~log10(get(col_name)),
            color = ~log10(get(col_name)),
            text = ~str_c(country, city, get(col_name), sep = "<br />")
        ) %>% 
        colorbar(title = col_name, tickprefix = "10^")
}

attach_city_metadata <- function(df, countries, cities) {
    city_coords <- get_city_coords(cities)
    df %>% 
        inner_join(countries, by = "country_code") %>% 
        inner_join(city_coords, by = c("country_code", "city"))
}

get_city_coords <- function(cities) {
    cities %>% 
        select(country_code, city, long, lat) %>% 
        unique()
}

attach_country_metadata <- function(df, countries) {
    inner_join(df, countries, by = "country_code")
}
