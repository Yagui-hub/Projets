# **Projet de Sécurisation des Mots de Passe**


##  Objectif du projet

Une entreprise A souhaite savoir si les données présentes dans son serveur sont bien protégées. Pour cela nous avons accès au serveur via un dossier partagé qui comprend des fichiers zip chiffré par un mot de passe.
L’objectif de ce projet est de montrer l’importance d’utiliser des mots de passe robustes pour protéger les données sensibles de l’entreprise.
Pour cela nous avons effectuer une attaque par dictionnaire pour tester la robustesse du mot de passe du fichier ZIP à décrypter.

## Membre de l'équipe et organisation
|Semaine     | Yagui Yolou| Alexandra Clery | Elghaia Nait Bouda |
|:----------:|:-----------:|:---------------:|:------------------:|
|Semaine 1   | Scrum Master | Scrum Master | Product Owner |
|Role        |Mise en place de l'environnement Organisation et animations les réunions| Préparation des fichiers ZIP et dictionnaires |Définition des objectifs Préparation de la configuration de l'environnement|
|Semaine 2   | Scrum Master | Product Owner| Scrum Master |
|Role        |Faciliter la documentation final et la gestion des livrables |Définir les priorités du sprint Gérer les tests et les résultats|Faciliter les tâches de configuration et d'analyse|

## Prérequis

### Installation d'un Serveur : 
* Windows Server 2022
* Nom : SRVWIN01
* Compte : Administrator (dans le groupe des admins locaux)
* Mot de passe : Azerty1*
* Adresse IP fixe : 172.16.10.10/24
* Accès à un serveur avec zip installé 
* Un fichier à protéger dans une archive ZIP chiffrée.

### Installation d'une machine Client : 
* Ubuntu 22.04/24.04 LTS
* Nom : CLILIN01
* Compte utilisateur : wilder (dans le groupe sudo)
* Mot de passe : Azerty1*
* Adresse IP fixe : 172.16.10.20/24

### Installation des outils pour trouver le mot de passe

* Installer John the Ripper 
* Télécharger un dictionnaire Rockyou ou Seclist
* Telecharger 7zip

## Étapes du projet

1. Installation et configuration de l'environnement 

2. Création du dossier partagé 

3. Création du fichier ZIP chiffré sur le serveur

4. Connexion au dossier partagé depuis le client

5. Utilisation de John the ripper pour déchiffrer le mot de passe

6. Vérification

## Choix Technique


Dans le cadre de ce projet de sécurisation des mots de passe, nous allons utiliser John the Ripper pour tester la robustesse des mots de passe des fichiers ZIP partagés sur un disque dur externe via une attaque par dictionnaire.

#### Tout d'abord qu'est qu'un ZIP chiffré avec mot de passe ?

Un fichier ZIP est un fichier compressé qui contient plusieurs dossiers ou fichiers pour réduire leur taille et faciliter leur partage.
Il peut être chiffré c'est à dire rendu illisible sans déchifrement.
Un fichier ZIP chiffré avec un mot de passe est un fichier compressé dont le contenu est chiffré mais qui nécessite en plus un mot de passe pour acceder aux fichiers . 
Contrairement au ZIP normal et au ZIP chiffré , le ZIP chiffré avec mot de passe offre une double protection.

#### Pourquoi John the ripper ? 
John the Ripper est un outil puissant concu principalement pour craquer les mots de passe. 
Open-source avec une grande communauté active il est largement utilisé dans le domaine de la sécurité. 
Il est facilement accessible et régulièrement mis a jour pour inclure de nouveaux algorithmes et méthode d'attaque.
Il est également polyvalent et prend en charge de nombreux formats de hash, y compris ceux des fichiers ZIP.
De plus il peut facilement être configuré pour lancer différent type d'attaques.
Son efficacité pour des attaques ciblées le rend particulièrement adapté aux tests de sécurité des mots de passe.

#### Le type d'attaque :
Nous avons fais le choix de faire une attaque par dictionnaire, car elle est basée sur des mots de passe réels provenant de listes communes ou fuites. 
Cette méthode est rapide et réaliste, surtout dans le contexte de mots de passe faibles ou courants.
Contrairement à une attaque brute-force, qui teste toutes les combinaisons possibles et devient rapidement inefficace pour des mots de passe complexes, l’attaque par dictionnaire permet de tester des mots plausibles de manière beaucoup plus rapide.

#### Le choix de l'emplacement du dossier partagé : 
Mettre le dossier partagé sur un disque dur externe présente plusieurs avantages en terme de sécurité.Le stockage externe protege les données en les isolants du réseau principal réduisant ainsi les risques de pertes en cas de défaillance ou d'attaque.
En conservant les fichiers hors lignes nous les rendons moins vulnérables aux cyberattaques.
De plus le disque peut être déconnecté lorsqu'il n'est pas utilisé ce qui limite l'accès aux informations sensibles.
Enfin, ils facilitent la récupération des données en cas de problème sur le réseau, garantissant ainsi une solution rapide et sécurisée.

En réalisant cette attaque, nous simulons donc un type d’attaque réaliste pour identifier les mots de passe faibles, et ainsi améliorer la sécurité de l'environnement. 


## Difficultés rencontrées et Solutions trouvées

  
|**Difficultés rencontrées**|**Solutions trouvées**|
| :- | :- |
|<p>Définition de l'adresse IP fixe sur Ubuntu	</p><p>Sensibilité à la casse et règles strictes de mise en page.	</p><p> Pas de tabulation, uniquement des espaces pour l'indentation.</p>|<p>Utiliser des validateurs en ligne pour le fichier YAML.</p><p></p>|
|Mise en place de dossiers partagés|Double vérification des mises à jours, des configurations d'adresses IP statiques, des paramètres de sécurités, des droits utilisateurs sur les dossiers, les fichiers et les points de montage.|
|L'utilisation de John the ripper : nous avions fais ce choix au vue des éléments cités plus haut néanmoins en pratique il n'est pas si simple d'utilisation. La qualité des résultats dépend fortement des dictionnaires utilisés. John the Ripper prend en charge de nombreux formats de hachage. Savoir quel format utiliser et comment préparer les fichiers correctement necessite une certaine expertise.|L'utilisation de John the ripper à un niveau avancé n'est toujours pas acquises.|
|La virtualisation imbriqué dans Virtual Box : un message d'erreur au lancement de la commande d'attaque de John the ripper peut s'afficher si la virtualisation dans la VM n'est pas activé . Il faut cocher la fonction avancé Activer VT-x /AMD-V-Imbriqué dans Virtual box pour l'activer or elle était grisé donc impossible à modifier.|Le probleme se situe au niveau du setup de la machine hote, il y avait un conflit entre virtualisation de la machine hôte et la vm. Il faut changer les paramètres de sécurité de la machine et désactiver la virtualisation HyperV|





## Conclusion
Ce projet a permis de mettre en évidence l'importance de réaliser des tests d'intrusion réguliers pour identifier les failles de sécurité.
Il a souligné l'importance de choisir des mots de passe complexes qui doivent être changer régulierement et la nécessité de mettre en place une politique de sensibilisation à la sécurité de donnée afin de renforcer de façon pérenne les données de l'entreprise.



_**Recommandations**_ 

* _Etre très minitieux lors des configurations._
* _Gardez à l'esprit que l'opération peut être un échec : tout dépend de la complexité du mot de passe et des performances de votre machine. Plus le mot de passe est robuste, plus il sera difficile de le craquer._* 



