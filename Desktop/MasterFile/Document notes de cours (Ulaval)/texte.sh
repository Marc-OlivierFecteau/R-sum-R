## Copyright (C) 2020 Vincent Goulet
##
## Ce fichier fait partie du projet «Programmer avec R»
## https://gitlab.com/vigou3/programmer-avec-r
##
## Cette création est mise à disposition sous licence
## Attribution-Partage dans les mêmes conditions 4.0
## International de Creative Commons.
## https://creativecommons.org/licenses/by-sa/4.0/

## Les exemples de ce fichier utilisent les fichiers suivants
## distribués avec le présent ouvrage:
##
## - fichiers de script *.R
## - chanson.txt
## - 100metres.dat
## - carburant.dat
## - NEWS
##
## Assurez-vous d'exécuter les exemples dans un répertoire
## contenant ces fichiers.
##
## Vous pouvez exécuter les commandes ci-dessous telles
## quelles à une ligne de commande Unix, ou encore dans le
## terminal RStudio avec Bash (macOS) ou Git Bash (Windows)
## comme interpréteur de commandes.

###
### OUTILS D'ANALYSE ET DE CONTRÔLE DE TEXTE  `\labelline{texte:outils}`
###

## EXTRACTION DE LIGNES AVEC grep

## L'utilitaire 'grep' permet d'identifier les lignes d'un
## fichier (ou du texte en entrée standard) qui contiennent
## des correspondances avec une expression régulière.
##
## L'expression régulière la plus simple est une chaine de
## caractères standard.
##
## Effectuons d'abord quelques recherches simples dans le
## texte de la chanson «La journée qui s'en vient est flambant
## neuve».
grep 'temps' chanson.txt   # vers contenant le mot «temps»
grep 'chat' chanson.txt	   # vers contenant le mot «chat»

## Remarquez que 'grep' est sensible à la casse.
grep 'Même' chanson.txt	   # vers contenant le mot «Même»
grep 'même' chanson.txt	   # vers contenant le mot «même»

## Dressons maitenant la liste de toutes les utilisations de
## la fonction 'matrix' dans les fichiers d'exemples.
##
## Lorsque 'grep' recoit plusieurs fichiers en entrée, il
## effectue la recherche dans tous les fichiers tour à tour.
##
## La syntaxe '*.R' signifie: tous les fichiers dont le nom se
## termine par l'extension «.R». (Attention: il s'agit d'une
## syntaxe de l'interpréteur de commande Bash, et non d'une
## expression régulière.)
grep 'matrix' *.R

## L'option '-l' de 'grep' permet de limiter les résultats à
## la liste des fichiers contenant au moins une utilisation de
## 'matrix'.
grep -l 'matrix' *.R

## Recherchons maintenant les fichiers d'exemples dans
## lesquels apparaissent les objets 'letters' et 'LETTERS'.
## Nous devons rechercher sans égard à la casse pour attraper
## les deux cas. L'option '-i' de 'grep' permet d'ignorer la
## casse.
grep -i 'letters' *.R

## RECHERCHE ET REMPLACEMENT DE TEXTE AVEC sed

## L'utilitaire 'sed' est un éditeur de texte en ligne très
## puissant, mais dont le fonctionnement et la syntaxe des
## commandes laissent souvent perplexe. Dans le cadre de cet
## ouvrage, nous nous pencherons uniquement sur les opérations
## de recherche et de remplacement de texte de 'sed'.
##
## La syntaxe de la commande de recherche et remplacement est
## la suivante:
##
##   s/<motif>/<remplacement>/[g]
##
## - <motif> est une expression régulière qui définit le texte
##   à rechercher;
## - <remplacement> est le texte qui doit remplacer le texte
##   identifié par <motif>;
## - «/» est en fait un symbole quelconque (mais «/» est celui
##   le plus souvent utilisé) qui sert à délimiter les parties
##   de la commande;
## - g est un modificateur optionnel qui indique à 'sed'
##   d'effectuer le remplacement pour toutes les
##   correspondances sur une même ligne ('sed'
##   effectue le changement uniquement pour la première
##   correspondance par défaut).
##
## Reprenons d'abord les exemples du chapitre basés sur le
## fichier chanson.txt.
sed 's/Oh/Ah/' chanson.txt # remplacer «Oh» par «Ah»
sed 's~Oh~Ah~' chanson.txt # idem avec un autre séparateur
sed 's|Oh|Ah|' chanson.txt # idem avec un autre séparateur
sed 's/mm/MM/' chanson.txt # remplacer «mm» par «MM»;

