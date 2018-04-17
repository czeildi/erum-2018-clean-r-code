library(tidyverse)

num_users <- 100

users <- tibble(
    idx = 1:num_users,
    username = str_c("u", str_pad(1:num_users, 3, "left", "0")),
    pwd = str_c("cleanrcode", str_pad(1:num_users, 3, "left", "0"))
)

write_csv(users, "users.csv")
