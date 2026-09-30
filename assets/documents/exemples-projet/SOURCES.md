# Sources des aperçus externes

Captures réalisées le 30 septembre 2026 dans un navigateur, sans modification de l’interface des applications. Ces aperçus illustrent des formats possibles; les applications restent celles de leurs auteurs.

## Application Shiny

- Aperçu : `apercu-shiny-movie-explorer.png`.
- Application : [Movie explorer](https://gallery.shinyapps.io/051-movie-explorer/).
- Présentation : [galerie Shiny de Posit](https://shiny.posit.co/r/gallery/interactive-visualizations/movie-explorer/).
- Source : [rstudio/shiny-examples, 051-movie-explorer](https://github.com/rstudio/shiny-examples/tree/master/051-movie-explorer).
- Interaction vérifiée : filtre par réalisateur, puis retour à la sélection initiale.

## Tutoriel learnr

- Aperçu : `apercu-learnr-filter.png`.
- Tutoriel : [Filter observations](https://learnr-examples.shinyapps.io/ex-data-filter/#section-exercises).
- Présentation : [exemples officiels learnr](https://rstudio.github.io/learnr/#examples).
- Source : [ex-data-filter.Rmd](https://github.com/rstudio/learnr/tree/main/inst/tutorials/ex-data-filter/ex-data-filter.Rmd).
- Interaction vérifiée : exécution du code `dplyr::filter(nycflights13::flights, arr_delay >= 120)` dans le premier exercice et affichage du tableau obtenu.
