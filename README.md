# ![](https://github.com/WriteInGesturesProject/dev/blob/master/writeInGesture/assets/logo.png) 

## Reminder of the subject/need and specifications
This project involves the development of a mobile application for use on a tablet for children with language impairment.
It was proposed to us by a speech therapist from the Grenoble University Hospital (Estelle Gillet-Perret).
The aim of this application is to help children work on their pronunciation independently at home through mini-games and the [Borel-Maisonny method](https://fr.wikipedia.org/wiki/M%C3%A9thode_Borel-Maisonny).
This kind of application already exists, unfortunately all the alternatives to this application are either paying or in a language other than French. This is why we are creating a free and collaborative application.

## Technical architecture
Our application is a mobile application developed with the Godot Game Engine (https://godotengine.org).
We use *JSON* files to store our data locally.  
Here is an example of architecture for a Godot application.  
![](https://github.com/WriteInGesturesProject/docs/blob/master/Images/Architecture.png)  

- The [nodes](http://docs.godotengine.org/fr/latest/getting_started/step_by_step/scenes_and_nodes.html#nodes) represent the fundamental elements in the creation of our game. It is equipped with several fields that can be modified according to its type. There are several types of nodes: labels, buttons, textures, media players etc...  
- The [scenes](http://docs.godotengine.org/fr/latest/getting_started/step_by_step/scenes_and_nodes.html#scenes) are groups of nodes and allow to model a game screen.  
- The [scripts](https://docs.godotengine.org/fr/latest/getting_started/scripting/visual_script/getting_started.html) represent the whole programming part of the game we are going to develop. This script is often attached to a node of a scene and thus allows to control its play. Scripts are very versatile since they can manage the functional part of the application as well as the graphical part of the application.  The language of these scripts is godot's own language: [GDScript](https://docs.godotengine.org/fr/latest/getting_started/scripting/gdscript/gdscript_advanced.html). Godot is also able to handle C# and C++.
- Data are all the resources that the application uses, it can be images, videos, sounds, text files. We can also notice that this data can be used by nodes, but also by scripts.


## Technical Achievements
The application can be divided into two parts. On the one hand we have the part used by the child and on the other hand we have the part dedicated to the specialist.


### The specialist part
It is in this part that the specialist will be able to adapt the application according to the needs of the child. It will be possible to create exercises based on words (with certain [syllabic structures](https://www.sfu.ca/fren270/phonologie/page4_7.html) or with a certain number of syllables) extracted from a dictionary included in the application. The specialist can also create his own exercise by adding the words he wants with a picture, homonyms, etc...
Finally, it is possible to observe statistics in relation to the child's work: number of successful completion of an exercise, number of tries of a word, the word more or less successful, etc... These statistics can also be used by researchers.


### The child's part
This is where the child will be able to work while playing. To do this he has 3 menus, described below. 

#### The game menu
In this menu we have three games for him:
- The game of the goose
- Listening and choosing
- The Memory Game


#### The training menu
Here the child will be able to practice on a certain theme:
- The words chosen by the specialist
- Days of the week
- The numbers
- The colors


#### The help menu
This menu gathers all the sounds of the French language with in addition a video explaining the Borel gesture and the pronunciation of the corresponding sound.

#### Contact 
artiphonie@gmail.com

