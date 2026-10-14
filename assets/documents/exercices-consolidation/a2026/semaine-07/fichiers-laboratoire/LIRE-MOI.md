# Laboratoire du module 7 : bonnes pratiques et Quarto

Extraire tous les fichiers ensemble. Conserver `rapport.qmd`, `script-a-reviser.R` et le sous-dossier `donnees/` dans le même dossier de travail.

Pour le script R, le dossier de travail doit être celui qui contient `script-a-reviser.R`. Le vérifier avec `getwd()` et `file.exists("donnees/seismes-fidji.csv")`. Un chemin qui ne fonctionne pas doit être corrigé en vérifiant l'organisation des fichiers, sans ajouter un chemin absolu propre à votre ordinateur.

Pour le rapport, ouvrir `rapport.qmd` dans RStudio et utiliser Render. Il est possible de produire le HTML avant de compléter les exercices. Depuis un terminal placé dans ce dossier :

```text
quarto render rapport.qmd
```

Il faut R, Quarto et les bibliothèques `readr`, `dplyr`, `ggplot2` et `knitr`. Si nécessaire, installer les bibliothèques une fois dans la console :

```r
install.packages(c("readr", "dplyr", "ggplot2", "knitr"))
```

Le gabarit est un point de départ. Compléter les passages « À compléter » avec votre travail personnel. Les quatre exercices et les pistes de correction sont dans la page du module 7; ce paquet ne contient pas le corrigé.

Conserver vos productions dans `semaines/semaine-07/` du portfolio attribué pour le cours. Le README de cette semaine doit renvoyer vers les exercices et expliquer ce qui a été produit et vérifié. Ne pas y copier les énoncés ou les corrigés.

Le jeu de données est documenté dans `donnees/SOURCES.md`. Le matériel pédagogique est sous licence CC BY-NC-SA 4.0; la provenance des données est distincte.
