# Données

Ce dossier est prévu pour les données utilisées dans le site ou dans les exemples du cours.

## Structure

```text
data/
  raw/
  processed/
```

## Règles

- Ne jamais publier de données nominatives ou sensibles.
- Vérifier les droits d’utilisation avant de déposer un fichier.
- Conserver les données brutes séparées des données transformées.
- Documenter la source, la date d’accès et les limites.
- Utiliser des chemins relatifs.
- Ne pas déposer de clés API ni de fichiers `.env`.

## Fichiers versionnés

Par défaut, les contenus de `data/raw/` et `data/processed/` sont ignorés par Git. Ajouter seulement des données explicitement autorisées et utiles au site public.
