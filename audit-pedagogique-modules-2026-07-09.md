# Audit pédagogique des modules STT-4230 / STT-6230

Date de l'audit: 9 juillet 2026
Portée: site public `NouveauSTT4230`, contenu présent dans le répertoire de travail au moment de l'audit.

## Verdict

Le cours possède une architecture pédagogique forte et inhabituelle pour un cours de programmation: chaque unité est reliée à une trace concrète, le portfolio rend la progression visible, le projet filé donne un sens aux apprentissages, et l'usage de l'IA est explicite plutôt qu'implicite. Les pages centrales `cadrage.qmd`, `calendrier.qmd`, `evaluations.qmd`, `portfolio.qmd` et `projets.qmd` forment un cadre cohérent.

La version actuelle est proche d'une version distribuable, mais elle n'est pas encore totalement prête à être remise sans révision. Les corrections prioritaires concernent une erreur de syntaxe Quarto dans le module 7, l'opérationnalisation des mini-tests des semaines 6 et 7, et une surcharge structurelle en semaines 12, 14 et 15. Ces problèmes ne remettent pas en cause le projet du cours. Ils peuvent être résolus par une consolidation ciblée, sans créer de nouveau contenu majeur.

## Méthode et limites

- Les 14 unités présentes dans `modules/` ont été examinées, ainsi que leurs pages `index`, `avant`, `pendant`, `laboratoire`, `apres`, `defi`, `lectures` et `ressources`.
- Les documents qui structurent les attentes étudiantes, les évaluations, les données, l'IA, le calendrier et le démarrage ont été lus.
- Le validateur `Rscript scripts/valider_liens.R` a analysé 145 fichiers et 268 liens relatifs. Il ne signale aucune cible relative manquante.
- Les 14 unités possèdent les huit pages attendues. La navigation source est donc complète.
- Un rendu Quarto propre depuis un clone distant a démarré et a atteint 23 pages sur 143. L'environnement d'audit a interrompu la commande avant sa fin, sans erreur Quarto explicite. Les avertissements observés concernaient des pages encore non rendues dans l'ordre du build. Un rendu intégral final reste donc à effectuer avant publication.
- Les exemples R n'ont pas tous été exécutés un à un dans les environnements étudiants ciblés. Cet audit évalue leur cohérence pédagogique et leur lisibilité, pas une certification d'exécution multiplateforme.

## Ce qui est déjà très solide

| Dimension | Constat | Effet pédagogique |
|---|---|---|
| Progression | Le cours part du dépôt et de la reproductibilité, puis va vers les données, la communication, la qualité, la performance et la livraison. | Les apprentissages s'accumulent au lieu d'être des chapitres indépendants. |
| Traces | Chaque module demande un fichier, une note, une vérification, un commit ou un livrable. | Le portfolio peut montrer une progression réelle. |
| Évaluation | Les défis 1, 2 et 3 ont des fonctions distinctes et une règle IA progressive. | Les compétences individuelles et le jugement professionnel sont mieux distingués. |
| Continuité | Les données météo du module 4 sont reprises dans le rapport Quarto du module 7. | La réutilisation réduit la fragmentation des exercices. |
| Professionnalisation | README, `renv`, tests, issues, pull requests, contribution, limites et reproduction sont présents. | Les étudiantes et étudiants apprennent à livrer, pas seulement à faire fonctionner du code. |
| Différenciation | Les attentes STT-6230 ajoutent une justification ou une vérification, au lieu d'imposer une seconde activité séparée. | La différenciation est proportionnée et défendable. |

## Corrections prioritaires avant remise aux étudiants

### P0 - Corriger les quatre blocs R exécutables du module 7

Les exemples à copier dans `modules/07-quarto-rapports/avant.qmd:60` et `modules/07-quarto-rapports/laboratoire.qmd:61,83,116` utilisent la clôture de bloc ` ```{{r}} `. La syntaxe exécutable Quarto est ` ```{r} `. Une étudiante ou un étudiant qui copie le texte actuel ne déclenchera pas correctement l'exécution R attendue.

