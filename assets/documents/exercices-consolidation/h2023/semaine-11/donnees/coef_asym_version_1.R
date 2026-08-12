# Tests et exceptions en R
# Exemple de fonction pour les exercices
# auteur : Sophie Baillargeon, Université Laval
# date : 30 mars 2021
# encodage : UTF-8

#**************************************************************************

### Version 1 

# Fonction pour le calcul du coefficient d'asymétrie (skewness)
# Référence : http://en.wikipedia.org/wiki/Skewness, formule G1

# Arguments en entrée :
#   x       un vecteur de valeurs numériques.
#   na.rm   une valeur logique (par défaut FALSE) indiquant si les valeurs
#           NA devraient être enlevée avant de procéder aux calculs.

# Sortie : le coefficient d'asymétrie pour les valeurs dans x

coef_asym <- function(x, na.rm = FALSE){
  m3 <- mean((x - mean(x, na.rm = na.rm))^3, na.rm = na.rm)
  s3 <- sd(x, na.rm = na.rm)^3
  n <- length(x)
  G1 <- (n^2) * m3 / ((n - 1) * (n - 2) * s3)
  G1
}

