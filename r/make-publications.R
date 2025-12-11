# Make individual pages for publications
# source("../cv/get-bibliography.R")
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

mentees = read_sheet(
  "1vuAQPwkGC8kFNKpVZ0KBE3ZJjXGBR9XIwh1ASQwumjk",
  sheet = "mentees",
  col_types = "ccccclc"
) |> 
  mutate(author = paste(given, last)) |>
  select(id, author)

assert_set_equal(names(pubs), pub_urls$pub_id)
# which(!names(pubs) %in% pub_urls$pub_id)

walk(seq_len(length(pubs)), \(.entry) {
  
  .pub_id = names(pubs)[.entry]
  entry = pubs[[.entry]]
  path = str_c("content/publication/", .pub_id)
  if (!dir.exists(path)) {
    dir.create(path, recursive = TRUE)
  }
  
  dat = tibble(
    title = entry$title |> convert_title(),
    authors = authors_from_entry(entry, mentees),
    xdate = ymd_hms(paste0(entry$year, "-", entry$month, "-01 00:00:00")),
    publish_date = format_ISO8601(Sys.time(), usetz = FALSE),
    publication = journal_from_entry(entry),
    abstract = entry$abstract |> 
      convert_abstract() |>
      paste0(""),
    url = url_from_entry(entry, pub_urls, .pub_id),
    featured = featured_from_entry(entry, pub_urls, .pub_id),
    caption = pub_urls$caption[pub_urls$pub_id == .pub_id]
  )

  env_dat = list2env(as.list(dat), parent = emptyenv())
  
  map(pub_template, \(x) {
    glue(x, .envir = env_dat)
  }) |>
    unlist() |>
    write_lines(str_c(path, "/index.md"))

  write.bib(entry, str_c(path, "/cite.bib"))

})

