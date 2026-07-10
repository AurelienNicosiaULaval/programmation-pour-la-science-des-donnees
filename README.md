# STT-4230 / STT-6230 - Programmation pour la science des données

Site Quarto du cours STT-4230 / STT-6230 à l’Université Laval.

Ce dépôt contient uniquement le matériel destiné aux étudiantes et étudiants: modules, laboratoires, préparation publique aux défis, évaluations, portfolio, politique d’utilisation de l’IA, ressources et gabarits.

Les décisions de conception pédagogique, les documents de pilotage, les corrigés, les consignes évaluées exactes et les données sensibles sont conservés dans le dépôt enseignant privé.

## Cloner le dépôt

Utiliser de préférence une URL SSH:

```bash
git clone git@github.com:AurelienNicosiaULaval/programmation-pour-la-science-des-donnees.git
cd programmation-pour-la-science-des-donnees
```

## Notes de développement

Les notes de pilotage, documents sources, corrigés et consignes enseignantes sont conservés hors site public. Localement, ces fichiers peuvent être placés dans `.enseignant-prive/`, qui est ignoré par Git et n’est pas publié par Quarto.

## Prévisualiser le site

```bash
quarto preview
```

## Rendre le site localement

```bash
quarto render
```

Le site rendu est créé dans `_site/`.

Le rendu produit aussi des pages `.llms.md` et un index `llms.txt` destinés au compagnon GPT du cours. Le workflow GitHub Pages vérifie cet index après le rendu.

## Dépendances R

Le cours recommande `renv`, mais aucun package n’est installé automatiquement.

Pour initialiser l’environnement:

```r
renv::init()
```

Pour restaurer un environnement existant:

```r
renv::restore()
```

Pour mettre à jour `renv.lock` après installation ou mise à jour de packages:

```r
renv::snapshot()
```

## Ajouter un module

1. Créer un dossier dans `modules/`.
2. Ajouter au minimum `index.qmd`, `avant.qmd`, `pendant.qmd`, `laboratoire.qmd`, `defi.qmd`, `apres.qmd`, `lectures.qmd` et `ressources.qmd`.
3. Vérifier que le module précise la préparation, la production attendue, le statut IA, la trace portfolio et l’attente STT-6230 lorsque pertinente.
4. Ajouter l’entrée correspondante dans `_quarto.yml`.
5. Placer les notes enseignantes, corrigés et fichiers sensibles dans le dépôt enseignant privé ou dans `.enseignant-prive/`.
6. Exécuter `quarto render`.

## Ajouter un défi

1. Placer uniquement la préparation ou la consigne publique dans `defis/` ou dans le dossier du module.
2. Indiquer le statut d’IA.
3. Ajouter les critères publics d’évaluation.
4. Conserver la consigne évaluée exacte, les données, les corrigés et les notes de correction hors site public.
5. Vérifier le rendu.

## Ajouter un laboratoire

1. Placer la fiche dans le dossier du module.
2. Ajouter les fichiers de départ seulement si leurs droits de diffusion sont confirmés.
3. Garder les solutions et notes enseignantes hors site public.
4. Tester l’activité dans une session propre.

## Publier avec GitHub Pages Actions

Le workflow `.github/workflows/publish.yml` rend le site et publie `_site/` avec GitHub Pages.

Dans GitHub:

1. Ouvrir Settings.
2. Aller dans Pages.
3. Choisir GitHub Actions comme source de publication.
4. Vérifier que les workflows ont les permissions nécessaires.
5. Pousser vers `main` ou lancer le workflow manuellement.

## Option alternative avec `gh-pages`

Quarto documente aussi la publication avec:

```bash
quarto publish gh-pages
```

Cette option peut créer une configuration `_publish.yml` et publier sur une branche `gh-pages`. Elle est utile pour une publication simple, mais le workflow Actions de ce dépôt est préférable pour garder le rendu reproductible.

## Organisation des données

Utiliser:

```text
data/
  raw/
  processed/
```

Ne jamais publier:

- données nominatives;
- données sensibles;
- clés API;
- fichiers `.env`;
- données dont les droits de diffusion ne sont pas confirmés.

## Licence

Sauf indication contraire, le matériel pédagogique est distribué sous licence Creative Commons Attribution - Pas d’utilisation commerciale - Partage dans les mêmes conditions 4.0 International.