Cette correction est bloquante car le module 7 doit précisément apprendre à écrire et rendre un document Quarto. La documentation officielle de Quarto montre des blocs R sous la forme ` ```{r} ` avec les options `#|` dans le bloc: <https://quarto.org/docs/computations/r.html>.

### P1 - Rendre les mini-tests des semaines 6 et 7 évaluables et prévisibles

Le calendrier et la page Évaluations annoncent un mini-test aux semaines 6 et 7. Les pages `avant.qmd` des deux modules proposent bien des questions de préparation, mais elles ne précisent ni la forme de remise, ni le nombre de réponses, ni la trace à conserver, ni le lien avec les 10 % de mini-tests. Elles sont donc de bonnes questions de réflexion, mais pas encore une consigne de mini-test opérationnelle.

Il faut ajouter à chacune de ces deux pages un encadré uniforme: durée cible, trois questions, format de remise, moment de fermeture, usage IA permis, trace demandée et critère minimal de complétion. Le même gabarit devrait ensuite être réutilisé aux semaines 9 à 12.

### P1 - Unifier les semaines 12 et 14 du point de vue des étudiantes et étudiants

La semaine 12 est décrite au calendrier comme une seule séance d'optimisation et de parallélisation, mais le site contient deux modules complets avec chacun une préparation, un mini-test, un laboratoire, un défi et un après-cours. La semaine 14 est explicitement composée de trois blocs, mais chacun est également présenté dans la navigation comme un module complet de huit pages.

La conception des activités est de qualité. Le risque est la perception d'avoir deux ou trois semaines de travail à absorber en une séance. Pour chaque semaine, créer une page d'entrée unique qui indique:

- ce qui est obligatoire pendant les trois heures;
- ce qui est un choix selon le projet;
- une seule préparation totale, avec durée réaliste;
- un seul mini-test lorsque le calendrier en prévoit un;
- un seul livrable ou une checklist unique;
- les extensions STT-6230 et les approfondissements facultatifs.

Les pages actuelles peuvent devenir des sous-blocs ou des annexes techniques. Il ne faut pas les supprimer.

### P1 - Aligner réellement le module 15 sur sa finalité

L'index du module 15 affirme justement que le package R est une extension optionnelle lorsque le projet contient des fonctions réutilisables. Or les compétences visées, la préparation, le laboratoire et l'après-cours sont presque entièrement consacrés à construire, documenter, tester, vérifier et installer un package local `manhattan`.

Cette discordance est problématique à la dernière semaine: la composante évaluée est le site personnel, la défense du projet et la revue de code, pas un package R. De plus, la vérification des compilateurs augmente le risque d'un blocage technique tardif.

Le noyau obligatoire du module 15 doit être le site publié, le dépôt final, la revue de code, la contribution individuelle, le bilan et la défense. Le package devrait devenir une annexe avancée, une activité STT-6230, ou une voie de remplacement explicitement choisie par les projets auxquels il convient.

## Axes transversaux à consolider

### Numérotation et lisibilité de la progression

Les répertoires `12-profilage-optimisation-performance` et `12-programmation-parallele`, ainsi que les trois répertoires commençant par `14-`, sont pédagogiquement compréhensibles après lecture du calendrier. Ils demeurent ambigus dans le menu Modules, où ils ressemblent à cinq semaines distinctes. Afficher les libellés `12A`, `12B`, `14A`, `14B`, `14C`, ou mieux une seule page-semaine avec sous-sections, rendrait le rythme visible sans modifier le fond.

### Charge de préparation

