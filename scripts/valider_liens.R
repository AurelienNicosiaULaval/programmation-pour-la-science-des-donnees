# Validation des liens relatifs dans les fichiers .qmd et .md
# Ce script s'exécute à la racine du dépôt.

cat("=== Validation des liens relatifs ===\n")

# Lister les fichiers à analyser sans parcourir les répertoires générés.
excluded_dir_names <- c(".git", "_site", ".quarto", "tmp", "renv", "site_libs")

collect_source_files <- function(path = ".") {
  entries <- list.files(path, all.files = TRUE, no.. = TRUE, full.names = TRUE)
  if (length(entries) == 0) {
    return(character())
  }

  info <- file.info(entries)
  files <- entries[!info$isdir & grepl("\\.(qmd|md)$", entries)]
  dirs <- entries[info$isdir]
  dirs <- dirs[
    !basename(dirs) %in% excluded_dir_names &
      !grepl("_files$", basename(dirs))
  ]

  c(files, unlist(lapply(dirs, collect_source_files), use.names = FALSE))
}

all_files <- sort(collect_source_files())

errors <- list()
files_checked <- 0
links_checked <- 0

for (file_path in all_files) {
  files_checked <- files_checked + 1
  lines <- readLines(file_path, warn = FALSE)
  dir_current <- dirname(file_path)
  
  for (line_num in seq_along(lines)) {
    line <- lines[line_num]
    
    # Expression régulière Perl pour extraire le contenu entre les parenthèses qui suivent un crochet fermant
    # (?<=\\]\\()[^\\)]+(?=\\))
    matches <- gregexpr("(?<=\\]\\()[^\\)]+(?=\\))", line, perl = TRUE)
    urls <- regmatches(line, matches)[[1]]
    
    for (url in urls) {
      # Nettoyer l'URL de ses espaces blancs
      url <- trimws(url)
      
      # 1. Ignorer les URLs vides
      if (url == "") next
      
      # 2. Ignorer les URLs externes et les protocoles spéciaux
      if (grepl("^https?://", url, ignore.case = TRUE)) next
      if (grepl("^mailto:", url, ignore.case = TRUE)) next
      if (grepl("^javascript:", url, ignore.case = TRUE)) next
      if (grepl("^#", url)) next # Ancre interne pure dans le même fichier
      
      links_checked <- links_checked + 1
      
      # 3. Retirer l'éventuelle ancre de l'URL cible (ex: chemin.qmd#section -> chemin.qmd)
      url_parts <- strsplit(url, "#")[[1]]
      url_file <- if (length(url_parts) > 0) url_parts[1] else ""
      url_file <- trimws(url_file)
      
      if (url_file == "") next
      
      # 4. Signaler l'utilisation de chemins absolus (non portables)
      is_absolute <- grepl("^(/|[a-zA-Z]:/|[a-zA-Z]:\\\\|file:///)", url_file)
      if (is_absolute) {
        errors <- c(errors, list(list(
          file = file_path,
          line = line_num,
          link = url,
          reason = "Chemin absolu interdit pour la portabilité"
        )))
        next
      }
      
      # 5. Résoudre le chemin relatif par rapport au fichier courant
      target_path <- file.path(dir_current, url_file)
      
      # 6. Vérifier si le fichier existe
      if (!file.exists(target_path)) {
        errors <- c(errors, list(list(
          file = file_path,
          line = line_num,
          link = url,
          reason = sprintf("Le fichier cible n'existe pas : %s", target_path)
        )))
      }
    }
  }
}

cat(sprintf("Fichiers analysés : %d\n", files_checked))
cat(sprintf("Liens relatifs vérifiés : %d\n", links_checked))

if (length(errors) > 0) {
  cat("\n❌ ERREURS DE LIENS DÉTECTÉES :\n")
  for (err in errors) {
    cat(sprintf("  - Dans : %s (Ligne %d)\n", err$file, err$line))
    cat(sprintf("    Lien : %s\n", err$link))
    cat(sprintf("    Erreur : %s\n\n", err$reason))
  }
  stop("La validation des liens a échoué.", call. = FALSE)
} else {
  cat("\n✅ Tous les liens relatifs sont valides !\n")
}
