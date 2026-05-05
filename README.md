# STT-4230 / STT-6230 - Programmation pour la science des données

Site Quarto du cours STT-4230 / STT-6230 à l’Université Laval.

Ce dépôt contient la structure de base du site de cours: modules, laboratoires, défis, évaluations, portfolio, politique d’utilisation de l’IA, ressources et gabarits.

## Cloner le dépôt

Utiliser de préférence une URL SSH, en remplaçant `OWNER/REPO` par le dépôt réel:

```bash
git clone git@github.com:OWNER/REPO.git
cd REPO
```

## Prévisualiser le site

```bash
quarto preview
```

## Rendre le site localement

```bash
quarto render
```

Le site rendu est créé dans `_site/`.

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

1. Copier le gabarit `gabarits/fiche-module.qmd`.
2. Créer un dossier dans `modules/`.
3. Ajouter les pages `index.qmd`, `avant.qmd`, `pendant.qmd`, `apres.qmd`, `laboratoire.qmd`, `defi.qmd`, `lectures.qmd`, `ressources.qmd`.
4. Ajouter l’entrée correspondante dans `_quarto.yml`.
5. Exécuter `quarto render`.

## Ajouter un défi

1. Copier `gabarits/fiche-defi.qmd`.
2. Placer la consigne dans `defis/` ou dans le dossier du module.
3. Indiquer le niveau d’IA permis.
4. Ajouter les critères d’évaluation.
5. Vérifier le rendu.

## Ajouter un laboratoire

1. Copier `gabarits/fiche-laboratoire.qmd`.
2. Placer la fiche dans `labs/` ou dans le dossier du module.
3. Ajouter les fichiers de départ si nécessaire.
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
