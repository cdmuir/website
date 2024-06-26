# Make individual pages for publications
source("r/header.R")

path = "content/publications/"
picture_path = "assets/media/"

pub_template = read_lines("templates/publication.md")

pubs = read.bib("../cv/data/publications.bib") 
pub_urls = read_csv("../cv/data/publication-urls.csv", show_col_types = FALSE) |>
  left_join(
    read_csv("csv/publication-images.csv", show_col_types = FALSE),
    by = join_by(pub_id)
  ) |>
  replace_na(list(caption = ""))
mentees = read_csv("../cv/data/mentees.csv", show_col_types = FALSE) |>
  mutate(author = paste(given, last)) |>
  select(id, author)
  
assert_set_equal(names(pubs), pub_urls$pub_id)

walk(seq_len(length(pubs)), \(.entry) {
  
  .pub_id = names(pubs)[.entry]
  entry = pubs[[.entry]]
  path = str_c("content/publication/", .pub_id)
  if (!dir.exists(path)) {
    dir.create(path, recursive = TRUE)
  }
  
  dat = tibble(
    title = entry$title |>
      str_replace_all("\\{(\\w+)\\}", "\\1") |>
      str_replace_all("\\\\textit\\{([^}]*)\\}", "\\1"),
    authors = authors_from_entry(entry, mentees),
    xdate = ymd_hms(paste0(entry$year, "-", entry$month, "-01 00:00:00")),
    publish_date = format_ISO8601(Sys.time(), usetz = FALSE),
    publication = entry$journal |>
      str_replace_all("\\\\&", "&"),
    abstract = entry$abstract |>
      str_replace_all("\\\\%", "%"),
    url = url_from_entry(entry, pub_urls, .pub_id),
    featured = featured_from_entry(entry, pub_urls, .pub_id),
    caption = pub_urls$caption[pub_urls$pub_id == .pub_id]
  )
  
  map(pub_template, \(x) {
    glue(x, .envir = dat)
  }) |>
    unlist() |>
    write_lines(str_c(path, "/index.md"))

  write.bib(entry, str_c(path, "/cite.bib"))

})

