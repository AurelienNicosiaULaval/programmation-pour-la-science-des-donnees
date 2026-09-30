# Introduction à ggplot2 : construction par couches
# STT-4230 / STT-6230, 30 septembre 2026
# Ouvrir ce script dans RStudio et exécuter les sections dans l'ordre.
# Exécution complète : Rscript --vanilla demonstration-semaine-05.R
# Sortie : figures/croissance-orangers.png dans le répertoire de travail.
# Les appels explicites à print() affichent les figures avec source().
# En exécution non interactive, les aperçus sont regroupés dans Rplots.pdf.
# Les 35 mesures portent sur 5 arbres suivis à 7 dates.
# Une ligne relie les mesures d'un même arbre ; elle n'est pas une régression.

## ---- initialisation
# Packages requis : ggplot2 et dplyr.
# Installation une fois, au besoin : install.packages(c("ggplot2", "dplyr"))
library(ggplot2)
library(dplyr)

# Taille des textes adaptée à la projection.
theme_set(theme_gray(base_size = 16))

# Données réelles incluses dans R. Aucune connexion Internet requise.
# Source : datasets::Orange ; help("Orange", package = "datasets").
arbres <- as_tibble(datasets::Orange) |>
  transmute(
    arbre = factor(Tree, levels = as.character(1:5), ordered = FALSE),
    temps_j = age,
    circonf_mm = circumference
  )
stopifnot(nrow(arbres) == 35L, n_distinct(arbres$arbre) == 5L,
          !anyNA(arbres), all(count(arbres, arbre)$n == 7L))

## ---- base
p0 <- ggplot(
  arbres,
  aes(x = temps_j, y = circonf_mm)
)
print(p0)

## ---- points
p1 <- p0 +
  geom_point(size = 3)
print(p1)

## ---- couleur
p2 <- p0 +
  geom_point(aes(colour = arbre),
             size = 3)
print(p2)

## ---- constante
p_fixe <- p0 +
  geom_point(colour = "steelblue",
             size = 3)
print(p_fixe)

## ---- piege
p_piege <- p0 +
  geom_point(aes(colour = "steelblue"),
             size = 3)
print(p_piege)

## ---- lignes
p3 <- p0 +
  geom_line(aes(group = arbre),
            colour = "grey65") +
  geom_point(aes(colour = arbre),
             size = 3)
print(p3)

## ---- global
p4 <- ggplot(
  arbres,
  aes(temps_j, circonf_mm,
      colour = arbre, group = arbre)
) +
  geom_line(linewidth = 0.8) +
  geom_point(size = 3)
print(p4)

## ---- etiquettes
p5 <- p4 +
  labs(
    title = "Croissance de cinq orangers",
    x = "Temps (jours)",
    y = "Circonférence du tronc (mm)",
    colour = "Arbre"
  )
print(p5)

## ---- echelle
p6 <- p5 +
  scale_colour_brewer(palette = "Dark2")
print(p6)

## ---- facettes
p7 <- p6 +
  facet_wrap(vars(arbre), nrow = 1) +
  guides(colour = "none")
print(p7)

## ---- apparence
p8 <- p6 +
  theme_minimal(base_size = 16) +
  theme(legend.position = "bottom")
print(p8)

## ---- complet
figure <- ggplot(
  arbres,
  aes(temps_j, circonf_mm,
      colour = arbre, group = arbre)
) +
  geom_line(linewidth = 0.8) +
  geom_point(size = 3) +
  scale_colour_brewer(palette = "Dark2") +
  labs(
    title = "Croissance de cinq orangers",
    x = "Temps (jours)",
    y = "Circonférence du tronc (mm)",
    colour = "Arbre"
  ) +
  theme_minimal(base_size = 16) +
  theme(legend.position = "bottom")
print(figure)

## ---- export
dir.create("figures", showWarnings = FALSE)
ggsave(
  "figures/croissance-orangers.png",
  plot = figure,
  width = 9, height = 5, units = "in",
  dpi = 300
)

## ---- solution
solution <- ggplot(
  arbres,
  aes(temps_j, circonf_mm)
) +
  geom_line(aes(group = arbre),
            colour = "grey60") +
  geom_point(colour = "steelblue", size = 3) +
  facet_wrap(vars(arbre), nrow = 1) +
  labs(x = "Temps (jours)",
       y = "Circonférence du tronc (mm)") +
  theme_minimal(base_size = 16)
print(solution)