## Observez maintenant l'effet du modificateur 'g' dans le
## remplacement de «promets» par «jure». Sans lui, seul le
## premier mot de la ligne est remplacé. Pour remplacer toutes
## les occurrences de «promets» sur une ligne par «jure», il
## faut ajouter le modificateur 'g' à la commande.
sed 's/promets/jure/' chanson.txt
sed 's/promets/jure/g' chanson.txt

## Remplaçons maintenant les symboles de commentaires triples
## '###' en début de ligne (à la Emacs) dans le fichier
## 'pratiques.R' par un symbole unique '#' (à la RStudio).
##
## Comme nous le verrons dans la suite du chapitre, le symbole
## «^» identifie le début d'une ligne.
sed 's/^###/#/' pratiques.R

## Le texte modifié par 'sed' est affiché à la sortie standard
## sans modifier le fichier d'origine.
##
## Pour sauvegarder le texte modifié, il faut rediriger la
## sortie standard vers un fichier avec l'opérateur de
## redirection «>». Le nom de ce fichier doit être différent
## de celui que 'sed' est occupé à traiter.
##
## Reprenons l'exemple précédent en sauvegardant le résultat
## dans un nouveau fichier 'pratiques-new.R'.
sed 's/^###/#/' pratiques.R > pratiques-new.R #-*- `\labelline{texte:outils:fin}`

###
### EXPRESSIONS RÉGULIÈRES  `\labelline{texte:regex}`
###

## SYNTAXE DE BASE  `\labelline{texte:regex:syntaxe}`

## Les règles de base des expressions régulières sont simples
## et peu nombreuses:
##
## 1. un caractère littéral correspond à lui-même (plus
##    précisément: à sa première occurrence dans le texte
##    examiné);
## 2. les composantes d'une expression régulière sont reliées
##    par «et» par défaut;
## 3. des opérateurs permettent de définir des motifs
##    contenant autre chose que des caractères littéraux.
##
## Examinons quelques exemples simples de recherches dans le
## mot «chatons». Exécutez aussi ces exemples dans un testeur
## d’expressions régulières en ligne afin de mieux voir à quel
## texte les motifs correspondent.
##
## Le texte est composé avec la commande 'echo' et passé
## ensuite à 'grep' avec l'opérateur de transfert de données
## (tuyau).
echo "chatons" | grep 'c'
echo "chatons" | grep 't'
echo "chatons" | grep 'b'
echo "chatons" | grep 'chat'
echo "chatons" | grep 'chaton'
echo "chatons" | grep 'ton'
echo "chatons" | grep 'chats'

## Il existe des différences importantes dans les définitions
## des opérateurs entre les expressions régulières basiques
## (BRE) et les expressions régulières étendues (ERE).
##
## Dès lors que votre motif contient un opérateur, je vous
## recommande d'utiliser les expressions régulières étendues.
## On les active dans 'grep' et dand 'sed' avec l'option '-E'.
##
## Par exemple, le symbole «|» est l'opérateur d'alternance
## («ou») dans les ERE et un caractère littéral dans les BRE.
grep 'chat|chien' chanson.txt	 # recherche «chat|chien»
grep -E 'chat|chien' chanson.txt # recherche «chat» ou «chien»

## Illustrons quelques-uns des principaux opérateurs des
## expressions régulières étendues. Nous reviendrons sur
## ceux-ci plus en détail plus loin.
##
## Débutons avec un autre exemple d'alternance («ou»).
grep -E 'amour' chanson.txt	   # «amour» sur une ligne
grep -E 'mieux' chanson.txt	   # «mieux» sur une ligne
grep -E 'amour|mieux' chanson.txt  # l'un OU l'autre

