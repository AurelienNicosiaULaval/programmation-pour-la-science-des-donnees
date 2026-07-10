#!/usr/bin/env Rscript

# Quarto 1.9 produit les pages .llms.md. Ce garde-fou réécrit l'index llms.txt
# avec des liens relatifs afin qu'il reste valide sous un sous-répertoire GitHub Pages.

args <- commandArgs(trailingOnly = TRUE)
output_dir <- if (length(args)) args[[1]] else "_site"

if (!dir.exists(output_dir)) {
  stop("Dossier de sortie introuvable: ", output_dir, call. = FALSE)
}

index_path <- file.path(output_dir, "llms.txt")

files <- list.files(
  output_dir,
  pattern = "\\.llms\\.md$",
  recursive = TRUE,
  full.names = TRUE
)
files <- files[basename(files) != "404.llms.md"]

if (!length(files)) {
  stop("Aucune page .llms.md trouvée dans ", output_dir, call. = FALSE)
}

root <- normalizePath(output_dir, mustWork = TRUE)
relative <- sub(paste0("^", root, "/"), "", normalizePath(files, mustWork = TRUE))
titles <- vapply(files, function(path) {
  lines <- readLines(path, warn = FALSE, encoding = "UTF-8")
  headings <- grep("^# ", lines, value = TRUE)
  if (length(headings)) sub("^# ", "", headings[[1]]) else sub("\\.llms\\.md$", "", basename(path))
}, character(1))

order_index <- order(relative)
lines <- c(
  "# STT-4230 / STT-6230 - Programmation pour la science des données",
  "",
  "> Index LLM du site public du cours.",
  "",
  "## Pages",
  "",
  paste0("- [", titles[order_index], "](", relative[order_index], ")")
)

writeLines(lines, index_path, useBytes = TRUE)
message("Index LLM normalisé: ", index_path, " (", length(files), " pages)")
