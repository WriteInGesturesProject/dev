# Preuve de concept :

## 1/ Application Godot communiquant avec une BDD par l'intermédiare d'une API

### *Outils et logiciels prerequis :*
- une **API en Spring** à l'aide d'Eclipse ou Visual Studio Code
- une **BDD PostgreSql** hebergée en local
- un gestionnaire de BDD PostgreSQL comme **PG Admin**
- un outil de requete HTTP comme **PostMan**
- l'outil de développeur **Godot**
- une plateforme pour analyser les requetes HTTP comme **Requestbin.net**

### *Objectif :*
> L'objectif de cette preuve de concept est de développer une application en Godot permettant de communiquer avec une base de donnée. Pour cela, nous allons utiliser une API developpée en Spring permettant d'effectuer des requetes vers la base de donnée qui sera en PostgreSQL. Au final, nous parviendrons à alimenter la base de donnée par l'application Godot et nous pourrons afficher des données sur notre dernière. Les requetes sont des requetes POST et GET par le protocol HTTP.

### *Information :*
- **PG Admin** permet d'avoir une interface graphique de la BDD
- **PostMan** nous sert pour envoyer des requetes HTTP¨sans passer par Godot pour effectuer des tests sur l'API et la BDD
- **Requestbin.net** permettra d'analyser les entetes des requetes HTTP de Godot et leurs contenues

### *Etapes :*

1. Installer les outils et logiciles necessaires
2. Recuperer le code de l'API developper en Spring sur le Git
3. Recuperer le code de l'application Godot sur le Git qui effectue le rôle d'un formulaire
4. Lancer le serveur PostgreSQL puis PG Admin
5. Lancer l'API à l'aide d'un compilateur JAVA
6. Effectuer des tests vers l'API à l'aide de PostMan afin de s'assurer que votre API est bien liée à la BDD
7. Lancer l'application Godot, remplir le formulaire et regarder le résultat dans la console

**/!\ Important**
* Vérifier que l'API est le champ mot de passe compléter dans ses propriétés pour autoriser l'accès vers la BDD
* Vérifier que les adresses privées/publiques ou localhost qu'ainsi les ports correspondents sur Godot et l'API
