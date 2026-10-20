# Démonstration Quarto dans une copie de travail.
# Ouvrir ce script dans RStudio avant de l'exécuter.

# Retrouver le dossier du script dans RStudio ou avec Rscript.
script_argument <- grep("^--file=", commandArgs(), value = TRUE)
if (length(script_argument) == 1L) {
  script_path <- sub("^--file=", "", script_argument)
} else if (requireNamespace("rstudioapi", quietly = TRUE) &&
           rstudioapi::isAvailable()) {
  script_path <- rstudioapi::getSourceEditorContext()$path
} else {
  stop("Exécuter ce script avec Rscript ou l'ouvrir dans RStudio.")
}
if (!nzchar(script_path)) stop("Enregistrer le script avant de l'exécuter.")
demo_directory <- dirname(normalizePath(script_path, mustWork = TRUE))
source_directory <- file.path(demo_directory, "apres")
target_directory <- file.path(demo_directory, "direct")
dir.create(target_directory, showWarnings = FALSE)

# Copier les sources; docs/ sera reconstruit par Quarto.
source_files <- list.files(source_directory, all.files = TRUE,
                          full.names = TRUE, no.. = TRUE)
source_files <- source_files[!basename(source_files) %in% c("docs", ".quarto")]
copy_status <- file.copy(source_files, target_directory,
                         recursive = TRUE, overwrite = TRUE)
stopifnot(all(copy_status))

# Modifier un seul titre, puis effectuer un vrai rendu du site.
index_file <- file.path(target_directory, "index.qmd")
index_text <- readLines(index_file, warn = FALSE, encoding = "UTF-8")
stopifnot(sum(index_text == "## Des analyses à partager") == 1L)
index_text[index_text == "## Des analyses à partager"] <-
  "## Des résultats qui se vérifient"
writeLines(index_text, index_file, useBytes = TRUE)

quarto_executable <- Sys.which("quarto")
if (!nzchar(quarto_executable)) stop("Quarto est introuvable.")
render_status <- system2(quarto_executable,
                         c("render", shQuote(target_directory)))
if (render_status != 0L) stop("Le rendu Quarto a échoué.")
output_file <- file.path(target_directory, "docs", "index.html")
stopifnot(file.exists(output_file))
message("Rendu terminé : ", output_file)
if (interactive()) utils::browseURL(output_file)
