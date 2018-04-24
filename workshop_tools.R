proceed_to <- function(next_step_name) {
  repo <- git2r::repository(rprojroot::find_root('erum-2018-clean-r-code.Rproj'))
  git2r::add(repo, ".")
  git2r::config(user.name = "erum", user.email = "erum@cleancode.com")
  git2r::stash(repo)
  git2r::checkout(repo, next_step_name)
}