Dix pages `avant.qmd` donnent une durée totale de préparation. Le module 4 et les trois blocs de semaine 14 n'en donnent pas. Le module 4 possède une préparation très riche, et la semaine 14 combine une remise finale avec trois blocs techniques. Une durée totale réaliste est nécessaire pour permettre aux étudiants de choisir entre le noyau minimal et les extensions.

### Lectures et sources

Les lectures sont généralement bien choisies: documentation officielle de Quarto, GitHub, Posit, `renv`, tidyverse, tidymodels, Futureverse et ouvrages de Wickham et Bryan. Les ressources sont reliées à un geste technique et non à une lecture abstraite.

Deux améliorations sont nécessaires:

- `modules/14-cycle-vie-modeles/lectures.qmd` cite les model cards de Mitchell et al. (2019), mais ne donne ni référence bibliographique complète ni lien. Ajouter la référence primaire et préciser le passage à lire.
- `modules/04-donnees-nettoyage-validation/ressources.qmd` fait 333 lignes et couvre importation, SQL, API, formats, imputation et jointures. Le contenu est utile, mais doit être balisé `essentiel avant le labo`, `pendant le labo`, `pour aller plus loin` afin de ne pas transformer la page de soutien en lecture obligatoire implicite.

### Évaluation et rétroaction

Les grilles détaillées sont accessibles depuis la page Évaluations, mais aucun module ne contient de lien direct vers une grille. Ajouter, dans chaque page `defi.qmd`, un lien vers la grille pertinente ou une phrase indiquant explicitement que le défi est formatif et non noté. Cela évitera la confusion entre les défis de module et les trois défis techniques notés.

Les défis techniques sont particulièrement bien conçus: défi 1 sans IA pour vérifier les bases, défi 2 avec IA déclarée, défi 3 avec IA intégrée et vérifiée. Il reste à publier, avant chaque défi, une micro-consigne de remise stable qui sépare ce qui est fourni le jour même de ce qui est déjà connu.

### Données, éthique et ancrage local

La page Données donne un cadre clair sur la provenance, les droits et la confidentialité, et priorise Québec et le Canada. Le module 4 utilise une donnée fictive avec des stations nommées québécoises, ce qui est un bon compromis pour pratiquer sans fragilité externe. Le défi 1 annonce un jeu québécois réel ou dérivé d'une source ouverte, ce qui est cohérent.

Le module 6 travaille surtout avec `quakes`, un jeu intégré portant sur les Fidji. Il convient pour isoler la grammaire graphique, mais une variante québécoise ou canadienne prête à l'emploi améliorerait la continuité avec le projet et les priorités annoncées, sans supprimer l'exemple actuel.

### IA et intégrité

La politique IA est l'une des parties les plus abouties du site. Les statuts sont définis, repris dans les évaluations et reliés à une trace `ai-log.md`. La règle de défendabilité est simple et pédagogique.

La cohérence à améliorer est locale: chaque mini-test et chaque défi de module devrait afficher le même résumé standard de la règle IA et le nom exact du fichier de déclaration attendu. La règle ne doit pas obliger les étudiants à naviguer entre trois pages pour savoir quoi documenter.

## Audit module par module

### 1. Structuration de projets de science des données

Forces: excellent démarrage concret. Les objectifs, le diagnostic technique, le README, le journal et les deux commits forment une première trace intelligible. La page Ressources donne aussi un modèle de demande d'aide utile.

À ajuster: l'installation, SSH, GitHub, le dépôt, la structure et la première documentation sont nombreux pour une première séance. Prévoir une voie de rattrapage explicite pour les personnes qui ne peuvent pas configurer SSH ou GitHub à temps. Distinguer plus explicitement ce qui doit être terminé avant de quitter le labo et ce qui peut être régularisé après.

Production étudiante: dépôt amorcé, README, journal semaine 1, diagnostic, deux commits, synchronisation si possible.

### 2. Structure de projet, Git, GitHub et chemins relatifs

Forces: la progression depuis la semaine 1 est nette. La recherche de chemins absolus, les conventions et le script de vérification donnent un objectif professionnel concret.