## Début et fin de ligne.
grep -E 'la' chanson.txt	   # «la» sur une ligne
grep -E '^la' chanson.txt	   # «la» en début de ligne
grep -E 'que' chanson.txt	   # «que» sur une ligne
grep -E 'que$' chanson.txt   # «que» en fin de ligne

## Le point «.» a un rôle très important dans les expressions
## régulières: il représente «n'importe quel caractère».
##
## Puisque l'espace constitue également un caractère littéral,
## le motif ' . ' permet de rechercher un mot d'une lettre
## (non placé en début ou en fin de ligne puisqu'il doit être
## précédé et suivi d'une espace).
grep -E ' . ' chanson.txt

## Voici deux manières de rechercher un mot d'exactement deux
## lettres (toujours placé ailleurs qu'en début ou en fin de
## ligne):
grep -E ' .. ' chanson.txt      # doublement de l'opérateur
grep -E ' .{2} ' chanson.txt    # opérateur + quantificateur
grep -E -o ' .{2} ' chanson.txt # afficher les correspondances

## Une autre manière simple de visualiser les correspondances
## d'un motif dans du texte consiste à remplacer celles-ci
## avec 'sed' par du texte facile à repérer.
sed 's/a/!/' chanson.txt
sed 's/am/--/' chanson.txt #-*- `\labelline{texte:regex:syntaxe:fin}`

## REMPLACEMENT ET RÉPÉTITION  `\labelline{texte:regex:wildcards-marqueurs}`

## Comme mentionné ci-dessus, le caractère «.» est le
## caractère de remplacement dans les expressions régulières.
## Il signigie «n'importe quel caractère», y compris l'espace.
##
## Le motif 'ou. ' permet d'identifier les mots se terminant
## par «ou» et un caractère quelconque. L'espace dans le motif
## permet de délimiter un mot. Les mots en fin de ligne sont
## donc exlus de l'expression régulière.
grep -E 'ou. ' chanson.txt

## L'option '-o' de 'grep' permet d'afficher la partie de la
## ligne qui correspond au motif.
grep -E -o 'ou. ' chanson.txt

## Les opérateurs de répétition permettent de décrire des
## suites de caractères. Il existe quatre opérateurs de
## répétition dans les expressions régulières étendues:
##
##   *   : ce qui précède 0 ou plusieurs fois;
##   ?   : ce qui précède 0 ou 1 fois;
##   +   : ce qui précède 1 ou plusieurs fois;
##   { } : quantificateurs bornés.
##
## Pour illustrer le fonctionnement des opérateurs de
## répétition, nous allons créer un petit fichier 'ah.txt'
## contenant des onomatopées "ah!" de diverses longueurs, à
## raison de une par ligne.
s="h"
for i in {1..6}; do echo "a${s}"'!'; s+="h"; done > ah.txt

## Vérification du contenu du fichier.
cat ah.txt

## Comparez les résultats des trois commandes suivantes.
grep -E 'ahh?!' ah.txt	   # un ou deux «h»
grep -E 'ahh*!' ah.txt	   # un «h» un plus
grep -E 'ahh+!' ah.txt	   # deux «h» et plus

## Les quantificateurs bornés s'utilisent de trois façons:
##
##   {n}   : ce qui précède exactement 'n' fois
##   {n,m} : ce qui précède entre 'n' et 'm' fois
##   {n,}  : ce qui précède au moins 'n' fois
##
## Nous devons avoir recours aux quantificateurs bornés
## lorsque les cas les plus fréquents couverts par '*', '+' et
## '?' ne suffisent plus ou seraient trop longs à écrire (et
## moins lisibles).
grep -E 'ah{3}!' ah.txt	   # exactement trois «h»
grep -E 'ah{3,5}!' ah.txt  # entre trois et cinq «h»
grep -E 'ah{3,}!' ah.txt   # trois «h» et plus

