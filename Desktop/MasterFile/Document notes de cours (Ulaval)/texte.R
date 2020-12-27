## Copyright (C) 2020 Vincent Goulet
##
## Ce fichier fait partie du projet «Programmer avec R»
## https://gitlab.com/vigou3/programmer-avec-r
##
## Cette création est mise à disposition sous licence
## Attribution-Partage dans les mêmes conditions 4.0
## International de Creative Commons.
## https://creativecommons.org/licenses/by-sa/4.0/

## Reprenons d'abord certains des exemples pour la ligne de
## commande Unix effectués sur le fichier chanson.txt.
##
## Pour ce faire, il faut importer le contenu du fichier dans
## R. La fonction 'readLines' lit un fichier et retourne un
## vecteur de chaines de caractères, à raison d'une chaine par
## ligne du fichier.
##
## Vous remarquerez que cela correspond au mode de
## fonctionnement de 'grep', 'sed' et 'awk': une ligne à la
## fois.
chanson <- readLines("chanson.txt") # importer le fichier
chanson                             # contenu du vecteur

## Effectuons maintenant quelques recherches dans le vecteur
## avec la fonction 'grep' de R. Le résultat est l'indice de
## l'élément du vecteur contenant le motif.
grep("temps", chanson)     # vers contenant le mot «temps»
grep("chat", chanson)      # vers contenant le mot «chat»

## Pour obtenir le texte de l'élément plutôt que sa position
## dans le vecteur, il faut utiliser 'value = TRUE'.
grep("temps", chanson, value = TRUE)

## R utilise par défaut des expressions régulières étendues
## (donc le symbole | est un opérateur d'alternance).
grep("amour|mieux", chanson, value = TRUE)

## Changeons un peu de jeu de données.
##
## La fonction 'data' retourne la liste des jeux de données
## disponible dans la session R courante. Le résultat est une
## liste de plusieurs éléments.
data()

## L'expression ci-dessus permet de ne conserver que les noms
## d'objets.
(nm <- data()$results[, "Item"])

## Pour extraire de la liste les objets dont le nom comporte
## un point «.», il faut désactiver le rôle spécial de ce
## caractère dans l'expression régulière à l'aide du caractère
## d'échappement.
grep("\.", nm)             # erreur!

## L'expression ci-dessus cause une erreur parce que R
## interprète le caractère d'échappement à l'intérieur du
## motif.
##
## Il existe deux solutions pour régler ce problème.
##
## La première consiste à doubler le caractère d'échappement.
## Ça devient rapidement pénible s'il y a plusieurs caractères
## à doubler.
grep("\\.", nm, value = TRUE)

## La seconde est disponible depuis la version 4.0.0 de R. Il
## s'agit des chaines de caractères brutes. En gros, une
## chaine de caractères brute se charge d'ajouter les
## caractères d'échappement aux bons endroits et retourne une
## chaine de caractères standard.
##
## On crée une chaine brute avec 'r"(...)"'.
r"(\.)"                    # syntaxe d'une chaine brute
r"(g.*\..*\()"             # autre exemple
grep(r"(\.)", nm, value = TRUE) # utilisation dans 'grep'

## L'expression suivante identifie les éléments (ou vers) de
## 'chanson' qui débutent par «L» et qui contiennent un «i»
## quelque part dans la chaine. Le résultat est un vecteur des
## positions des éléments qui correspondent au motif.
grep("^L.*i", chanson)     # positions des éléments

## La fonction 'regexpr' retourne davantage d'informations sur
## la position et la longueur des appariements du motif dans
## la chaine de caractères.
##
## Le vecteur des résultats contient une valeur positive
## correspondant à la position dans la chaine où débute chacun
## des appariements, ou -1 si la chaine ne correspond pas au
## motif. (Dans notre exemple, les nombres positifs sont tous
## des 1 puisque nous recherchons précisément des appariements
## dès le début de la ligne.)
##
## Le vecteur des résultats est également muni d'un attribut
## qui contient la longueur des appariements.
regexpr("^L.*i", chanson)  # plus d'informations

## À partir des résultats de 'regexpr', il est possible
## d'extraire uniquement les portions de texte qui
## correspondent au motif, un peu comme avec l'option '-o' de
## 'grep'.
##
## Il suffit, pour chaque appariement, d'extraire le texte de
## la chaine à partir de la position initiale de l'appariement
## et pour la longueur de celui-ci.
##
## Ce travail, la fonction 'regmatches' le fait pour nous.
regmatches(chanson, regexpr("^L.*i", chanson))

## Les fonctions 'sub' et 'gsub' jouent en partie le rôle de
## 'sed' dans R, soit remplacer des chaines de caractères.
##
## La fonction 'sub' remplace uniquement la première
## occurrence dans une chaine de caractères, alors que 'gsub'
## remplace toutes les occurences (comme 'sed' lorsque muni du
## modificateur 'g').
sub("Oh", "Ah", chanson)
sub("promets", "jure", chanson)
gsub("promets", "jure", chanson)

## Plusieurs autres fonctions de R acceptent des expressions
## régulières en argument.
##
## Par exemple, la fonction 'list.files' permet d'obtenir la
## liste des fichiers (du répertoire de travail par défaut)
## dont le nom correspond à un certain motif.
##
## Les expressions ci-dessous affichent la liste des fichiers
## dont le nom se termine par l'extension ".R".
list.files(pattern = "\\.R$")   # avec chaine standard
list.files(pattern = r"(\.R$)") # avec chaine brute