À ajuster: le contenu recoupe naturellement le module 1. Afficher une phrase de transfert claire: semaine 1, démarrer un dépôt; semaine 2, rendre le dépôt relançable et lisible pour une autre personne. Fournir aussi une alternative aux commandes `grep` pour les environnements où elles ne sont pas disponibles.

Production étudiante: conventions, structure corrigée, vérification de chemins, journal semaine 2 et commits séparés.

### 3. Dépendances et reproductibilité

Forces: très bon premier jalon de portfolio. La distinction entre fichiers versionnés, ignorés et dépendances est bien reliée à `renv`, à une session propre et au README.

À ajuster: préciser une seule règle sur `renv.lock`. Le portfolio le présente comme attendu lorsque pertinent, tandis que le laboratoire demande de décider si `renv` est pertinent maintenant. Une décision guidée, avec trois cas typiques, évitera que les étudiants interprètent `renv` comme une obligation prématurée ou facultative sans justification.

Production étudiante: README et conventions stabilisés, `.gitignore`, note de dépendances, script ou commande de vérification, jalon portfolio 1.

### 4. Données, nettoyage et validation

Forces: module particulièrement réussi. Le pipeline `raw -> processed`, le contrôle des types, la documentation des décisions, les assertions et la relance depuis une session propre sont exactement les gestes à installer avant le défi 1. La continuité avec le rapport de semaine 7 est réelle.

À ajuster: séparer nettement le noyau obligatoire de l'aperçu SQL, API, Arrow et fichiers volumineux. Les extensions sont pertinentes, mais ne doivent pas faire croire que toutes sont à maîtriser avant le défi 1. Ajouter une phrase expliquant que les noms de stations fictifs n'établissent pas une provenance de données réelle.

Production étudiante: script de nettoyage, données traitées, résumé de validation, note de décisions, fonction de validation, deux commits.

### 6. Visualisation

Forces: la question de module est claire, le défi exige une note de conception, l'accessibilité est nommée et le livrable est bien défini. La proposition de projet en semaine 6 crée un lien utile avec le projet filé.

À ajuster: transformer les quatre questions de préparation en mini-test explicite. Éviter le vocabulaire qui donne l'impression que `ggplot2` doit remplacer systématiquement les graphiques de base R. Ajouter un exemple de revue critique d'une figure existante et une variante sur une donnée locale ou de projet, afin de dépasser la manipulation de couches.

Production étudiante: mini-test, script de figure, figure dans `outputs/`, note de conception de 100 à 150 mots, commit, proposition de projet d'équipe.

### 7. Quarto et rapports

Forces: le laboratoire s'appuie utilement sur les données météorologiques de semaine 4. La checklist de rendu, les chemins relatifs, la table, la figure et le document HTML autonome constituent un très bon exercice de production.

À ajuster: corriger immédiatement les quatre blocs `{{r}}`. Transformer les trois questions de la préparation en mini-test explicite. Ajouter une vérification d'accessibilité minimale de la figure et une décision sur le suivi ou non du HTML généré dans Git, afin que la pratique de versionnage reste cohérente avec le reste du cours.

Production étudiante: mini-test, rapport `.qmd`, HTML rendu, tableau et figure dynamiques, texte R en ligne, documentation du nettoyage, commit.

### 10. Programmation fonctionnelle avec tidyverse

Forces: passage bien choisi du code exploratoire vers des fonctions testées. Les objectifs, le laboratoire et le défi sont alignés: fonction, validation d'arguments, tests, `purrr` et refactorisation.

À ajuster: portée lexicale, environnements, promesses, `browser()`, `purrr` et `testthat` constituent une charge conceptuelle élevée. Donner un objectif minimal obligatoire, par exemple une fonction testée et une itération, puis traiter le scoping approfondi comme une extension ou une démonstration. Le défi devrait inviter plus explicitement à refactoriser un fragment du projet ou du portfolio réel.

