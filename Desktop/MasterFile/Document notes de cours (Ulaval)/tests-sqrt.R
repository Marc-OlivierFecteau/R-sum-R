## Tests unitaires de la fonction 'sqrt' de calcul de la
## racine carrée par la méthode des approximations successives
## de Newton.
stopifnot({
    tools::assertError(sqrt(-1))
    identical(0, sqrt(0))
    all.equal(3, sqrt(3)^2,
              tolerance = 0.001)
})
