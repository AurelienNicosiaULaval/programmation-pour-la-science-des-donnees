# STT-4230 / STT-6230, séance du 7 octobre 2026.
# Comparaisons de conception graphique, à partir des mêmes données réelles.
# Exécuter depuis ce dossier :
# source("bonnes-pratiques-visualisation-semaine-06.R")
# Dépendances : install.packages(c("ggplot2", "dplyr", "scales"))
# Sources pédagogiques :
# https://clauswilke.com/dataviz/proportional-ink.html
# https://clauswilke.com/dataviz/overlapping-points.html
# https://ggplot2.tidyverse.org/reference/facet_wrap.html
# https://ggplot2.tidyverse.org/reference/geom_boxplot.html

library(ggplot2)
library(dplyr)
library(scales)

# Une ligne représente un événement. Le découpage à 175 degrés est pédagogique.
seismes_viz <- as_tibble(datasets::quakes) |>
  mutate(
    region = factor(if_else(long < 175, "Ouest", "Est"),
                    levels = c("Ouest", "Est")),
    classe = factor(floor(mag), levels = 4:6,
                    labels = c("[4, 5[", "[5, 6[", "[6, 7["))
  )
proportions_viz <- seismes_viz |>
  count(region, classe, .drop = FALSE) |>
  group_by(region) |>
  mutate(proportion = n / sum(n)) |>
  ungroup()
part_magnitude_basse <- proportions_viz |>
  filter(classe == "[4, 5[")
profondeurs_moyennes <- seismes_viz |>
  group_by(region) |>
  summarise(profondeur_moyenne = mean(depth), .groups = "drop")

stopifnot(nrow(seismes_viz) == 1000L, !anyNA(seismes_viz),
          sum(proportions_viz$n) == 1000L,
          all(abs(tapply(proportions_viz$proportion,
                         proportions_viz$region, sum) - 1) < 1e-12),
          nrow(part_magnitude_basse) == 2L,
          all(part_magnitude_basse$proportion > 0.70),
          all(part_magnitude_basse$proportion < 0.85))

palette_viz <- c("Ouest" = "#0072B2", "Est" = "#D55E00")
theme_viz <- theme_minimal(base_size = 17) +
  theme(panel.grid.minor = element_blank(),
        legend.position = "none",
        plot.margin = margin(10, 14, 8, 8),
        strip.text = element_text(size = 16),
        axis.title = element_text(size = 16))
pourcentage_viz <- label_percent(accuracy = 1, decimal.mark = ",")
etiquette_viz <- label_percent(accuracy = 0.1, decimal.mark = ",", suffix = " %")

# 1. Les valeurs sont identiques; seule l'origine de l'axe change.
# coord_cartesian() recadre l'affichage sans supprimer de lignes.
barres_magnitude <- ggplot(part_magnitude_basse,
                          aes(region, proportion, fill = region)) +
  geom_col(width = 0.58) +
  geom_text(aes(label = etiquette_viz(proportion)),
            vjust = -0.5, size = 5.5) +
  scale_fill_manual(values = palette_viz) +
  labs(x = "Sous-ensemble", y = "Part des séismes de magnitude < 5") +
  theme_viz
figure_viz_zero_eviter <- barres_magnitude +
  scale_y_continuous(labels = pourcentage_viz,
                     breaks = seq(0.70, 0.85, 0.05)) +
  coord_cartesian(ylim = c(0.70, 0.85), expand = FALSE)
figure_viz_zero_choisir <- barres_magnitude +
  scale_y_continuous(labels = pourcentage_viz,
                     breaks = seq(0, 1, 0.25), limits = c(0, 1),
                     expand = expansion(mult = c(0, 0)))

# 2. Des échelles libres conviennent parfois à l'étude d'un panneau isolé.
# Ici, l'objectif est de comparer les hauteurs entre Ouest et Est.
barres_facettes <- ggplot(proportions_viz, aes(classe, proportion)) +
  geom_col(fill = "#0072B2", width = 0.7) +
  labs(x = "Classe de magnitude", y = "Part dans le sous-ensemble") +
  theme_viz
