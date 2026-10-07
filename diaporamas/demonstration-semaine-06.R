# STT-4230 / STT-6230, séance du 7 octobre 2026.
# Exécuter depuis le dossier contenant ce script :
# source("demonstration-semaine-06.R")
# Dépendances, à installer une seule fois au besoin :
# install.packages(c("ggplot2", "dplyr", "readr", "scales"))

# Charger les bibliothèques.
library(ggplot2)
library(dplyr)
library(readr)
library(scales)

# Les données réelles sont incluses dans R, sans téléchargement.
# Source : R Core Team, aide de datasets::quakes.
# https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/quakes.html
# Le découpage à 175 degrés reprend les notes de Sophie Baillargeon (2021).
# https://stt4230.rbind.io/communication_resultats/graphiques_ggplot2_r/
# Il définit deux sous-ensembles pédagogiques, pas des régions administratives.
seismes <- as_tibble(datasets::quakes) |>
  mutate(
    region = factor(if_else(long < 175, "Ouest", "Est"),
                    levels = c("Ouest", "Est")),
    classe = factor(floor(mag), levels = 4:6,
                    labels = c("[4, 5[", "[5, 6[", "[6, 7["))
  )
stopifnot(nrow(seismes) == 1000L, !anyNA(seismes))

# Résumer séparément les données pour rendre le dénominateur vérifiable.
# .drop = FALSE conserve aussi la combinaison Est / [6, 7[, de fréquence nulle.
effectifs <- seismes |>
  count(region, classe, .drop = FALSE)
proportions <- effectifs |>
  group_by(region) |>
  mutate(total_region = sum(n), proportion = n / total_region) |>
  ungroup()
verification <- proportions |>
  group_by(region) |>
  summarise(total = sum(n), somme = sum(proportion), .groups = "drop")
stopifnot(sum(effectifs$n) == nrow(seismes),
          all(abs(verification$somme - 1) < 1e-12))

# Construire les figures sans modifier le thème global de la session.
palette_regions <- c("Ouest" = "#0072B2", "Est" = "#D55E00")
theme_cours <- theme_minimal(base_size = 16) +
  theme(legend.position = "bottom", panel.grid.minor = element_blank())

figure_points <- ggplot(seismes, aes(mag, depth)) +
  geom_point(alpha = 0.35, colour = "#0072B2", size = 2) +
  labs(x = "Magnitude", y = "Profondeur (km)") + theme_cours
figure_histogramme <- ggplot(seismes, aes(mag)) +
  geom_histogram(binwidth = 0.2, boundary = 4,
                 fill = "#0072B2", colour = "white") +
  labs(x = "Magnitude", y = "Nombre de séismes") + theme_cours
figure_boites <- ggplot(seismes, aes(region, depth)) +
  geom_boxplot(fill = "#c7dfe8") +
  labs(x = "Sous-ensemble géographique", y = "Profondeur (km)") + theme_cours

figure_comptage <- ggplot(seismes, aes(classe)) +
  geom_bar(fill = "#0072B2") +
  labs(x = "Classe de magnitude", y = "Nombre de séismes") + theme_cours
figure_effectifs <- ggplot(effectifs, aes(classe, n, fill = region)) +
  geom_col(position = "dodge", width = 0.8) +
  scale_fill_manual(values = palette_regions) +
  labs(x = "Classe de magnitude", y = "Nombre de séismes", fill = "Sous-ensemble") +
  theme_cours

figure_proportions <- ggplot(proportions, aes(classe, proportion, fill = region)) +
  geom_col(position = position_dodge(width = 0.9), width = 0.8) +
  scale_fill_manual(values = palette_regions) +
  scale_y_continuous(labels = label_percent(accuracy = 1),
                     limits = c(0, 1), expand = expansion(mult = c(0, 0.03))) +
  labs(title = "Magnitudes des séismes dans deux sous-ensembles",
       subtitle = "Chaque sous-ensemble totalise 100 %",
       x = "Classe de magnitude", y = "Proportion dans le sous-ensemble",
       fill = "Sous-ensemble") + theme_cours

etiquette_pct <- label_percent(accuracy = 0.1, decimal.mark = ",", suffix = " %")
figure_annotee <- figure_proportions +
  geom_text(aes(label = etiquette_pct(proportion)),
            position = position_dodge(width = 0.9), vjust = -0.35, size = 4.5)
figure_facettes <- ggplot(proportions, aes(classe, proportion)) +
  geom_col(fill = "#0072B2", width = 0.8) +
  facet_wrap(vars(region), nrow = 1) +
  scale_y_continuous(labels = label_percent(accuracy = 1), limits = c(0, 1)) +
  labs(x = "Classe de magnitude", y = "Proportion dans le sous-ensemble") + theme_cours

# Figure volontairement incomplète pour l'activité de critique.
figure_a_revoir <- ggplot(proportions, aes(classe, proportion, fill = region)) +
  geom_col(position = "dodge") +
  scale_fill_manual(values = c("Ouest" = "#999999", "Est" = "#aaaaaa")) +
  theme_cours

# Prolongement : le calcul dans stat_count exige un groupement explicite.
figure_after_stat <- ggplot(
  seismes, aes(classe, after_stat(prop), group = region, fill = region)
) +
  geom_bar(position = "dodge", width = 0.8) +
  scale_fill_manual(values = palette_regions) +
  scale_y_continuous(labels = label_percent(accuracy = 1), limits = c(0, 1)) +
  labs(x = "Classe de magnitude", y = "Proportion dans le sous-ensemble",
       fill = "Sous-ensemble") + theme_cours

# Enregistrer les résultats avec des chemins relatifs explicites.
# Le dossier de sortie peut être changé pour une vérification dans une copie séparée.
dossier_sortie <- Sys.getenv("STT4230_OUTPUT_DIR", unset = "outputs")
dir.create(dossier_sortie, recursive = TRUE, showWarnings = FALSE)
ggsave(file.path(dossier_sortie, "06-proportions-seismes.png"),
       plot = figure_annotee, width = 10, height = 6, units = "in", dpi = 300,
       bg = "white")
write_csv(proportions, file.path(dossier_sortie, "06-proportions-seismes.csv"))
stopifnot(file.exists(file.path(dossier_sortie, "06-proportions-seismes.png")))

# Afficher les vérifications numériques. Le rapport et le diaporama peuvent
# réutiliser les objets de ce script sans dépendre d'une session déjà remplie.
print(verification)
cat("Figure et tableau enregistrés dans :", dossier_sortie, "\n")
if (interactive()) print(figure_annotee)