## Les opérateurs de répétition sont souvent utilisés avec le
## caractère de remplacement pour décrire des chaines de
## caractères arbitraires.
##
## La commande suivante permet d'extraire du fichier
## 'chanson.txt' les vers qui débutent par «L» (les majuscules
## se trouvant uniquement en début de ligne) et qui
## contiennent un «i» quelque part sur la ligne.
grep -E 'L.*i' chanson.txt

## Remplacer le motif 'L.*i' dans la commande précédente par
## 'L.*e' permet d'illustrer le caractère glouton des
## opérateurs de répétition.
##
## Au premier abord, il semble que 'L.*e' devrait correspondre
## au mot «Le» que l'on retrouve au début de plusieurs vers.
## Or, la chaine correspondante se prolonge plutôt jusqu'au
## dernier «e» de la ligne, comme l'option '-o' de 'grep'
## permet de le constater.
grep -E 'L.*e' chanson.txt
grep -E -o 'L.*e' chanson.txt

## La commande suivante permet d'extraire les lignes de
## commentaires contenant du texte du fichier 'bases.R'.
## Celles-ci sont constituées de deux ou trois symboles «#»
## successifs suivis d'une espace et d'au moins un autre
## caractère
grep -E '^###? .+' bases.R

## Nettoyage: supprimer le fichier 'ah.txt'
rm ah.txt

## CARACTÈRE D'ÉCHAPPEMENT

## Y a-t-il un point final quelque part dans le fichier
## 'chanson.txt'? Demandons à 'grep' de nous trouver ça.
grep '.' chanson.txt

## La commande ci-dessus n'a pas donné le résultat escompté,
## hein? Puisque le symbole «.» est un opérateur signifiant
## «n'importe quel caractère» dans les expressions régulières,
## le motif '.' correspond à toute ligne contenant au moins un
## caractère. C'est pourquoi la commande précédente retourne
## l'intégralité du fichier... sauf les lignes blanches.
##
## Pour rechercher le caractère «.», il faut enlever au
## symbole sa signification particulière en le précédant d'une
## barre oblique inversée «\». (Il s'agit là d'une convention
## très répandue dans plusieurs langages informatiques.)
grep '\.' chanson.txt	   # aucun point final dans le fichier

## Dans le même esprit, recherchons dans le fichier 'bases.R'
## toutes les occurrences du caractère «?». Dans les
## expressions régulières étendues, c'est un symbole spécial
## qu'il faut désactiver avec le caractère d'échappement.
grep -E '\?' bases.R

## MARQUEURS DE POSITION

## Le symbole «^» identifie le début d'une ligne. Comparer les
## résultats des deux commandes ci-dessous.
grep 'la' chanson.txt 	   # «la» n'importe où sur la ligne
grep '^la' chanson.txt 	   # «la» en début de ligne

## Le symbole «$» identifie la fin d'une ligne. Comparer les
## résultats des deux commandes ci-dessous.
grep 'que' chanson.txt 	   # «que» n'importe où sur la ligne
grep 'que$' chanson.txt	   # «que» en fin de ligne

## Le motif '^$' signifie: un début de ligne immédiatement
## suivi d'une fin de ligne. Il s'agit du motif robuste pour
## rechercher une ligne blanche (ou vide) dans du texte. (Le
## motif '.' mentionné ci-dessous retiendrait une ligne
## comptant au moins une espace.)
grep -c '^$' chanson.txt   # nombre de lignes blanches
grep -v '^$' chanson.txt   # lignes blanches supprimées `\labelline{texte:regex:wildcards-marqueurs:fin}`

## CLASSES DE CARACTÈRES  `\labelline{texte:regex:classes-groupes}`

