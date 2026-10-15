# Comprendre les données fournies

Ce document décrit les colonnes et les unités. Avant la séance, les fichiers de lots et de scénarios sont des exemples de prise en main. Les fichiers à analyser seront fournis le 21 octobre à 13 h 30, avec les mêmes colonnes, sous les noms `lots_importation.csv` et `scenarios.csv`. Les questions et les règles de calcul seront alors précisées dans l'énoncé.

Les trois CSV sont en UTF-8. `NA` indique une information absente. Les codes et les identifiants se lisent comme du texte, notamment pour conserver les zéros au début. Les taux sont exprimés en pourcentage et les valeurs des lots en dollars canadiens.

## Les fichiers

| Fichier | Contenu | Lignes | Colonnes |
|---|---|---:|---:|
| `observations_contre_tarifs.csv` | Taux documentaires et informations sur les tableaux historiques | 2774 | 19 |
| `lots_essai.csv` | Trois lots fictifs de prise en main | 3 | 4 |
| `scenarios_essai.csv` | Un scénario fictif de prise en main | 1 | 3 |

Les lots d'essai, leurs valeurs et le scénario d'essai sont fictifs et distincts de ceux de l'épreuve. Les taux proviennent de données documentaires préparées par Données bleues à partir du ministère des Finances du Canada. Voir `SOURCE.md` et `DATA_LICENSE.md`.

## `observations_contre_tarifs.csv`

Une ligne décrit un code tarifaire dans un tableau historique. Le fichier comporte trois tableaux, repérés par `source_table`. Un code peut figurer dans plusieurs tableaux; les 2774 lignes ne représentent donc pas 2774 codes distincts. Les dates de début et de fin décrivent la période du tableau fourni.

| Colonne | Signification |
|---|---|
| `collection_id` | Identifiant de la collecte documentaire |
| `source_id` | Identifiant du document source |
| `source_table` | Identifiant du tableau historique : `1`, `2` ou `3` |
| `source_row` | Repère de ligne fourni lors de l'extraction |
| `pays_percepteur` | Code du pays percepteur : `CAN` dans ce fichier |
| `pays_origine` | Code du pays d'origine : `USA` dans ce fichier |
| `nomenclature` | Nomenclature utilisée dans la source |
| `code_tarifaire` | Code tarifaire canadien à huit chiffres, conservé comme texte |
| `code_affiche_source` | Écriture du code telle qu'elle est affichée dans la source |
| `code_sh6` | Préfixe du code à six chiffres |
| `position_source` | Intitulé de position fourni dans la source |
| `description_source` | Description documentaire de la marchandise |
| `taux_surtaxe_pourcent` | Taux de surtaxe renseigné, en pourcentage, avant les conditions particulières |
| `date_application_initiale_source` | Date initiale renseignée lorsque la source la fournit |
| `periode_table_source` | Libellé de la période du tableau |
| `debut_periode_table_source` | Début de la période du tableau, au format année-mois-jour |
| `fin_periode_table_source_inclusive` | Dernier jour de la période du tableau lorsqu'il est renseigné |
| `statut_validation` | Mention des limites de validation et des conditions non résolues |
| `observed_at_utc` | Horodatage UTC fourni dans les données documentaires |

Les descriptions peuvent contenir des retours à la ligne. Le nombre de lignes physiques d'un fichier texte peut donc dépasser le nombre d'observations lues dans le CSV. Les règles de calcul seront données dans l'énoncé. Les informations fournies ne permettent pas, à elles seules, d'établir une facture douanière réelle.

## `lots_essai.csv` et futur `lots_importation.csv`

Une ligne représente un lot fictif, identifié par `lot_id`. Un lot est un ensemble de marchandises auquel on associe une valeur; il ne représente pas nécessairement un seul objet.

| Colonne | Signification |
|---|---|
| `lot_id` | Identifiant du lot |
| `code_tarifaire` | Code tarifaire fourni pour le lot, à conserver comme texte |
| `libelle_pedagogique` | Libellé simplifié et fictif du lot |
| `valeur_lot_cad` | Valeur fictive du lot, en dollars canadiens; les conventions de lecture des fichiers de l'épreuve seront précisées dans l'énoncé |

Les codes sont fournis. Aucune expertise de classement douanier n'est attendue.

## `scenarios_essai.csv` et futur `scenarios.csv`

Une ligne décrit un scénario.

| Colonne | Signification |
|---|---|
| `scenario` | Nom qui identifie le scénario; `exemple` dans le fichier de prise en main |
| `date_reference` | Date associée, au format année-mois-jour |
| `source_table` | Identifiant du tableau associé dans les données documentaires |

Le scénario d'essai porte la date fictive du 20 août 2025 et renvoie au tableau `3` pour illustrer le format. Il ne donne ni les dates ni les tableaux choisis pour l'épreuve. Aucun calcul de surtaxe, graphique ou rapport d'analyse n'est demandé avant la séance.