Production étudiante: mini-test, fonction documentée, tests minimaux, automatisation avec `map()`, note de vérification et commit.

### 11. Programmation orientée objet

Forces: les objectifs expliquent la vraie question pédagogique, soit quand une classe aide réellement. S3 et R6 sont présentés avec une distinction pertinente entre copie et référence.

À ajuster: S3, R6 et une question de mini-test sur S4 font trois systèmes d'objets dans une même semaine. Limiter le noyau à S3 et à la décision d'utiliser ou non R6. Le laboratoire sur Serpents et Échelles rend R6 visible, mais son transfert au projet de science des données doit être explicité ou remplacé par un objet lié à un pipeline, un résultat d'analyse ou une application.

Production étudiante: mini-test, objet S3 ou R6, exemple d'usage, test d'invariant, note de choix architectural et commit.

### 12A. Profilage, optimisation et performance

Forces: le principe mesurer avant d'optimiser est clair et correctement répété. `bench`, `profvis`, préallocation et vectorisation sont reliés à un rapport avant/après et à un compromis de maintenance.

À ajuster: le contenu mérite une séance entière. Il doit donc être le noyau de la semaine 12 ou être réduit pour faire place au parallèle. La préparation, le laboratoire et le défi doivent annoncer clairement ce qui est attendu avant d'aborder `future`.

Production étudiante: mini-test, profilage, benchmark reproductible, comparaison avant/après, justification du compromis, commit.

### 12B. Programmation asynchrone et parallèle

Forces: le laboratoire aborde correctement la reproductibilité aléatoire, la surcharge et le speedup. Il ne promet pas que le parallèle est toujours préférable.

À ajuster: l'accès aux coeurs, la mémoire et le comportement de `multisession` varient selon les machines. Publier un plan de repli séquentiel, un nombre maximal de workers et une consigne selon la puissance disponible. Ne pas évaluer la rapidité absolue, mais la qualité de la comparaison et de la décision. Cette unité doit aussi être présentée comme la seconde partie optionnelle ou choisie de la semaine 12.

Production étudiante: mini-test, plan `future`, comparaison séquentiel-parallèle, vérification de reproductibilité, décision justifiée et commit.

### 14A. Modèles d'apprentissage automatique

Forces: très bon modèle minimal de validation. La séparation entraînement-évaluation, la référence moyenne et la limite d'une seule séparation sont formulées avec prudence. Le code évite une fuite de données évidente.

À ajuster: un modèle prédictif ne doit pas être imposé aux projets descriptifs, de visualisation, d'application ou de génie logiciel. Présenter ce bloc comme une voie optionnelle de synthèse, avec des alternatives équivalentes: validation d'un pipeline, test de sensibilité, audit de donnée ou évaluation d'une interface. Le jeu simulé est raisonnable pour isoler la méthode, mais une passerelle explicite vers le projet réel est nécessaire.

Production étudiante: script ou rapport de modèle, séparation, mesure de performance, référence simple, note de limites, commit.

### 14B. Déploiement et mise en production

Forces: excellente mise en forme de la livraison réelle. La procédure de reproduction, la session propre, les limites et le script de vérification sont directement utiles à la remise finale.

À ajuster: le script de vérification ne contrôle pour l'instant que la structure et, optionnellement, l'existence d'une sortie. Ajouter un gabarit qui exécute réellement le point d'entrée documenté dans un projet simple et qui échoue de façon informative. Il faut aussi préciser que le mot déploiement ne signifie pas qu'un déploiement public est obligatoire.

Production étudiante: README de reproduction, commande principale, script de vérification, dépendances, limites, commit.

### 14C. Cycle de vie des modèles

Forces: excellente conclusion professionnelle. La fiche de suivi relie données, version du code, validation, risques et vérification future. Elle prépare bien la défense de projet.