## Les crochets '[ ]' définissent une classe de caractères
## dans les expressions régulières. Les classes de caractères
## sont particulièrement utiles pour:
##
## - définir un choix entre plusieurs caractères, les
##   composantes d'une classe étant reliées par «ou»;
## - définir facilement une longue liste de symboles (toutes
##   les lettres minuscules, par exemple);
## - définir un motif par la négative («n'importe quoi
##   sauf...»).
##
## (D'ailleurs, les crochets sont souvent utilisés dans la
## documentation en informatique pour représenter un choix
## entre plusieurs éléments ou quelque chose d'optionnel.)
##
## Premier exemple: rechercher un mot écrit avec une majuscule
## ou une minuscule initiale.
grep '[Mm]ême' chanson.txt # fonctionne toujours
grep -i 'même' chanson.txt # idem, mais dépend de 'grep'

## La commande suivante identifie les utilisations de «ou»
## dans 'chanson.txt' qui ne sont PAS suivies de «r» ni de
## «s».
grep 'ou[^rs]' chanson.txt

## La commande suivante extrait toutes les mentions des
## fonction 'lapply', 'sapply' et 'tapply' du fichier
## 'donnees.R'.
grep '[slt]apply' donnees.R

## Pour exclure les mentions dans les commentaires, ajoutons
## des pièces au motif pour exiger que la ligne débute par
## tout caractère AUTRE que '#'. Permettons également, avec
## l'opérateur '*' que ce caractère apparaisse 0 ou plusieurs
## fois, ce qui permet d'identifier les utilisations des
## fonctions d'application ailleurs qu'au début d'une ligne.
grep '^[^#]*[slt]apply' donnees.R

## La classe de caractère renversée (qui débute par «^») est
## particulièrement utile pour restreindre la portée des
## quantificateurs gloutons.
##
## Par exemple, tel qu'expliqué dans le chapitre, le motif
## 'L.+c' --- que l'on voudrait signifier «L suivi d'au moins
## un caractère, puis un c» ---- trouve un accord avec les
## caractères jusqu'au «c» dans «lâche» lorsque appliqué à «Le
## chemin du plus lâche»
echo 'Le chemin du plus lâche' | grep -E -o 'L.+c'

## Le truc pour limiter la portée du quantificateur («+» dans
## le présent exemple) consiste à modifier la recherche
##
##   L suivi d'au moins un caractère, puis un c
##
## par
##
##   L suivi de n'importe quoi d'autre qu'un c, puis un c.
##
## De cette manière, le moteur d'expressions régulière devra
## cesser sa recherche au tout premier «c» rencontré!
echo 'Le chemin du plus lâche' | grep -E -o 'L[^c]+c'

## Utilisons ce truc pour identifier dans le fichier 'bases.R'
## les utilisations de la fonction de concaténation 'c' avec
## exactement trois arguments. Les arguments sont séparés par
## des virgules.
##
## Les parenthèses étant des opérateurs dans les expressions
## régulières étendues, il faut les désactiver dans le motif
## avec le caractère d'échappement pour rechercher les
## caractères eux-mêmes.
grep -E 'c\([^,]*, [^,]*, [^,]*\)' bases.R

## Si vous avez étudié attentivement le résultat de la
## commande précédente, vous aurez identifié quelques
## anomalies.
##
## Pourquoi retrouve-t-on quelques appels de fonction avec
## seulement deux arguments?
##
## Réponse: une autre virgule suivie de texte et d'une
## parenthèse fermante se trouve plus loin sur la ligne,
## au-delà de la véritable fin de l'appel de fonction.
##
## Améliorons un peu notre motif pour empêcher de trouver un
## accord avec une parenthèse fermante avant le troisième
## argument.
grep -E 'c\([^,)]*, [^,)]*, [^,]*\)' bases.R

## Tournons-nous brièvement vers les plages de caractères et
## les classes prédéfinies.
##
## Le fichier '100metres.dat' contient la liste des 31
## meilleurs temps enregistrés au 100 mètres homme entre 1964
## et 2005. Identifions, parmi les records effectués dans les
## mois de mai, juin et juillet.
##
## (J'ai ajouté un «-» à la fin du motif pour m'assurer de ne
## pas identifier une date entre le 6e et le 8e jour du mois.
## Vous remarquerez aussi que le motif utilisé ne résisterait
## pas à l'ajout de dates entre 2006 et 2008, inclusivement.)
grep '0[6-8]-' 100metres.dat

