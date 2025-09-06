# Make individual author pages for mentees
source("r/header.R")

gid = "1vuAQPwkGC8kFNKpVZ0KBE3ZJjXGBR9XIwh1ASQwumjk"

path = "content/authors/"
picture_path = "static/img/"

author_template = read_lines("templates/author.md") |>
  paste(collapse = "\n")

degree_template =
  "  - course: {degree} in {major}
    institution: {institution}
    year: {year}
"

mentees = read_sheet(
  gid,
  sheet = "mentees",
  col_types = "ccccclc"
) |>
  
  # add roles
  full_join(read_sheet(gid, sheet = "roles", col_types = "cccccDDi"),
            by = join_by(id)) |>
  filter(order == 1) |>
  mutate(user_group = ifelse(alum, "Alumni", user_group)) |>
  
  # add degrees
  full_join(
    read_sheet(gid, sheet = "degrees", col_types = "cccccil") |>
      arrange(id, order) |>
      mutate(degree = glue(degree_template, .trim = FALSE)) |>
      summarize(degree = paste(degree, collapse = "\n"), .by = "id"),
    by = join_by(id)
  ) |>
  
  # add affiliations
  full_join(
    read_sheet(gid, sheet = "affiliations", col_types = "cc"),
    by = join_by(current_affiliation)
  ) |>
  # add blurbs
  full_join(read_sheet(gid, sheet = "blurbs", col_types = "cc"),
            by = join_by(id)) |>
  replace_na(list(blurb = ""))

mentees |>
  filter(id != "cdmuir") |>
  rowwise() |>
  mutate(index = glue(author_template)) |>
  split( ~ id) |>
  walk(make_author, .path = path, .picture_path = picture_path)
