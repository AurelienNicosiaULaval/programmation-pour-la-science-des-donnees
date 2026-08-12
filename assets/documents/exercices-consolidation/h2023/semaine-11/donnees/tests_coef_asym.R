# Tests et exceptions en R
# Exercices en classe
# Tests avec testthat pour la fonction coef_asym
# auteur : Sophie Baillargeon, Université Laval
# date : 30 mars 2021
# encodage : UTF-8

#**************************************************************************

library(e1071)  # afin de pouvoir utiliser la fonction skewness

n <- 3
moy <- (1 + 1 + 4) / n
m3 <- ((1 - moy)^3 + (1 - moy)^3 + (4 - moy)^3) / n
s3 <- (((1 - moy)^2 + (1 - moy)^2 + (4 - moy)^2) / (n - 1))^(3 / 2)

test_that("coef_asym reproduit un calcul a la main sur un petit jeu de donnees", {
  expect_equal(coef_asym(c(1, 1, 4)), (n^2) * m3 / ((n - 1) * (n - 2) * s3))
  expect_equal(coef_asym(c(1, 1, 4), na.rm = TRUE), (n^2) * m3 / ((n - 1) * (n - 2) * s3))
})

test_that("coef_asym traite correctement les valeurs manquantes", {
  expect_true(is.na(coef_asym(c(1, 1, 4, NA))))
  expect_equal(coef_asym(c(1, 1, 4, NA), na.rm = TRUE), (n^2) * m3 / ((n - 1) * (n - 2) * s3))
})

test_that("coef_asym reproduit des resultats obtenus de la fonction skewness du package e1071", {
  expect_equal(coef_asym(cars$speed), skewness(cars$speed, type = 2))
})

test_that("coef_asym retourne approximativement 0 pour un gros échantillon tire d'une loi normale", {
  expect_equal(coef_asym(rnorm(1000000)), 0, tolerance = 0.01)
})

#**************************************************************************

test_that("coef_asym reagit correctement a un argument x incorrect", {
  expect_warning(coef_asym(matrix(rnorm(16), nrow = 4, ncol = 4)))
  expect_error(coef_asym(as.data.frame(matrix(rnorm(16), nrow = 4, ncol = 4))), "x doit etre un vecteur")
  expect_error(coef_asym(letters))
})

test_that("coef_asym reagit correctement a un argument na.rm incorrect", {
  expect_warning(coef_asym(c(1, 1, 4, NA), na.rm = 4))
  expect_error(coef_asym(c(1, 1, 4, NA), na.rm = "Vrai"))
  expect_warning(coef_asym(c(1, 1, 4, NA), na.rm = c(TRUE, FALSE)))
})


