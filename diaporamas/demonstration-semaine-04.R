# STT-4230 / STT-6230, séance du 23 septembre 2026
# Prétraitement avec le tidyverse. Toutes les mesures sont fictives.
# Exécution : Rscript --vanilla demonstration-semaine-04.R
# R >= 4.1; dplyr >= 1.1.1. Le fichier brut existant n'est jamais écrasé.

## ---- initialisation ----
library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(lubridate)
library(tibble)
library(tools)
options(width = 65, digits = 4, readr.show_progress = FALSE)

# Le dossier distinct préserve les fichiers de la première démonstration.
dossier_demo <- "demo-semaine-04-tidyverse"
dir.create(file.path(dossier_demo, "data", "raw"),
           recursive = TRUE, showWarnings = FALSE)
dir.create(file.path(dossier_demo, "data", "processed"),
           recursive = TRUE, showWarnings = FALSE)
fichier_brut <- file.path(dossier_demo, "data", "raw", "meteo.csv")
fichier_propre <- file.path(dossier_demo, "data", "processed", "meteo.csv")
lignes_brutes <- c(
  "date_texte;ville;tmin;tmax;pluie",
  "01/09/2026; québec ;8,2;18,5;1,5",
  "02/09/2026;QUÉBEC;9,0;19,0;-2,0",
  "03/09/2026;Québec;NA;17,0;NA",
  "01/09/2026;Lévis;7,0;18,0;0,0",
  "02/09/2026; LÉVIS;8,0;20,0;4,0",
  "03/09/2026;Lévis;6,0;16,5;8,0",
  "01/09/2026;Lévis;7,0;18,0;0,0"
)
if (!file.exists(fichier_brut)) {
  write_lines(lignes_brutes, fichier_brut)
} else if (!identical(read_lines(fichier_brut), lignes_brutes)) {
  stop("Le fichier brut existant diffère de l'exemple. Il est conservé. ",
       "Relancez la démonstration depuis un nouveau dossier.")
}
empreinte_brute <- md5sum(fichier_brut)

## ---- importation ----
brut <- read_csv2(
  fichier_brut, trim_ws = FALSE,
  col_types = cols(
    date_texte = col_character(),
    ville = col_character(),
    .default = col_double()
  )
)
glimpse(brut)

## ---- selection ----
meteo <- brut |>
  rename(station = ville,
         temp_min_c = tmin, temp_max_c = tmax,
         precip_mm = pluie) |>
  select(station, date_texte,
         starts_with("temp_"), precip_mm)
print(names(meteo))

## ---- formats ----
meteo <- meteo |>
  mutate(
    station = str_to_title(str_squish(station),
                           locale = "fr"),
    date = dmy(date_texte)
  ) |>
  select(-date_texte) |>
  relocate(date)
print(meteo |> distinct(station))

## ---- amplitude ----
meteo <- meteo |>
  mutate(amplitude_c = temp_max_c - temp_min_c)
print(meteo |> select(station, amplitude_c))

## ---- recodage ----
meteo <- meteo |>
  mutate(
    precip_mm = if_else(precip_mm < 0,
                        NA_real_, precip_mm),
    etat = case_when(
      is.na(precip_mm) ~ "Manquante",
      precip_mm == 0 ~ "Nulle",
      .default = "Positive"
    )
  )
print(meteo |> count(etat))

# Comparer la pluie sur les mêmes sept lignes, avant et après le recodage.
controle_pluie <- tibble(
  etape = c("Avant", "Après"),
  negatives = c(sum(brut$pluie < 0, na.rm = TRUE),
                sum(meteo$precip_mm < 0, na.rm = TRUE)),
  manquantes = c(sum(is.na(brut$pluie)),
                 sum(is.na(meteo$precip_mm)))
)
print(controle_pluie)

# La répétition exacte est traitée ici comme un doublon de saisie.
# distinct() compare toutes les colonnes. Deux mesures différentes
# pour une même clé demanderaient une vérification.
## ---- doublons ----
doublons <- meteo |>
  count(station, date) |>
  filter(n > 1)
propre <- meteo |> distinct()
print(doublons)
print(propre |> count(station))

## ---- filtrage ----
selection_pluie <- propre |>
  filter(station == "Lévis", precip_mm >= 4) |>
  select(date, precip_mm) |>
  arrange(desc(precip_mm))
print(selection_pluie)

