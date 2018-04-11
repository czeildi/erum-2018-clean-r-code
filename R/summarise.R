arrange_regions_by_population <- function(df, ...) {
    region_vars <- quos(...)
    df %>%
        group_by(!!!region_vars) %>%
        summarise(num_contact = sum(num_contact)) %>%
        arrange(desc(num_contact))
}
