# Make individual author pages for mentees
source("r/header.R")

path = "content/authors/"
picture_path = "static/img/"

author_template = read_lines("templates/author.md") |>
  paste(collapse = "\n")

degree_template =
"  - course: {degree} in {major}
    institution: {institution}
    year: {year}
"
mentees = read_csv("../cv/data/mentees.csv", show_col_types = FALSE) |>
  
  # add roles
  full_join(
    read_csv("../cv/data/mentee-roles.csv", show_col_types = FALSE),
    by = join_by(id)
  ) |>
  filter(order == 1) |>
  mutate(user_group = ifelse(alum, "Alumni", user_group)) |>
  
  # add degrees
  full_join(
    read_csv("../cv/data/mentee-degrees.csv", show_col_types = FALSE) |>
      arrange(id, order) |>
      mutate(degree = glue(degree_template, .trim = FALSE)) |>
      summarize(degree = paste(degree, collapse = "\n"), .by = "id"),
    by = join_by(id)
  ) |>
  
  # add affiliations
  full_join(
    read_csv("../cv/data/mentee-affiliations.csv", show_col_types = FALSE),
    by = join_by(current_affiliation)
  ) |>
  # add blurbs
  full_join(
    read_csv("../cv/data/mentee-blurbs.csv", show_col_types = FALSE),
    by = join_by(id)
  ) |>
  replace_na(list(blurb = ""))

mentees |>
  filter(id != "cdmuir") |>
  rowwise() |>
  mutate(index = glue(author_template)) |>
  split(~ id) |>
  walk(make_author, .path = path, .picture_path = picture_path)
  
