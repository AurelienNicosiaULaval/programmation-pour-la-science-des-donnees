# Dictionnaire des données du défi 2

Ce document explique ce que représente une ligne dans chaque fichier, le sens des colonnes et les unités utilisées.

## Les fichiers disponibles avant l'épreuve

| Fichier | Ce qu'il contient | Lignes | Colonnes |
|---|---|---:|---:|
| `observations_contre_tarifs.csv` | Des taux de surtaxe pour plusieurs périodes | 2774 | 19 |
| `lots_essai.csv` | Trois lots fictifs | 3 | 4 |
| `scenarios_essai.csv` | Deux situations fictives : avant et après | 2 | 3 |

Les lots et les deux scénarios d'essai servent à comprendre les fichiers. À 13 h 30, vous recevrez `lots_importation.csv` et `scenarios.csv` pour l'épreuve. Ces fichiers auront les mêmes colonnes, avec d'autres lignes et d'autres valeurs.

Les taux proviennent du ministère des Finances du Canada, à partir des données préparées par Données bleues. Les lots d'essai, leurs valeurs et les deux scénarios d'essai sont fictifs. La provenance et les conditions de réutilisation sont précisées dans `SOURCE.md` et `DATA_LICENSE.md`.

## Formats et unités

- Les fichiers CSV sont encodés en UTF-8.
- Les codes et les identifiants sont du texte. Il faut conserver les zéros au début des codes.
- Les dates suivent le format année-mois-jour.
- Les taux sont des pourcentages; les valeurs des lots sont en dollars canadiens.
- `NA` indique une information manquante dans le fichier des taux. Les règles propres aux fichiers de l'épreuve seront données dans l'énoncé.

## Le fichier des taux : `observations_contre_tarifs.csv`

Le fichier rassemble des taux pour plusieurs périodes. La colonne `source_table` est le repère fourni pour associer une ligne de taux à un scénario daté.

Une ligne décrit un code tarifaire pour une période donnée. Un même code peut apparaître à plusieurs périodes. Le nombre de lignes n'est donc pas le nombre de codes distincts.

| Colonne | Signification |
|---|---|
| `source_table` | Repère des taux à utiliser pour un scénario daté |
| `code_tarifaire` | Code tarifaire canadien à huit chiffres, à conserver comme texte |
| `taux_surtaxe_pourcent` | Taux de surtaxe indiqué dans ce tableau, en pourcentage |
| `description_source` | Description de la marchandise dans la source |
| `position_source` | Intitulé de la catégorie de marchandises dans la source |
| `code_affiche_source` | Code tel qu'il apparaît dans le document source |
| `code_sh6` | Les six premiers chiffres du code |
| `periode_table_source` | Texte qui décrit la période couverte par le tableau |
| `debut_periode_table_source` | Début de cette période, si la date est renseignée |
| `fin_periode_table_source_inclusive` | Dernier jour de cette période, si la date est renseignée |
| `date_application_initiale_source` | Date initiale mentionnée par la source, si elle est renseignée |
| `collection_id` | Identifiant de la collecte des données |
| `source_id` | Identifiant du document source |
| `source_row` | Repère de la ligne dans l'extraction du document |
| `pays_percepteur` | Pays qui perçoit la surtaxe : `CAN` dans ce fichier |
| `pays_origine` | Pays d'origine des produits : `USA` dans ce fichier |
| `nomenclature` | Système de classement utilisé dans la source |
| `statut_validation` | Limites de validation et conditions d'application qui restent à vérifier |
| `observed_at_utc` | Date et heure de l'observation des données, en temps universel coordonné (UTC) |

Certaines descriptions contiennent des retours à la ligne. Un éditeur de texte peut donc afficher plus de lignes que le nombre d'observations lues par R.

Les taux fournis ne suffisent pas à établir une facture douanière réelle. L'énoncé donnera les règles de simulation à utiliser.

## Les lots : `lots_essai.csv`, puis `lots_importation.csv`

Un lot est un ensemble de marchandises auquel on associe une valeur. Chaque ligne représente un lot. Par exemple, un lot d'aspirateurs peut contenir plusieurs appareils; sa valeur est celle de l'ensemble du lot.

| Colonne | Signification |
|---|---|
| `lot_id` | Identifiant du lot |
| `code_tarifaire` | Code du produit, fourni pour le lot et conservé comme texte |
| `libelle_pedagogique` | Description simplifiée et fictive du lot |
| `valeur_lot_cad` | Valeur fictive du lot, en dollars canadiens |

Les codes sont déjà fournis. Vous n'avez pas à classer les marchandises vous-même.

## Les scénarios : `scenarios_essai.csv`, puis `scenarios.csv`

Un scénario est une situation à une date donnée. Le fichier d'essai a deux lignes : `avant_exemple` au 20 août 2025 et `apres_exemple` au 10 septembre 2025. On applique ces deux situations aux mêmes lots, avec les mêmes valeurs.

| Colonne | Signification |
|---|---|
| `scenario` | Nom de la situation : `avant_exemple` ou `apres_exemple` dans le fichier d'essai |
| `date_reference` | Date associée au scénario |
| `source_table` | Repère fourni pour retrouver les taux associés à la date du scénario |

Les deux dates d'essai illustrent la comparaison avant/après. Les dates et les repères de l'épreuve seront communiqués à 13 h 30.