## Le fichier 'NEWS' contient l'historique des versions de
## l'ouvrage.
##
## Les nouvelles versions sont toujours identifiées par un
## symbole '#' unique en début de ligne suivi d'un chiffre (le
## premier du numéro de version).
##
## La commande suivante dresse la liste des numéros de
## versions de l'ouvrage au fil des années.
grep -E '^# [[:digit:]]' NEWS

## ALTERNANCE

## Le caractère «|» permet d'effectuer un choix entre deux
## expressions régulières étendues. Autrement dit, c'est
## l'opérateur «ou» comme dans plusieurs langages de
## programmation (dont R).
grep -E 'mouvement|fatigue' chanson.txt

## L'alternance se fait entre tout ce qui se trouve à gauche
## de l'opérateur et tout ce qui se trouve à droite.
##
## Conséquemment, il faut souvent utiliser l'opérateur
## d'alternance avec les parenthèses pour en limiter la
## portée.
##
## La comparaison des quatre commandes de substitution
## ci-dessous permet d'observer l'effet des parenthèses.
sed -E 's/le mouvement|la fatigue/le pendule/'
sed -E 's/l[ea] (mouvement|fatigue)/le pendule/'
sed -E 's/le|la mouvement|fatigue/le pendule/'
sed -E 's/(le|la) (mouvement|fatigue)/le pendule/'

## Allons-y maintenant d'une expression régulière qui permet
## de trouver toutes les utilisations de la fonction 'g' dans
## les fichiers d'exemples, c'est-à-dire la chaine 'g('
## précédée d'au moins une espace ou en début de ligne.
grep -E '( |^)g\(' *.R

## GROUPES

## Outre limiter la portée de l'opérateur d'alternance, les
## parenthèses servent, un peu comme en mathématiques, à
## définir des groupes dans les expressions régulières
## étendues. Nous pouvons ensuite appliquer des opérateurs à
## ces groupes.
##
## Penchons-nous de nouveau sur l'exemple d'identification des
## utilisations de la fonction de concaténation 'c' avec
## exactement trois arguments dans 'donnees.R'.
##
## Puisque le premier et le second bloc du motif sont
## identiques, nous pouvons réécrire le motif comme
## ci-dessous. (Ça devient moins lisible, hein?).
grep -E 'c\(([^,)]*, ){2}[^,]*\)' bases.R

## Les parenthèses servent aussi à créer des groupes de
## capture. C'est surtout utile avec 'sed' pour réutiliser
## dans le texte de remplacement du texte trouvé lors de la
## recherche.
sed -E 's/Le (.*) (.*) (.*)/Le \2 \3 \1/'

## La commande ci-dessous remplace toutes les occurrences de
## la chaine «foo», mais pas de «foob» (comme «foobar»), dans
## 'bases.R' par «abc» et le caractère qui suit «foo».
sed -E 's/foo([^b])/abc\1/g' bases.R #-*- `\labelline{texte:regex:classes-groupes:fin}`

###
### TRAITEMENT DE TEXTE DIVISÉ EN CHAMPS AVEC AWK  `\labelline{texte:awk}`
###

## Cette section regroupe certains exemples d'utilisation de
## 'awk' tirés du texte du chapitre, ainsi que des exemples
## additionnels.
##
## Effectuons d'abord l'extraction des temps des records dans
## le fichier '100metres.dat'. C'est le second champ du
## fichier. Voilà un travail tout désigné pour 'awk'.
awk '{ print $2 }' 100metres.dat

## Nous pouvons aussi aisément avec 'awk' inverser les deux
## colonnes du fichier.
awk '{ print $2, $1 }' 100metres.dat

