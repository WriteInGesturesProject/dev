# ![](https://github.com/WriteInGesturesProject/dev/blob/master/writeInGesture/assets/logo.png) 

## Rappel du sujet/besoin et cahier des charges
Ce projet porte sur le developpement d'une application mobile pour une utilisation sur tablette à usage des enfants atteints de trouble du langage.
Il nous a été proposé par une ortophoniste du CHU de Grenoble (Estelle Gillet-Perret).
Le but de cette application est d'aider les enfants à travailler leur prononciation de manière autonome, à la maison par l'intermédiaire de mini-jeux et de [la méthode Borel-Maisonny](https://fr.wikipedia.org/wiki/M%C3%A9thode_Borel-Maisonny).
Ce genre d'application existe déjà, malheureusement toutes les alternatives à cette application sont soit payante soit dans une langue différentes du français. C'est pourquoi nous créons une application gratuite et collaborative.

## Architecture technique
Notre application est une application mobile developpé avec le moteur de jeu [Godot Game Engine](https://godotengine.org).
Nous utilisons des fichiers *JSON* pour le stockage de nos données en local.  
Voici un exemple d'architecture pour une application Godot.  
![](https://github.com/WriteInGesturesProject/docs/blob/master/Images/Architecture.png)  

- Les [noeuds](http://docs.godotengine.org/fr/latest/getting_started/step_by_step/scenes_and_nodes.html#nodes) représentent les éléments fondamentaux dans la création de notre jeu. Il est équipé de plusieurs champs modifiable en fonction de son type. Il y a plusieurs type de noeuds : des labels, des boutons, des textures, des lecteurs multimédia etc...  
- Les [scènes](http://docs.godotengine.org/fr/latest/getting_started/step_by_step/scenes_and_nodes.html#scenes) sont des groupes de noeuds et permettent donc de modéliser un écran de jeu.  
- Les [scripts](https://docs.godotengine.org/fr/latest/getting_started/scripting/visual_script/getting_started.html) représentent toute la partie programmation du jeu que l'on va développé. Ce script est souvent rattaché à un noeud d'une scène et permet donc de controler son jeu. Les scripts sont très polyvalent étant donné qu'ils peuvent gérer d'une part la partie fonctionnel de l'application mais aussi la partie graphique de celle-ci.  Le langage de ces scripts est le langage propre a godot : [GDScript](https://docs.godotengine.org/fr/latest/getting_started/scripting/gdscript/gdscript_advanced.html). Godot est aussi capable de gérer le C# et le C++.
- Les données sont toutes les ressources que l'application utilise, il peut s'agir d'images, vidéos, sons, fichiers texte. Nous pouvons aussi remarquer que ces données peuvent être utilisées par les noeuds, mais aussi par les scripts.


## Réalisations techniques
L'application peut se diviser en deux parties. D'une part, nous avons la partie utilisé par l'enfant et d'une autre nous avons la partie consacré au spécialiste.


### La partie du spécialiste
C'est dans cette partie que le spécialiste va pouvoir adapter l'application en fonction des besoins de l'enfant. Il va être possible de créer des exercices basé sur des mots (avec certaines [structures syllabique](https://www.sfu.ca/fren270/phonologie/page4_7.html) ou alors avec un certain nombre de syllabe) extraient d'un dictionnaire inclus dans l'application. Le spécialiste peut aussi créé son propre exercice en y ajoutant les mots qu'il désire avec une image, des homonymes, etc..
Enfin, il est possible d'observé des statistiques par rapport au travail de l'enfant : nombre de réussite d'un exercice, nombre d'essai d'un mot, le mot le plus ou moins réussi, etc... Ces statistiques pourront également être utilisées par des chercheurs.


### La partie de l'enfant
C'est dans cette partie que l'enfant va pouvoir travailler tout en joueant. Pour ce faire il dispose de 3 menus, décrit ci-dessous. 

#### Le menu de jeu
Dans ce menu nous avons trois jeux à lui proposé :
- Le jeu de l'oie
- L'écoute et choisis
- Le jeu du Memory


#### Le menu d'entrainement
Ici l'enfant va pouvoir s'entrainer sur un certain thème :
- Les mots choisi par le spécialiste
- Les jours de la semaine
- Les chiffres
- Les couleurs


#### Le menu d'aide
Ce menu regroupe tous les sons de la langue française avec en plus une vidéo regroupant explication du geste Borel et prononciation du son correspondant.

#### Contact 
artiphonie@gmail.com

