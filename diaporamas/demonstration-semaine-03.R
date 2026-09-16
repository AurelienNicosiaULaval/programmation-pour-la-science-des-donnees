# STT-4230 / STT-6230, séance du 16 septembre 2026
# Retour sur le mini-test 2 et démonstrations de calculs en R.
# Tous les exemples de mesures sont fictifs; les tirages sont simulés.
# Exécution complète : Rscript --vanilla demonstration-semaine-03.R
# Les étiquettes servent aussi à inclure le code dans le diaporama Quarto.

## ---- initialisation ----
library(stats)
library(graphics)
options(width = 65, digits = 5)

## ---- question-moyenne ----
x <- c(2, 4, NA, 8)
print(c(mean(x), mean(x, na.rm = TRUE)))

## ---- denominateur ----
n_observees <- sum(!is.na(x))
print(n_observees)
print(sum(x, na.rm = TRUE) / n_observees)

## ---- reperer-na ----
x <- c(2, 4, NA, 8)
print(is.na(x))
print(which(is.na(x)))

## ---- omettre-na ----
x_observe <- na.omit(x)
print(x_observe)

## ---- verifier-omission ----
# L'objet initial reste inchangé; la moyenne utilise 3 valeurs.
print(x)
print(mean(x_observe))
stopifnot(is.na(x[3]), length(x_observe) == 3)

## ---- question-simulation ----
set.seed(2026)
z <- rnorm(10000)
print(mean(z > 1.96))

## ---- proportion-logique ----
petit_z <- c(-0.5, 2.1, 0.3, 2.4, -1)
print(petit_z > 1.96)
print(c(
  proportion = mean(petit_z > 1.96),
  moyenne_selection = mean(petit_z[petit_z > 1.96])
))

## ---- probabilite-theorique ----
probabilite <- pnorm(
  1.96, lower.tail = FALSE
)
print(c(
  simulation = mean(z > 1.96),
  theorie = probabilite))

## ---- graphique-normale ----
# Graphique statistique, aire sous la densité normale standard.
par(mar = c(4, 4, 1, 1), family = "sans", cex = 1.4)
grille <- seq(-4, 4, length.out = 1200)
plot(grille, dnorm(grille), type = "l", lwd = 3,
     xlab = "Valeur de Z", ylab = "Densité", col = "#083d53",
     ylim = c(0, 0.43), bty = "l")
queue <- seq(1.96, 4, length.out = 400)
polygon(c(1.96, queue, 4), c(0, dnorm(queue), 0),
        col = "#087d85", border = NA)
lines(grille, dnorm(grille), lwd = 3, col = "#083d53")
abline(v = 1.96, lty = 2, col = "#536975", lwd = 2)
text(2.55, 0.12, "Aire : environ 0,025", col = "#087d85", cex = 0.9)

## ---- graine ----
set.seed(2026)
tirage_a <- rnorm(4)
tirage_suivant <- rnorm(4)
set.seed(2026)
tirage_b <- rnorm(4)
print(identical(tirage_a, tirage_b))
print(identical(tirage_a, tirage_suivant))

## ---- vectorisation ----
temperature <- c(6, 8, 10, 12) # Degrés Celsius, fictifs.
print(temperature + 2)
print(temperature > 9)
print(mean(temperature > 9))

## ---- recyclage ----
correction <- c(1, -1)
print(temperature + correction)
print(rep(correction, length.out = length(temperature)))

## ---- operations-matrices ----
a <- matrix(c(1, 2, 3, 4), nrow = 2, byrow = TRUE)
print(a * a)
print(a %*% a)

## ---- matrice-mesures ----
# Températures fictives en degrés Celsius.
mesures <- cbind(Quebec = c(6, 8, NA),
                 Levis = c(7, 9, 11))
rownames(mesures) <- c("Jour 1", "Jour 2", "Jour 3")
print(mesures)
print(which(is.na(mesures), arr.ind = TRUE))

## ---- moyennes-colonnes ----
print(apply(
  mesures, 2, mean, na.rm = TRUE
))

## ---- alternative-colonnes ----
print(colMeans(mesures, na.rm = TRUE))

## ---- moyennes-lignes ----
print(apply(
  mesures, 1, mean, na.rm = TRUE
))

## ---- effectifs-lignes ----
print(rowSums(!is.na(mesures)))

## ---- moyennes-groupes ----
valeurs <- c(6, 8, NA, 7, 9, 11)
site <- rep(c("Quebec", "Levis"), each = 3)
print(tapply(
  valeurs, site, mean, na.rm = TRUE
))

## ---- effectifs-groupes ----
print(tapply(!is.na(valeurs), site, sum))

## ---- listes-groupes ----
# split construit une liste de valeurs par site.
par_site <- split(valeurs, site)
print(lapply(par_site, mean, na.rm = TRUE))
print(sapply(par_site, mean, na.rm = TRUE))

## ---- verifier-groupes ----
# Même calcul sur la matrice et sur les vecteurs avec groupes.
moyennes_par_groupe <- tapply(valeurs, site, mean, na.rm = TRUE)
moyennes_par_colonne <- colMeans(mesures, na.rm = TRUE)
stopifnot(isTRUE(all.equal(
  as.numeric(moyennes_par_groupe[colnames(mesures)]),
  as.numeric(moyennes_par_colonne)
)))

## ---- exercice-minute ----
pluie <- c(0, 12, NA, 4, 20) # Millimètres, données fictives.
print(mean(pluie > 10, na.rm = TRUE))

## ---- verification-minute ----
print(c(
  jours_observes = sum(!is.na(pluie)),
  jours_plus_10 = sum(pluie > 10, na.rm = TRUE)
))

## ---- fonctions-normales ----
print(c(
  densite = dnorm(1.96),
  probabilite_cumulee = pnorm(1.96),
  quantile_975 = qnorm(0.975)
))

## ---- sources ----
# Sources : R Core Team, documentation de R, consultée le 15 septembre 2026.
# https://stat.ethz.ch/R-manual/R-devel/library/base/html/mean.html
# https://stat.ethz.ch/R-manual/R-devel/library/stats/html/Normal.html
# https://stat.ethz.ch/R-manual/R-devel/library/base/html/Random.html
# https://stat.ethz.ch/R-manual/R-devel/library/base/html/apply.html
# Compléments consultés le 16 septembre 2026 :
# https://stat.ethz.ch/R-manual/R-devel/library/base/html/NA.html
# https://stat.ethz.ch/R-manual/R-devel/library/stats/html/na.fail.html
# https://stat.ethz.ch/R-manual/R-devel/library/base/html/tapply.html
# https://stat.ethz.ch/R-manual/R-devel/library/base/html/lapply.html