## Les colonnes du fichier '100metres.dat' sont séparées par
## une espace. Remplaçons ces espaces par des virgules pour
## convertir le fichier en format CSV. Je fournis deux
## solutions, avec 'awk' (la plus simple) et avec 'sed'.
awk '{ print $1 \",\" $2 }' 100metres.dat
sed 's/ /,/' 100metres.dat

## Changeons maintenant le format de la date du format ISO
## 8601 'aaaa-mm-qq' vers le format américain 'qq/mm/aa'.
## D'abord une solution avec 'awk'.
##
## En premier lieu, nous devons changer le séparateur de
## champs de 'awk' pour l'espace et le tiret. Ainsi, 'awk' va
## non seulement séparer les deux colonnes du fichier, mais
## aussi les champs de la date.
##
## Il suffit ensuite de replacer les champs dans l'ordre voulu
## avec les bons séparateurs. La fonction 'substr' de awk
## permet de sélectionner une partie d'une chaine de
## caractères (voir la section~9.1.3 du guide d'utilisation de
## GNU Awk).
awk 'BEGIN { FS = "[ -]" }
     { print $2"/"$3"/"substr($1, 3), $4 }' \
     100metres.dat

## La solution avec 'sed' maintenant, qui repose non pas
## sur des champs détectés automatiquement, mais plutôt sur la
## recherche et le remplacement d'expressions régulières.
##
## Le motif recherche, en capturant chaque élément trouvé
## (sauf les tirets):
##
## - les nombres 19 ou 20;
## - deux chiffres;
## - un tiret;
## - deux chiffres;
## - un tiret;
## - deux chiffres;
## - tout le reste de la ligne.
##
## Il s'agit ensuite de replacer les éléments capturés dans
## l'ordre souhaité avec des barres obliques '/' entre les
## éléments de dates.
##
## Comme le symbole '/' est utilisé dans la chaine de sortie,
## il vaut mieux utiliser un autre symbole pour séparer les
## champs de la commande 'sed'. J'ai utilisé le symbole '~'.
sed -E \
  's~(19|20)([0-9]{2})-([0-9]{2})-([0-9]{2})(.*)~\3/\4/\2\5~'\
  100metres.dat

## Les deux commandes suivantes sont reprises du texte du
## chapitre. Elles utilisent le fichier 'carburant.txt'.
##
## La première permet de créer une nouvelle base de données ne
## contenant que les modèles de voitures 4 cyclindres sans
## passer par un tableur ou par R.
awk '/^[#a-z]/ || $2 == 4' carburant.dat

## L'ajout d'une action à la commande précédente permet de
## conserver uniquement les deux premiers champs des données.
## La sélection doit évidemment s'effectuer uniquement sur les
## titres de colonnes et sur les données.
awk '/^[#a-z]/ || $2 == 4 {
         print ($0 ~ /^#/) ? $0 : $1 " " $2
     }' carburant.dat

## La commande suivante, aussi reprise du texte du chapitre,
## extrait les deux premiers couplets de «La journée qui s'en
## vient est flambant neuve».
awk '$/^$/ && state == 1 { exit }
     $/^$/ { state = 1 }
     1' chanson.txt

## Dans la même veine, nous souhaitons extraire du fichier
## 'NEWS' les notes de mise à jour de la plus récente version
## de l'ouvrage.
##
## Les notes relatives à une version donnée débutent toujours
## à une ligne marqué par '# '.
##
## Cette opération requiert une variable d'état pour
## identifier les lignes que vous souhaitons extraire.
##
## De la manière dont les règles sont écrites dans la
## commande, leur ordre n'a pas d'importance. (Déterminez
## pourquoi en comparant avec l'exemple similaire ci-dessus.)
##
## La dernière règle sert à afficher les lignes que nous
## voulons extraire (grâce à l'action implicite). Le motif est
## équivalent à 'state == 1' ou 'state != 0' puisque 'awk'
## évalue l'expression et détermine que le motif correspond si
## la valeur est non nulle.
awk '(state == 0) && /^# / { state = 1; next }
     (state == 1) && /^# / { exit }
     state' NEWS	   #-*- `\labelline{texte:awk:fin}`
