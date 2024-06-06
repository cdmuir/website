# Join Us! ----

# Research ----

# Publications ----

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