figure_viz_echelles_eviter <- barres_facettes +
  facet_wrap(vars(region), nrow = 1, scales = "free_y") +
  scale_y_continuous(labels = pourcentage_viz,
                     expand = expansion(mult = c(0, 0.06)))
figure_viz_echelles_choisir <- barres_facettes +
  facet_wrap(vars(region), nrow = 1, scales = "fixed") +
  scale_y_continuous(labels = pourcentage_viz,
                     breaks = seq(0, 1, 0.25), limits = c(0, 1),
                     expand = expansion(mult = c(0, 0)))

# 3. Une moyenne est un résumé adapté à certaines questions.
# Elle ne montre pas la dispersion des profondeurs, qui est la question ici.
figure_viz_distribution_eviter <- ggplot(
  profondeurs_moyennes, aes(region, profondeur_moyenne, fill = region)
) +
  geom_col(width = 0.58) +
  scale_fill_manual(values = palette_viz) +
  scale_y_continuous(limits = c(0, 700), breaks = seq(0, 600, 200)) +
  labs(x = "Sous-ensemble", y = "Profondeur (km)") + theme_viz
figure_viz_distribution_choisir <- ggplot(
  seismes_viz, aes(region, depth, fill = region)
) +
  geom_boxplot(width = 0.55, outlier.shape = NA, alpha = 0.45) +
  geom_point(position = position_jitter(width = 0.14, height = 0, seed = 4230),
             size = 1.2, alpha = 0.18, colour = "#17303d") +
  scale_fill_manual(values = palette_viz) +
  scale_y_continuous(limits = c(0, 700), breaks = seq(0, 600, 200)) +
  labs(x = "Sous-ensemble", y = "Profondeur (km)") + theme_viz
# Seule la position horizontale des points est décalée pour les distinguer.
# Les profondeurs sont inchangées; les 1000 observations restent représentées.

# 4. Même nuage, mêmes axes : taille et transparence changent seulement.
nuage_magnitude <- ggplot(seismes_viz, aes(mag, depth)) +
  scale_x_continuous(limits = c(4, 6.5), breaks = seq(4, 6.5, 0.5)) +
  scale_y_continuous(limits = c(0, 700), breaks = seq(0, 600, 200)) +
  labs(x = "Magnitude", y = "Profondeur (km)") + theme_viz
figure_viz_points_eviter <- nuage_magnitude +
  geom_point(size = 4, alpha = 1, colour = "#0072B2")
figure_viz_points_choisir <- nuage_magnitude +
  geom_point(size = 1.5, alpha = 0.25, colour = "#0072B2")

# Exporter les huit figures. Le HTML du diaporama les embarque également.
dossier_viz <- Sys.getenv("STT4230_OUTPUT_DIR", unset = "outputs")
dir.create(dossier_viz, showWarnings = FALSE, recursive = TRUE)
figures_viz <- list(
  "viz-zero-eviter" = figure_viz_zero_eviter,
  "viz-zero-choisir" = figure_viz_zero_choisir,
  "viz-echelles-eviter" = figure_viz_echelles_eviter,
  "viz-echelles-choisir" = figure_viz_echelles_choisir,
  "viz-distribution-eviter" = figure_viz_distribution_eviter,
  "viz-distribution-choisir" = figure_viz_distribution_choisir,
  "viz-points-eviter" = figure_viz_points_eviter,
  "viz-points-choisir" = figure_viz_points_choisir
)
for (nom_figure in names(figures_viz)) {
  ggsave(file.path(dossier_viz, paste0(nom_figure, ".png")),
         plot = figures_viz[[nom_figure]], width = 6.8, height = 4.6,
         units = "in", dpi = 180, bg = "white")
}
stopifnot(all(file.exists(file.path(dossier_viz,
                                   paste0(names(figures_viz), ".png")))))
cat("Huit figures comparatives enregistrées dans :", dossier_viz, "\n")
