plot_city_populations <- function(city_populations) {
  city_populations %>% 
    plot_geo(lat = ~lat, lon = ~long) %>%
    add_markers(
      size = ~log10(num_contact),
      color = ~log10(num_contact),
      text = ~str_c(country_code, city, num_contact, sep = "<br />")
    ) %>% 
    log_population_colorbar()
}

plot_country_populations <- function(country_populations, countries) {
  country_populations %>% 
    base_country_plot(countries) %>% 
    add_trace(
      z = ~log10(num_contact), 
      text = ~paste(country, prettyNum(num_contact, big.mark = " "), sep = "<br />")
    ) %>%
    log_population_colorbar()
}

plot_population_share <- function(top_city_population_share, countries) {
  plot_country_shares(
    top_city_population_share, metric_name = "population_share", countries
  )
}

plot_ecommerce_share <- function(ecommerce_share, countries) {
  ecommerce_share %>% 
    plot_country_shares(metric_name = "industry_share", countries) %>% 
    layout(title = "Share of eCommerce")
}

plot_country_shares <- function(country_shares, metric_name, countries) {
  country_shares %>% 
    base_country_plot(countries) %>% 
    add_trace(
      z = ~get(metric_name), 
      text = ~paste(country, country_population, scales::percent(get(metric_name)), sep = "<br />")
    ) %>% 
    share_colorbar()
}

plot_country_num_distribution_by_industry <- function(country_nums, clients) {
  country_nums %>% 
    attach_client_metadata(clients) %>% 
    ggplot(aes(x = num_country, color = industry)) + 
    geom_density_clean()
}

base_country_plot <- function(df, countries) {
  df %>% 
    attach_country_metadata(countries) %>%
    plot_geo(locations = ~iso3c)
}

log_population_colorbar <- function(p) {
  colorbar(p, title = "Population", tickprefix = "10^")
}

share_colorbar <- function(p) {
  colorbar(p, title = "", limits = c(0, 1))
}

geom_density_clean <- function() {
  list(
    geom_density(),
    theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())
  )
}

attach_human_readable_country_metadata <- function(df, countries) {
  df %>%
    attach_country_metadata(countries) %>%
    select(country, everything(), -iso3c, -country_code)
}

attach_country_metadata <- function(df, countries) {
  inner_join(df, countries, by = "country_code")
}

attach_client_metadata <- function(df, clients) {
  inner_join(df, clients, by = "client_id")
}