## ---- valeurs-manquantes ----
# filter() ne garde que TRUE; une condition NA est exclue.
print(propre |> filter(precip_mm >= 0) |> count())
print(propre |>
        filter(precip_mm >= 0 | is.na(precip_mm)) |>
        count())

## ---- resume-groupes ----
bilan <- propre |>
  group_by(station) |>
  summarise(
    n_lignes = n(),
    n_mesures = sum(!is.na(precip_mm)),
    pluie_moy = mean(precip_mm, na.rm = TRUE),
    .groups = "drop"
  )
print(bilan)

## ---- across ----
bilan_na <- propre |>
  summarise(across(
    c(starts_with("temp_"), precip_mm),
    ~ sum(is.na(.x))
  ))
print(bilan_na)

## ---- repertoire-stations ----
stations <- tribble(
  ~station, ~rive,
  "Québec", "nord",
  "Lévis",  "sud"
)
print(stations)

## ---- jointure ----
avec_rive <- propre |>
  left_join(stations, by = "station",
            relationship = "many-to-one")
print(avec_rive |> distinct(station, rive))

## ---- format-long ----
long <- propre |>
  select(date, station, starts_with("temp_")) |>
  pivot_longer(
    cols = starts_with("temp_"),
    names_to = "mesure", values_to = "temp_c"
  )
# Extrait seulement : l'objet long contient 12 lignes.
print(long |> slice_head(n = 4))

## ---- pipeline ----
classement <- propre |>
  filter(!is.na(precip_mm)) |>
  summarise(n_mesures = n(),
            pluie_moy = mean(precip_mm),
            .by = station) |>
  arrange(desc(pluie_moy))
print(classement)

## ---- exercice ----
jours_pluvieux <- propre |>
  filter(!is.na(precip_mm)) |>
  summarise(
    n_observees = n(),
    n_pluvieux = sum(precip_mm > 0),
    .by = station
  )
print(jours_pluvieux)

## ---- validation-sauvegarde ----
anomalies <- propre |>
  filter(is.na(date) | precip_mm < 0)
cles_repetees <- propre |>
  count(station, date) |>
  filter(n > 1)
stopifnot(nrow(propre) > 0,
          nrow(anomalies) == 0,
          nrow(cles_repetees) == 0)
write_csv(propre, fichier_propre, na = "NA")

## ---- verification-finale ----
# Résultats pédagogiques, clés, remise en forme et conservation du brut.
stopifnot(nrow(problems(brut)) == 0,
          nrow(brut) == 7, nrow(propre) == 6,
          nrow(doublons) == 1, doublons$n == 2,
          setequal(propre$station, c("Québec", "Lévis")),
          inherits(propre$date, "Date"),
          sum(is.na(propre$precip_mm)) == 2,
          isTRUE(all.equal(selection_pluie$precip_mm, c(8, 4))),
          identical(sort(bilan$n_mesures), c(1L, 3L)),
          isTRUE(all.equal(sort(bilan$pluie_moy), c(1.5, 4))),
          bilan_na$temp_min_c == 1, bilan_na$temp_max_c == 0,
          bilan_na$precip_mm == 2,
          nrow(avec_rive) == nrow(propre), !anyNA(avec_rive$rive),
          nrow(long) == 12, sum(is.na(long$temp_c)) == 1,
          !is_grouped_df(bilan), !is_grouped_df(classement))
large_reconstitue <- long |>
  pivot_wider(names_from = mesure, values_from = temp_c)
stopifnot(isTRUE(all.equal(
  large_reconstitue,
  propre |> select(date, station, starts_with("temp_"))
)))
# La règle détecte une date absente et une valeur négative.
# Une précipitation NA est autorisée par la règle de cet exemple.
cas_limites <- tibble(date = as.Date(c(NA, "2026-09-02", "2026-09-03")),
                      precip_mm = c(NA, -1, NA))
stopifnot(nrow(cas_limites |>
                filter(is.na(date) | precip_mm < 0)) == 2)
relu <- read_csv(fichier_propre, col_types = cols(
  date = col_date(), station = col_character(),
  etat = col_character(), .default = col_double()
))
stopifnot(isTRUE(all.equal(as.data.frame(propre), as.data.frame(relu))),
          identical(md5sum(fichier_brut), empreinte_brute))
cat("Démonstration tidyverse terminée; résultats et fichier brut vérifiés.\n")
