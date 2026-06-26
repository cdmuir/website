# Make individual pages for talks (invited seminars and contributed presentations)
source("r/header.R")

path = "content/talk/"
talk_template = read_lines("templates/talk.md")

# Load invited seminars and contributed presentations
invited = read_csv("../cv/data/invited-seminars.csv", show_col_types = FALSE) |>
  mutate(
    talk_type = "invited-seminar",
    key = paste0("muir_", str_extract(tolower(title), "^[a-z]+"), "_", year)
  ) |>
  filter(year >= 2019)

contributed = read_csv("../cv/data/contributed-presentations.csv", show_col_types = FALSE) |>
  mutate(talk_type = "contributed-presentation") |>
  select(key, year, pres_type = type, title, conference, location, talk_type) |>
  rename(venue = conference) |>
  mutate(venue = ifelse(is.na(venue) | venue == "", location, venue)) |>
  filter(year >= 2019)

invited_conf = read_csv("../cv/data/invited-conf-presentations.csv", show_col_types = FALSE) |>
  mutate(
    talk_type = "invited-conf-presentation",
    pres_type = "talk",
    key = paste0("muir_", str_extract(tolower(title), "^[a-z]+"), "_conf_", year),
    venue = conference
  ) |>
  select(key, year, pres_type, title, venue, location, talk_type) |>
  filter(year >= 2019)

# Combine all three data sources
talks = bind_rows(invited, contributed, invited_conf) |>
  arrange(desc(year), desc(talk_type)) |>
  mutate(
    xdate = ymd(paste0(year, "-01-01")),
    talk_id = str_replace_all(tolower(key), "[^a-z0-9]", "_"),
    featured = FALSE,
    location = replace_na(location, ""),
    pres_type = replace_na(pres_type, "talk"),
    # Build a human-readable description based on talk type
    description = case_when(
      talk_type == "invited-seminar" ~
        str_c("Invited seminar at ", venue, "."),
      talk_type == "invited-conf-presentation" ~
        str_c("Invited ", pres_type, " at ", venue,
              ifelse(location != "", str_c(", ", location), ""), "."),
      talk_type == "contributed-presentation" ~
        str_c("Contributed ", pres_type, " at ", venue,
              ifelse(location != "", str_c(", ", location), ""), "."),
    )
  )

# Create pages for each talk
walk(seq_along(talks$key), \(.i) {
  
  .talk = talks[.i, ]
  
  # Create directory if it doesn't exist
  talk_path = str_c(path, .talk$talk_id)
  if (!dir.exists(talk_path)) {
    dir.create(talk_path, recursive = TRUE)
  }
  
  # Determine publish date (use existing if available, otherwise use current time)
  if (file.exists(str_c(talk_path, "/index.md"))) {
    publish_date = read_lines(str_c(talk_path, "/index.md")) |>
      str_extract("publishDate: .*") |>
      str_remove("publishDate: ") |>
      na.omit() |>
      ymd_hms()
    if (length(publish_date) == 0) {
      publish_date = Sys.time()
    }
  } else {
    publish_date = Sys.time()
  }
  
  # Prepare data for template
  dat = tibble(
    title = convert_title(.talk$title),
    xdate = format(.talk$xdate),
    publish_date = format_ISO8601(publish_date, usetz = FALSE),
    venue = convert_title(.talk$venue),
    location = convert_title(.talk$location),
    description = convert_title(.talk$description),
    talk_type = .talk$talk_type,
    featured = ifelse(.talk$featured, "true", "false")
  )
  
  env_dat = list2env(as.list(dat), parent = emptyenv())
  
  # Generate and write the markdown file
  map(talk_template, \(x) {
    glue(x, .envir = env_dat)
  }) |>
    unlist() |>
    write_lines(str_c(talk_path, "/index.md"))
  
})

cat(glue("Created {nrow(talks)} talk pages.\n"))
