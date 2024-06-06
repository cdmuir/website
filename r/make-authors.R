library(dplyr)
library(glue)
library(readr)

path = "content/authors/"

author_template = read_lines("templates/author.md") |>
  paste(collapse = "\n")

degree_template =
"  - course: {degree} in {major}
    institution: {institution}
    year: {year}
"
mentees = read_csv("../cv/data/mentees1.csv", show_col_types = FALSE) |>
  filter(order == 1) |>
  mutate(user_group = ifelse(alum, "Alumni", user_group)) |>
  full_join(
    read_csv("../cv/data/mentee-degrees.csv", show_col_types = FALSE) |>
      arrange(id, order) |>
      mutate(degree = glue(degree_template)) |>
      summarize(degree = paste(degree, collapse = "\n"), .by = "id"),
    by = join_by(id)
  ) |>
  full_join(
    read_csv("../cv/data/mentee-affiliations.csv", show_col_types = FALSE),
    by = join_by(current_affiliation)
  )

.id = "alterj"

mentees |>
  filter(id == .id) |>
  mutate(index = glue(author_template)) |>
  pull(index)