À ajuster: compléter la référence à Mitchell et al. (2019) par un lien et une citation complète. Rendre la fiche applicable aussi à un pipeline non prédictif, à un tableau de bord ou à un rapport, afin que toute équipe puisse en produire une version pertinente.

Production étudiante: note de préparation, fiche de suivi, trois risques documentés, vérification future, trace portfolio.

### 15. Site personnel, collaboration et documentation finale

Forces: les exigences du site personnel sont désormais très concrètes: URL GitHub Pages, dépôt source, commit évalué, deux réalisations, lien au portfolio, confidentialité et déclaration IA. La distinction entre site, portfolio et défense est excellente.

À ajuster: recentrer les compétences visées et le laboratoire sur ces exigences. Le package R doit être explicitement facultatif et ne doit pas détourner la préparation des remises finales. Prévoir un déroulement de séance qui garantit du temps pour les présentations, la revue de code, la vérification des sites et les questions de défense.

Production étudiante: site publié, dépôt source, commit final, deux réalisations commentées, liaison au portfolio, déclaration IA si nécessaire, défense et revue du projet.

## Ordre recommandé de révision

1. Corriger la syntaxe `{r}` du module 7 et rendre à nouveau cette page.
2. Ajouter le gabarit uniforme de mini-test aux semaines 6 et 7.
3. Créer des pages-semaines intégratrices pour les semaines 12 et 14, puis ajuster les libellés du menu.
4. Recentrer le module 15 sur les livrables réellement évalués et déplacer le package en annexe ou en extension.
5. Ajouter les liens aux grilles et les repères de charge à chaque page de module.
6. Étiqueter les ressources du module 4 par niveau de priorité et ajouter la référence complète sur les model cards.
7. Faire un rendu Quarto intégral dans un clone propre, ouvrir les pages 7, 12, 14 et 15 dans un navigateur, puis valider de nouveau les liens.

## Décision pédagogique proposée

Ne pas réécrire le cours. Conserver l'architecture portfolio-projet-défis-IA, qui est sa principale force. Réduire la charge perçue en regroupant les blocs tardifs, rendre les consignes évaluées localement visibles, et réserver les approfondissements techniques aux choix de projet et à STT-6230. Le cours deviendra ainsi plus lisible pour les étudiants sans perdre son niveau d'ambition.

## Statut après mise en œuvre

Les recommandations de cet audit ont été appliquées dans le site:

- les mini-tests 2, 3, 4, 6, 7, 9, 10, 11 et 12 suivent un format commun; la semaine 12 ne comporte qu'un seul mini-test;
- la semaine 9 possède maintenant une page de consolidation et de revue intermédiaire;
- les semaines 12 et 14 ont chacune une page intégratrice, avec leurs sous-blocs conservés comme ressources;
- la semaine 14 propose une validation adaptée aux projets descriptifs, visuels, applicatifs, logiciels ou prédictifs;
- la semaine 15 est recentrée sur le site personnel, la défense, la revue de code, les contributions et le bilan; le package R est dans une annexe facultative;
- les 14 défis de module sont explicitement formatifs et non notés, avec un repère de grille;
- la règle IA est harmonisée autour de `docs/ai-log.md`;
- les quatre blocs R du module 7 utilisent la syntaxe Quarto correcte ` ```{r} ` et sont affichés sans exécuter les données du portfolio pendant le rendu du site.

Preuves de validation finales: 151 fichiers analysés et 366 liens relatifs valides par `scripts/valider_liens.R`; rendu intégral de 149 sources terminé dans une copie propre avec sortie `_site/index.html`; 34 pages ciblées des semaines 14 et 15 rendues séparément; vérificateur de reproduction testé sur un cas valide et trois échecs informatifs. L'environnement `renv` désynchronisé est resté isolé dans les copies de validation et n'a pas été modifié dans le dépôt.
