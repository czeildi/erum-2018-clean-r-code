library(readr)
library(data.table)
library(magrittr)
library(ggplot2)

# read data ---------------------------------------------------------------

client_meta_dt <- read_csv("data/client_meta_data.csv") %>% setDT()
home_cities <- fread("gunzip -c data/extended_home_cities_frequent.csv.gz")


# explore capital city effect ---------------------------------------------

# lehet accountok kozott atfedes, ezt most elhanyagoljuk
city_aggr <- home_cities[, .(num_contact = sum(num_contact)), by = .(country, city)]

share_of_strongest_city <- city_aggr %>% 
    .[, country_population := sum(num_contact), by = country] %>% 
    .[country_population >= 10000] %>% 
    .[city != ''] %>% 
    .[order(country, -num_contact)] %>% 
    .[, city_tally_in_country := frank(-num_contact), by = country] %>% 
    .[city_tally_in_country == 1] %>% 
    .[, share_of_city := num_contact / country_population] %>% 
    .[order(-share_of_city)]

# regiok, kontinens szerint atlagolni?

# most cities needed to achieve 95% coverage?

cities_for_coverage <- city_aggr %>% 
    .[, country_population := sum(num_contact), by = country] %>% 
    .[country_population >= 10000] %>% 
    .[city != ''] %>% 
    .[order(country, -num_contact)] %>% 
    .[, cumulative_coverage := cumsum(num_contact) / country_population, by = country] %>% 
    .[cumulative_coverage <= 0.8] %>% 
    .[, .(num_city_for_coverage = .N), by = country]

# lehet olyan filterezo fuggveny, ami nyers adat alapjan filterez, igy batran
# lehet oket egymas utan alkalmazni, konzisztens lesz

by_cols <- c("continent", "country")

city_aggr <- home_cities[, .(num_contact = sum(num_contact)), by = c(by_cols, "city")]

share_of_strongest_city <- city_aggr %>% 
    .[, country_population := sum(num_contact), by = by_cols] %>% 
    .[country_population >= 1000] %>% 
    .[city != ''] %>% 
    .[, city_tally_in_country := frank(-num_contact), by = by_cols] %>% 
    .[city_tally_in_country == 1] %>% 
    .[, share_of_city := num_contact / country_population] %>% 
    .[order(-share_of_city)]

continental_average <- share_of_strongest_city %>% 
    .[, .(mean_share = weighted.mean(share_of_city, country_population), num_country = .N), by = continent] %>% 
    .[order(mean_share)]


# by industry how spread? -------------------------------------------------

account_countries <- home_cities[, .(num_contact = sum(num_contact)), by = .(client_id, country)] %>% 
    .[, account_population := sum(num_contact), by = client_id] %>% 
    .[, country_share := num_contact / account_population] %>% 
    .[order(client_id, -num_contact)] %>% 
    .[, cumulative_country_share := cumsum(num_contact) / account_population, by = client_id]
# elfelejtettem a by = client id.t

account_num_country <- account_countries[, .(num_country = .N), by = client_id] %>% 
    merge(client_meta_dt[, .(client_id, industry)], by = "client_id")

account_num_strong_country <- account_countries %>% 
    .[country_share >= 0.01] %>% 
    .[, .(num_country = .N), by = client_id] %>% 
    merge(client_meta_dt[, .(client_id, industry)], by = "client_id")

account_num_country_for_coverage <- account_countries %>% 
    .[cumulative_country_share <= 0.8] %>% 
    .[, .(num_country = .N), by = client_id] %>% 
    merge(client_meta_dt[, .(client_id, industry)], by = "client_id")

ggplot(account_num_country, aes(x = num_country, col = industry)) + 
    geom_density()

ggplot(account_num_strong_country, aes(x = num_country, col = industry)) + 
    geom_density()

ggplot(account_num_country_for_coverage, aes(x = num_country, col = industry)) + 
    geom_density()

ggplot(account_num_country, aes(x = industry, y = num_country, fill = industry)) + 
    geom_boxplot()

ggplot(account_num_strong_country, aes(x = industry, y = num_country, fill = industry)) + 
    geom_boxplot()

ggplot(account_num_country_for_coverage, aes(x = industry, y = num_country, fill = industry)) + 
    geom_boxplot()

# strongest regions by industry

dt <- merge(home_cities, client_meta_dt[, .(client_id, industry)], by = "client_id")

# ilyen nyers exploration --> eszrevesszuk, hogy nincs mindenutt kitoltve a varos
dt[, .(num_contact = sum(num_contact)), by = .(city, industry)] %>% 
    .[city != "" ] %>% 
    .[order(-num_contact)] %>% 
    head(20)

dt[, .(num_contact = sum(num_contact)), by = .(country, industry)] %>% 
    .[order(-num_contact)] %>% 
    head(20)

dt[, .(num_contact = sum(num_contact)), by = .(region, industry)] %>% 
    .[order(industry, -num_contact)]

dt[, .(num_contact = sum(num_contact)), by = .(continent, industry)] %>% 
    .[order(-num_contact)] %>% 
    head(20) %>% 
    .[order(industry)]

# ugyanez total populationnel kontrollalva (kulso adatbazisbol?)

# UK: too long name


# where are those with few locations? -------------------------------------


