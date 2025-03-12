# **TSSR_PARIS_0924_P2_G5**

# Objectif principal :

- Depuis une machine Windows Server, on exécute un script PowerShell qui cible des ordinateurs Windows
- Depuis une machine Debian, on exécute un script shell qui cible des ordinateurs Ubuntu

  
# Objectif secondaire :

- Depuis un serveur, cibler une machine cliente avec un type d’OS différent

## Membre de l'organisation de l'équipe 
|Semaine     | Yagui YOLOU| Jessy FREMOR| 
|:----------:|:-----------:|:---------------:|
|Semaine 1   |Scrum Master |Product Owner    |
|Role        |Installation et configuration réseau VirtuelBox Windows 10,Windows Server 2022 et création branche principale|Installation et configuration VirtuelBox Debian 12,Ubuntu 22.04/24.04 et création branche Github| 
 |Semaine 2   |Product Owner |Scrum Master     |
|Role         |Création des menus bash Comptes utilisateurs,Groupes,Commandes d'alimentation et Mise à jour du système|Création des menus bash Gestion des répertoires,Prise en main à distance,Gestion de pare-feu et Gestion de logiciel| 
|Semaine 3    |Scrum Master |Product Owner  |
|Role         |Création des menus powershell Comptes utilisateurs,Groupes,Commandes d'alimentation,Mise à jour du système et création des fichiers logs Powershell|Création des menus Powershell Gestion des répertoires,Prise en main à distance,Gestion de pare-feu,Gestion de logiciel et création des fichiers logs Bash|          
Semaine 4     |Product Owner|Scrum Master    |
|Role         |Finalisation de la documentation et test du menu scripts a distance|Finalisation de la documentation et test du menu scripts a distance| 

## Prérequis 

## Installation des serveurs :
 
* **Windows Server 2022** 
* Nom : SRVWIN10 
* Compte : Administrateur
* Mot de passe : Azerty1*
* Adresse IP fixe : 172.16.10.5/24
--------------------------------------
* **Debian 12** 
* Nom : SRVLX01£
* Compte : root 
* Mot de passe : Azerty1*
* Adresse IP fixe : 172.16.10.10/24


## Installation des clients : 
* **Windows 10** 
* Nom : CLIWIN01
* Compte : wilder 
* Mot de passe : Azerty1*
* Accès avec une adresse IP SSH 
* Adresse IP fixe : 172.16.10.20/24
----------------------------------------
* **Ubuntu 22.04/24.04 LTS**
* Nom : wilder 
* Compte : CLILIN01
* Mot de passe : Azerty1*
* Accès avec une adresse IP SSH 
* Adresse IP fixe : 172.16.10.30/24

## Outils :
* Bash 
* Powershell 
* VisualCode 

## Etape du projet :

1. Installation et configuation de l'environnment 

2. Connexion des adresses IP via SSH et WINRM

3. Création de Script Bash et PowerShell 

4. Vérification finale de la mise en configuration 

5. Test en locale et à distance 

## Choix Technique 
Pour la création de ce projet nous avons décidés via deux scripts. 1 scripts Bash et 1 script Powershell. Le but de ce projet est de pouvoir utiliser les fonctions d'un ordinateurs a distance via un script et pour cela nous avons utilisé deux systèmes d'exploitations Linux et Windows. 

## Difficultés rencontrés
|Diffucltés rencontrés|Solutions|
|:---------------------:|:----------:| 
|Connexion SSH à distance Création de fichier Log| Mettre des variables qui permet dans les scripts qui permet d'exécuter a distance le menu et pour les fichiers mettre des variables qui permet la création des fichiers|
|Connexion WinRM| Utiliser les commandes exactes pour exécuter les commandes a distances Mettre le réseau en privé au lieu du Public et faire la configuration WinRM du server et du client|

## Conclusion
Ce projet a pour but de montrer qu'à travers l'éxécution d'un script a distance nous pouvons utilisé la machine distante et utilisé ses commandes et tous cela à travers un script qui est correctement écrit. 

