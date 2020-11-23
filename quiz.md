Quiz
====


Exigence 1
----------

Rajoutez la gestion du score.
Chaque bonne réponse ajoute 1 au score.
Le score s'affiche à la fin de la partie sous forme "Score obtenu / Nb total de question"

Rajoutez à la fin de la partie un bouton "New Game" qui relance une nouvelle partie

Exigence 2
----------

Modifiez l'interface utilisateur pour que les `Label` et les `Button` soient centrés dans tous les cas.
(Quelque soit le device et l'orientation choisie)

Exigence 3
----------

Rajoutez un bouton "?" proche de la question, lorsqu'il est cliqué, le `hint` de la question s'affiche

Exigence 4
----------

Modifiez la "source" des questions. Supprimez le tableau en "dur" dans le code, par la récupération de questions
à travers un service Web REST.

Ceci implique un changement de stratégie pour la détermination de ce qu'est une "partie" de jeu. A vous de choisir.
Il doit être possible de changer facilement la façon de récupérer les questions (pour par exemple avoir aussi un système
de stockage local).

Pour la partie récupération des données JSON:

 * [Enable getting data out of plain HTTP](http://stackoverflow.com/questions/31254725/transport-security-has-blocked-a-cleartext-http)
 * [REST API In Swift 4 Using URLSession And JSONDecoder](https://mrgott.com/swift-programing/33-rest-api-in-swift-4-using-urlsession-and-jsondecode)
 * Useful legacy classes: `Data`, `URL`, `JSONSerialization`
 
 * https://www.raywenderlich.com/567-urlsession-tutorial-getting-started
 * https://benscheirman.com/2017/06/swift-json/
 * https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types

Exigence 5
----------

Mettez en place ces différents types de parties:

 1. Rookie
    10 questions
    A chaque réponse: +1 au score si c'est la bonne, passe de toute façons à la suivante.
    
 2. Journeyman
    10 questions
    A chaque réponse: +1 au score si c'est la bonne, -1 au score si c'est la mauvaise, passe à la suivante seulement si c'est la bonne.
    
 3. Warrior
    Même chose que Journeyman mais avec 15 questions et restrictions de temps de 30 secondes pour la partie entière.
    
 4. Ninja
    Même chose que Warrior mais en plus avec une limitation du temps par question de 3 secondes.

Exigence 6
----------

Maintenant qu'il y a plusieurs types de parties, ajoutez un nouvel écran qui permette la séléction du type de partie avant de commencer
le jeu.

Objectif: gérer deux _écrans_ (views) dans une même application, passer de l'un à l'autre.

