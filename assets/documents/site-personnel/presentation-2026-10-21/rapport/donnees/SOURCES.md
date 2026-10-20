# Séismes près de Fidji

Fichier : `seismes-fidji.csv`.

Source immédiate : `datasets::quakes`, distribué avec R 4.5.0, exporté le 13 octobre 2026 avec `readr::write_csv()`. Les 1 000 lignes et les cinq variables sont conservées sans modification. Une lecture du CSV a été comparée au tableau original.

La [documentation de R Core Team](https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/quakes.html), consultée le 13 octobre 2026, attribue les données au projet Harvard PRIM-H, qui les avait obtenues de John Woodhouse, Department of Geophysics, Harvard University. Elle situe les événements près de Fidji depuis 1964 et présente ce tableau comme un sous-échantillon d'un ensemble de 5 000 observations.

| Variable | Définition |
| --- | --- |
| `lat` | Latitude de l'événement |
| `long` | Longitude de l'événement |
| `depth` | Profondeur, en kilomètres |
| `mag` | Magnitude |
| `stations` | Nombre de stations ayant rapporté l'événement |

Une ligne représente un séisme. Le tableau ne fournit pas les dates individuelles, une durée précise de suivi ou une mesure de l'effort de détection. Son utilisation dans les supports est descriptive. Les trois classes de magnitude servent à la démonstration.

Pour recréer la copie depuis R :

```r
library(readr)

dir.create("donnees", showWarnings = FALSE)
write_csv(datasets::quakes, "donnees/seismes-fidji.csv")
```
