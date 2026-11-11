# STT-4230 / STT-6230, 11 novembre 2026
# Fonctions, tests, exceptions et débogage. Données fictives.
# Code sous licence CC BY-NC-SA 4.0.

# Version volontairement incorrecte pour discuter du dénominateur.
proportion_boguee <- function(x, seuil = 10) {
  sum(x >= seuil, na.rm = TRUE) / length(x)
}

# Les valeurs manquantes sont exclues du calcul.
proportion_seuil <- function(x, seuil = 10) {
  if (sum(!is.na(x)) == 0) {
    stop("Aucune mesure observée.")
  }
  mean(x >= seuil, na.rm = TRUE)
}

mesures <- c(12, 8, NA, 15, 10)
print(proportion_boguee(mesures))  # 0.60
print(proportion_seuil(mesures))   # 0.75

tryCatch(
  proportion_seuil(numeric(0)),
  error = function(e) message(conditionMessage(e))
)
print(proportion_seuil(mesures))   # 0.75

# Dans la console, exécuter les lignes séparément :
# debugonce(proportion_boguee)
# proportion_boguee(mesures)
# À l’invite Browse, comparer length(x) et sum(!is.na(x)), puis taper c.
# proportion_seuil(numeric(0))
# traceback()
