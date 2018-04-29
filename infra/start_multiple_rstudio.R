container_num <- 5
port_start <- 20000

for (user_index in 1:container_num) {
  cmd <- paste0(
    "docker run -d -p ", port_start + user_index, ":8787",
    " --memory 1g",
    " -v /home/rstudio/data:/home/rstudio/erum-2018-clean-r-code/data:ro",
    " czeildi/erum-clean-r-code"
  )
  print(cmd)
  system(cmd)
}
