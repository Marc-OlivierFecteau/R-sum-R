###
### sqrt(x)
###
##  Calculer la racine carrée d'un nombre.
##
##  Argument
##
##  x: nombre réel positif.
##
##  Valeur
##
##  Nombre y tel que y^2 = x.
##
##  Exemples
##
##  sqrt(9)
##
sqrt <- function(x)
{
    ## Vérification de la validité de 'x'.
    if (x < 0)
        stop("x doit être un nombre positif")

    ## Cas trivial.
    if (x == 0)
        return(0)

    ## Fonction pour calculer la prochaine approximation selon
    ## la méthode de Newton. Si 'y' est l'approximation
    ## actuelle de la racine carrée de 'x', alors la nouvelle
    ## approximation est '(y + x/y)/2'.
    improve <- function(guess, x)
        mean(c(guess, x/guess))

    ## Valeur de départ de la procédure itérative.
    y <- 1

    ## Approximations successives.
    while (abs(y^2 - x) >= 0.001)
        y <- improve(y, x)

    ## Retourner la valeur tel que y^2 - x < 0.001.
    y
}
