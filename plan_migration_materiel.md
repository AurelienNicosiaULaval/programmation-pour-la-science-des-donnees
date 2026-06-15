# Plan de migration du matériel pédagogique (H2023 ➔ Automne 2026)

Ce document détaille la stratégie de migration, de modernisation et de restructuration de l'ancien matériel du cours (situé dans `ContenuHebdo2023`) vers le nouveau site Quarto du cours `NouveauSTT4230`.

---

## 🎯 1. Principes généraux de la conversion

Pour chaque fichier migré, quatre actions de modernisation doivent être appliquées systématiquement :

1.  **Format Quarto (`.Rmd` ➔ `.qmd`)** :
    *   Renommer l'extension en `.qmd`.
    *   Adapter l'en-tête YAML (utiliser les standards Quarto comme `embed-resources: true` et supprimer les options RMarkdown obsolètes).
    *   Convertir les options de blocs R (ex: remplacer ````{r, eval=FALSE}```` par la syntaxe Quarto ````#| eval: false```` à l'intérieur du bloc).
2.  **Modernisation de la syntaxe R** :
    *   Remplacer l'opérateur d'assignation globale `<<-` par des structures propres.
    *   Convertir les fonctions de manipulation de données de base R (`aggregate()`, `merge()`, `subset()`, `ifelse()`) par leurs équivalents **Tidyverse** modernes (`group_by()`, `summarise()`, `left_join()`, `filter()`, `if_else()`).
3.  **Modernisation de `ggplot2`** :
    *   Utiliser `after_stat()` au lieu de la syntaxe obsolète `..density..` ou `..count..`.
    *   Privilégier `patchwork` pour l'assemblage de graphiques au lieu de diviser la fenêtre graphique avec `par(mfrow = ...)`.
4.  **Nettoyage de l'environnement** :
    *   Remplacer tous les liens absolus locaux (ex: `/Users/nom/Documents/...`) par des chemins relatifs.
    *   Mettre à jour les mentions d'IDE pour inclure **Positron** en plus de RStudio.
    *   Mettre à jour les URL pointant vers l'ancien site `stt4230.rbind.io` pour pointer vers les pages internes du nouveau site.

---

## 🗺️ 2. Correspondance générale des semaines

| Semaine H2023 | Sujet original | Semaine Visée (2026) | Fichier Cible (2026) | Statut |
| :--- | :--- | :--- | :--- | :--- |
| **Semaine 1** | Présentation R & Git | **Semaine 1 & 2** | `modules/01-structuration-projets/` & `02-structure-git-github/` | Déjà structuré |
| **Semaine 2** | Structures de données, lecture/écriture | **Semaine 2** | `modules/02-structure-git-github/ressources.qmd` | **Fait (Enrichi)** |
| **Semaine 3** | Calculs de base en R | **Semaine 2 & 10** | `modules/02-structure-git-github/` & `10-programmation-fonctionnelle/` | Déjà structuré |
| **Semaine 4** | Prétraitement et nettoyage de données | **Semaine 4** | `modules/04-donnees-nettoyage-validation/laboratoire.qmd` | **Fait (Enrichi)** |
| **Semaine 5** | Graphiques (Base R & `ggplot2`) | **Semaine 6** | `modules/06-visualisation/` | **Fait (Migré)** |
| **Semaine 7** | R Markdown & Bonnes pratiques | **Semaine 7** | `modules/07-quarto-rapports/` | **Fait (Migré)** |
| **Semaine 8** | Structures de contrôle & Fonctions | **Semaine 10** | `modules/10-programmation-fonctionnelle/index.qmd` | **Fait (Migré)** |
| **Semaine 11** | OOP, exceptions & tests | **Semaine 10 & 11** | `modules/10-...` (tests) & `11-programmation-orientee-objet/` | **Fait (Migré)** |
| **Semaine 12** | Développement de packages R | **Semaine 15** | `modules/15-collaboration-documentation-package/` | **Fait (Migré)** |
| **Semaine 13** | Optimisation temporelle | **Semaine 12** | `modules/12-profilage-optimisation-performance/` & `12-programmation-parallele/` | **Fait (Migré)** |
| **Semaine 14** | Récapitulatif | **Semaine 15** | `modules/15-collaboration-documentation-package/` / Bilan | **Fait (Migré)** |

---

## 📝 3. Plan d'action détaillé par bloc de migration

### 🟩 Bloc A : Semaines 1 à 4 (Déjà structurées, à affiner)
Les modules 1 à 4 sont déjà écrits dans le nouveau site, mais ils peuvent être enrichis par l'ancien matériel :
*   **[Fait] Semaine 2 (Ancienne) ➔ Nouveau Module 2** :
    *   *Fichier source* : `Semaine2/ContenuClasse/exemples_structures_donnees_lecture_ecriture_r.R`
    *   *Action* : Extraire les exemples d'écriture/lecture de fichiers (`.rds`, `.xlsx`, `.txt`) pour enrichir la page `ressources.qmd` du module 2.
*   **[Fait] Semaine 4 (Anniene) ➔ Nouveau Module 4** :
    *   *Fichier source* : `Semaine4/ContenuClasse/exemples_pretraitement_donnees_r.Rmd`
    *   *Action* : Recycler les exemples de traitement des valeurs manquantes (`is.na()`, `anyNA()`) et de fusion de données pour alimenter `laboratoire.qmd` ou `ressources.qmd` du module 4.

---

### 🟨 Bloc B : Semaines 6 & 7 (Visualisation & Rapports - [Fait])
*   **[Fait] Semaine 5 (Ancienne) ➔ Nouveau Module 6 (Visualisation)** :
    *   *Fichier source* : `Semaine5/ContenuClasse/classe_graphiques_r.Rmd` et `tutoriel_ggplot2.Rmd`
    *   *Action* : Création des pages dans `modules/06-visualisation/` (index, avant, pendant, laboratoire, defi, lectures, ressources) complétée avec modernisation `ggplot2` (after_stat) et réduction R base graphics.
*   **[Fait] Semaine 7 (Ancienne) ➔ Nouveau Module 7 (Quarto et rapports)** :
    *   *Fichier source* : `Semaine7/ContenuClasse/classe_bonnes_pratiques_rmarkdown.Rmd`
    *   *Action* : Création des pages dans `modules/07-quarto-rapports/` complétée avec transposition complète vers Quarto et options d'en-tête YAML.

---

### 🟦 Bloc C : Semaines 10 à 12 (Programmation Avancée)
*   **[Fait] Semaine 8 (Ancienne) ➔ Nouveau Module 10 (Programmation fonctionnelle)** :
    *   *Fichier source* : `Semaine8/ContenuClasse/classe_struct_controle_fonctions_r_2023.Rmd`
    *   *Action* :
        1.  Intégrer les exemples de portée de variables (scoping) et d'environnements d'exécution dans les lectures du module 10.
        2.  Recycler les exemples sur l'utilisation du débogueur `browser()`.
*   **[Fait] Semaine 11 (Ancienne) ➔ Nouveau Module 11 (POO) & Module 10 (Tests)** :
    *   *Fichier source* : `Semaine11/ContenuClasse/classe_rmarkdown_oop_tests_exceptions_r.Rmd`
    *   *Action* :
        1.  Séparer le contenu : les concepts de test d'exception (`tryCatch()`) et de validation vont dans le module 10 (avec `testthat`).
        2.  Les concepts d'orientation objet (système S3 et introduction R6) vont dans le module 5.
*   **[Fait] Semaine 13 (Ancienne) ➔ Nouveaux Modules 12 (Profilage & Performance) & 12 (Prog. Parallèle)** :
    *   *Fichier source* : `Semaine13/ContenuClasse/classe_optim_temps_metaprog_r.Rmd`
    *   *Action* :
        1.  Recycler les démonstrations de mesure de performance avec `microbenchmark` / `bench` et de profilage avec `profvis` dans le module 12.
        2.  Ajouter les sections modernes sur le calcul parallèle avec les packages `future` et `furrr` dans le module 12 (Prog. Parallèle).

---

### 🟪 Bloc D : Semaine 15 (Livrables et Packaging)
*   **[Fait] Semaine 12 (Ancienne) ➔ Nouveau Module 15 (Package & Collaboration)** :
    *   *Fichier source* : `Semaine12/ContenuClasse/devel_pkg_r_demo.Rmd` & `Démonstration package/`
    *   *Action* :
        1.  Migrer le tutoriel de création de package R vers la semaine 15 du nouveau cours (réalisé).
        2.  Utiliser les commandes à jour de `devtools` et `usethis` pour la création automatique de la structure, des tests et de la documentation (`roxygen2`).

---

## 🏁 4. Checklist de validation d'un module migré

Avant de marquer un module comme "Fait" dans la roadmap, valider que :
- [ ] Le fichier `.qmd` compile sans erreur locale avec `quarto render`.
- [ ] Tous les liens pointent vers des fichiers `.qmd` valides (vérifié par `scripts/valider_liens.R`).
- [ ] Aucun chemin absolu (ex: `/Users/`) n'est présent dans le code R ou le texte.
- [ ] Le code de manipulation de données utilise la syntaxe moderne de `dplyr`/`tidyr` au lieu de base R.
- [ ] Les graphiques utilisent `ggplot2` avec `after_stat()`.
- [ ] Les options de blocs R utilisent la syntaxe `#| option` propre à Quarto.
