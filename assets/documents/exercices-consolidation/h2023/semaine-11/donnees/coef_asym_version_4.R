# Tests et exceptions en R
# Exemple de fonction pour les exercices
# auteur : Sophie Baillargeon, Université Laval
# date : 30 mars 2021
# encodage : UTF-8

#**************************************************************************

### Version 4 

# Fonction pour le calcul du coefficient d'asymétrie (skewness)
# Référence : http://en.wikipedia.org/wiki/Skewness, formule G1

# Arguments en entrée :
#   x       un vecteur de valeurs numériques.
#   na.rm   une valeur logique (par défaut FALSE) indiquant si les valeurs
#           NA devraient être enlevée avant de procéder aux calculs.

# Sortie : le coefficient d'asymétrie pour les valeurs dans x

coef_asym <- function(x, na.rm = FALSE){
  
  ## Validation des arguments ##
  if (is.array(x)) {
    warning("x est un array, mais il est traite comme un vecteur")
  }
  if (is.list(x)) {
    stop("x doit etre un vecteur")
  }
  
  ## Calculs ##
  if (na.rm) {
    x <- x[!is.na(x)]
  }
  m3 <- mean((x - mean(x))^3)
  s3 <- sd(x)^3
  n <- length(x)
  G1 <- (n^2) * m3 / ((n - 1) * (n - 2) * s3)
  
  ## Sortie ##
  return(G1)
}

