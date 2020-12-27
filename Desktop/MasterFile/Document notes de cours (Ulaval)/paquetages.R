## Copyright (C) 2020 Vincent Goulet
##
## Ce fichier fait partie du projet «Programmer avec R»
## https://gitlab.com/vigou3/programmer-avec-r
##
## Cette création est mise à disposition sous licence
## Attribution-Partage dans les mêmes conditions 4.0
## International de Creative Commons.
## https://creativecommons.org/licenses/by-sa/4.0/

###
### CRÉATION D'UNE BIBLIOTHÈQUE PERSONNELLE 
###

## Liste des bibliothèques consultées par R. Votre
## bibliothèque personnelle devrait y apparaitre si vous avez
## suivi la procédure expliquée dans le chapitre.
.libPaths()

## Comme alternative à la procédure du chapitre, il est
## possible de créer le répertoire pour la bibliothèque
## personnelle, puis d'inscrire son emplacement dans le
## fichier ~/.Renviron directement depuis R.
##
## Tout d'abord, la commande 'dir.create' crée un répertoire
## dans le système de fichier. Adaptez les chemins d'accès
## selon vos besoins.
##
## Si vous êtes sous macOS, utilisez la commande suivante.
dir.create("~/Library/R/library", recursive = TRUE) # macOS

## Pour tous les autres systèmes d'exploitation, utilisez
## plutôt la commande suivante.
dir.create("~/R/library", recursive = TRUE) # autres OS

## Ensuite, la commande 'writeLines' permet d'écrire
## directement dans un fichier. Assurez-vous que le chemin
## d'accès correspond à celui utilisé ci-dessus.
##
## Si vous êtes sous macOS, utilisez la commande suivante.
writeLines('R_LIBS_USER="~/Library/R/library"',
           con = "~/.Renviron")

## Pour tous les autres systèmes d'exploitation, utilisez
## plutôt la commande suivante.
writeLines('R_LIBS_USER="~/R/library"',
           con = "~/.Renviron")

###
### SYSTÈME DE BASE
###

## La fonction 'search' retourne la liste des environnements
## dans lesquels R va chercher un objet (en particulier une
## fonction). '.GlobalEnv' est l'environnement de travail.
search()

## Liste de tous les packages installés sur votre système.
## Noter que MASS et tools en fant partie. Ce sont des
## paquetages livrés avec R, mais qui ne sont pas chargés par
## défaut.
library()

###
### UTILISATION D'UN PAQUETAGE
###

## Chargement du package MASS qui contient plusieurs
## fonctions statistiques très utiles.
library("MASS")

###
### INSTALLATION DE PAQUETAGES ADDITIONNELS
###

## Installation du paquetage actuar depuis un site miroir de
## CRAN sélectionné automatiquement.
##
## Si vous avez configuré une bibliothèque personnelle et
## qu'elle apparait dans le résultat de '.libPaths()',
## ci-dessus, le paquetage sera automatiquement installé dans
## celle-ci.
install.packages("actuar", repos = "https://cloud.r-project.org")

## Chargement du paquetage dans la session de travail. R
## recherche le paquetage dans toutes les bibliothèques de
## '.libPaths()'.
library("actuar")
