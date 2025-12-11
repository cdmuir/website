# Join Us! ----

# Research ----

# Publications ----

authors_from_entry = function(entry, mentees) {
  
  first = entry$author |>
    map("given") |>
    map_chr(str_c, collapse = " ")
  last = entry$author |>
    map("family") |>
    map_chr(str_c, collapse = " ")
  authors = paste(first, last)
  
  author_has_id = authors %in% mentees$author
  
  if (length(authors) > 12) {
    if (any(author_has_id)) {
      authors = c(
        authors[1:6],
        authors[author_has_id],
        glue(
          "author{s} {n1} of {n2}",
          s = ifelse(length(which(author_has_id)) == 1, "", "s"),
          n1 = str_c(which(author_has_id), collapse = ", "),
          n2 = length(authors)
        )
      )
    } else {
      authors = c(authors[1:6], "et al.")
    }
    author_has_id = authors %in% mentees$author
  }
  
  if (any(author_has_id)) {
    authors[author_has_id] = mentees$id[match(authors[author_has_id], mentees$author)]
  } 
  
  authors = str_c("  - ", authors) |>
    str_c(collapse = "\n")
  
  authors
  
}

journal_from_entry = function(entry) {
  
  j = entry$journal
  if (!is.null(j)) {
    j |>
      str_replace_all("\\\\&", "&")
  } else {
    "Preprint"
  }
}

url_from_entry = function(entry, pub_urls, .pub_id) {
  
  pub_urls |>
    filter(pub_id == .pub_id) |>
    select(preprint, article, code, data) |>
    pivot_longer(everything()) |>
    mutate(x = case_when(
      name == "preprint" & !is.na(value) ~ glue("- name: Preprint\n  url: '{value}'", .trim = FALSE),
      name == "article" & !is.na(value) ~ glue("url_pdf: '{value}'", .trim = FALSE),
      name == "code" & !is.na(value) ~ glue("url_code: '{value}'", .trim = FALSE),
      name == "data" & !is.na(value) ~ glue("url_dataset: '{value}'", .trim = FALSE)
    )) |>
    filter(!is.na(value)) |>
    pull(x) |>
    str_c(collapse = "\n")
  
}

featured_from_entry = function(entry, pub_urls, .pub_id) {
  
  pub_urls |>
    filter(pub_id == .pub_id) |>
    select(featured) |>
    mutate(featured = ifelse(featured, "true", "false")) |>
    pull(featured)
  
}

convert_title = function(text) {
  
  out <- text
  
  # 1. \textit{foo} → foo
  out <- str_replace_all(out,
                         "\\\\textit\\{([^}]*)\\}",
                         "\\1")
  
  # 2. \textbf{foo} → foo
  out <- str_replace_all(out,
                         "\\\\textbf\\{([^}]*)\\}",
                         "\\1")
  
  # 3. Remove subscripts of the form x_{y} or x_{\textrm{y}}
  # 3a. Handle \textrm{y}
  out <- str_replace_all(out,
                         "_\\{\\\\textrm\\{([^}]*)\\}\\}",
                         "\\1")
  
  # 3b. Handle plain x_{y}
  out <- str_replace_all(out,
                         "_\\{([^}]*)\\}",
                         "\\1")
  
  # 3c. Handle LaTeX x_y (simple one-character or alphanumeric)
  out <- str_replace_all(out,
                         "_([A-Za-z0-9]+)",
                         "\\1")
  
  # 4. Remove inline math delimiters \( \), $...$, if present
  out <- str_replace_all(out, "\\$", "")          # remove $
  out <- str_replace_all(out, "\\\\\\(|\\\\\\)", "") # remove \( \)

  # 5. Remove words protected by {}
  out <- str_replace_all(out,
                         "\\{([^}]*)\\}",
                         "\\1")

  # 6. \% → %
  out <- str_replace_all(out, "\\\\%", "%")
  
  return(out)
}


convert_abstract = function(text) {
  
  out <- text
  
  # 1. \textit{foo} → *foo*
  out <- str_replace_all(out,
                         "\\\\textit\\{([^}]*)\\}",
                         "*\\1*")
  
  # 2. \textbf{foo} → **foo**
  out <- str_replace_all(out,
                         "\\\\textbf\\{([^}]*)\\}",
                         "**\\1**")
  
  # 3. Subscripts of the form x_{y} or x_{\textrm{y}}
  #    → x<sub>y</sub>
  # 3a. Handle \textrm{y}
  out <- str_replace_all(out,
                         "_\\{\\\\textrm\\{([^}]*)\\}\\}",
                         "<sub>\\1</sub>")
  
  # 3b. Handle plain x_{y}
  out <- str_replace_all(out,
                         "_\\{([^}]*)\\}",
                         "<sub>\\1</sub>")
  
  # 3c. Handle LaTeX x_y (simple one-character or alphanumeric)
  out <- str_replace_all(out,
                         "_([A-Za-z0-9]+)",
                         "<sub>\\1</sub>")
  
  # 4. Remove inline math delimiters \( \), $...$, if present
  out <- str_replace_all(out, "\\$", "")          # remove $
  out <- str_replace_all(out, "\\\\\\(|\\\\\\)", "") # remove \( \)
  
  # 5. \% → %
  out <- str_replace_all(out, "\\\\%", "%")
  
  return(out)
}

# People ----

make_author = function(.df, .path, .picture_path) {
  
  assert_data_frame(.df, nrows = 1L)
  assert_directory_exists(.picture_path)
  
  # Check if path exists, otherwise create it
  author_path = glue("{.path}{id}", id = .df$id)
  if (!dir.exists(author_path)) dir.create(author_path)
  
  # Write the author index file
  author_index_file = glue("{author_path}/_index.md")
  if (file.exists(author_index_file)) {
    file.rename(author_index_file, glue("{author_path}/_index.bak"))
  }
  write_lines(.df$index, author_index_file)
  
  # Copy the profile picture
  profile_picture1 = glue("{.picture_path}{id}.jpg", id = .df$id)
  profile_picture2 = glue("{author_path}/avatar.jpg")
  if (file.exists(profile_picture2)) {
    file.rename(profile_picture2, glue("{author_path}/avatar.bak"))
  }
  if (file.exists(profile_picture1)) {
    file.copy(profile_picture1, profile_picture2, overwrite = TRUE)
  }
  
  invisible()
  
}