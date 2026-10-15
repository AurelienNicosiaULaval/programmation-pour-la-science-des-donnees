# Dictionnaire des données du défi 2

Ce document explique ce que représente une ligne dans chaque fichier, le sens des colonnes et les unités utilisées.

## Les fichiers disponibles avant l'épreuve

| Fichier | Ce qu'il contient | Lignes | Colonnes |
|---|---|---:|---:|
| `observations_contre_tarifs.csv` | Des taux de surtaxe pour plusieurs périodes | 2774 | 19 |
| `lots_essai.csv` | Trois lots fictifs | 3 | 4 |
| `scenarios_essai.csv` | Une situation fictive associée à une date | 1 | 3 |

Les lots et le scénario d'essai servent à comprendre les fichiers. À 13 h 30, vous recevrez `lots_importation.csv` et `scenarios.csv` pour l'épreuve. Ces fichiers auront les mêmes colonnes, avec d'autres lignes et d'autres valeurs.

Les taux proviennent du ministère des Finances du Canada, à partir des données préparées par Données bleues. Les lots d'essai, leurs valeurs et le scénario d'essai sont fictifs. La provenance et les conditions de réutilisation sont précisées dans `SOURCE.md` et `DATA_LICENSE.md`.

## Formats et unités

- Les fichiers CSV sont encodés en UTF-8.
- Les codes et les identifiants sont du texte. Il faut conserver les zéros au début des codes.
- Les dates suivent le format année-mois-jour.
- Les taux sont des pourcentages; les valeurs des lots sont en dollars canadiens.
- `NA` indique une information manquante dans le fichier des taux. Les règles propres aux fichiers de l'épreuve seront données dans l'énoncé.

## Le fichier des taux : `observations_contre_tarifs.csv`

Le fichier réunit trois tableaux correspondant à des périodes différentes. La colonne `source_table` indique de quel tableau vient chaque ligne.

Une ligne décrit un code tarifaire dans un tableau donné. Un même code peut apparaître dans plusieurs tableaux. Le nombre de lignes n'est donc pas le nombre de codes distincts.

| Colonne | Signification |
|---|---|
| `source_table` | Identifiant du tableau : `1`, `2` ou `3` |
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

Un scénario décrit une situation à une date donnée et indique le tableau des taux qui lui est associé. Chaque ligne représente un scénario.

| Colonne | Signification |
|---|---|
| `scenario` | Nom du scénario : `exemple` dans le fichier d'essai |
| `date_reference` | Date associée au scénario |
| `source_table` | Identifiant du tableau des taux associé à ce scénario |

Le fichier d'essai utilise la date fictive du 20 août 2025 et le tableau `3`. Les dates et les tableaux de l'épreuve seront communiqués à 13 h 30.
