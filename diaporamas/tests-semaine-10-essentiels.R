# STT-4230 / STT-6230, semaine 10. Code sous licence CC BY-NC-SA 4.0.
# Depuis le dossier qui contient les deux fichiers R :
# source("tests-semaine-10-essentiels.R")
# Installer testthat au préalable si nécessaire.

library(testthat)

invisible(capture.output(suppressMessages(
  source("demonstration-semaine-10-essentiels.R", local = TRUE)
)))

test_that("la fonction calcule la proportion et vérifie les mesures", {
  expect_equal(proportion_seuil(c(12, 8, NA, 15, 10)), 0.75)
  expect_equal(proportion_seuil(c(2, 4)), 0)
  expect_error(proportion_seuil(numeric(0)), "Aucune mesure observée")
})
