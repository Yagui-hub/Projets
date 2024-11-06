# Guide Administrateur : Test de robustesse de mot de passe avec John the Ripper

## Sommaire 

1. [Introduction](#introduction)
2. [Préparation de l'environnement](#preparation-de-lenvironnement)
   - [VM Server Windows 2022](#vm-server-windows-2022)
      - [Installation Windows Server 2022](#installation-windows-server-2022)
      - [Création d'un utilisateur Windows](#creation-dun-utilisateur-windows)
      - [Configuration de l'adresse l'IP statique](#configuration-de-ladress-ip-statique)
   - [VM client Ubuntu](#vm-client-ubuntu)
      - [Installation Ubuntu 22.04](#installation-ubuntu-2204)
      - [Configuration de l'adressse IP](#configuration-de-ladresse-ip)
   - [Verification de la connexion entre les deux machines](#verification-de-la-connexion-entre-les-deux-machines)
3. [Telechargement des outils](#telechargement-des-outils)
   - [Installation de john the ripper](#installation-de-john-the-ripper)
   - [Installation 7zip](#installation-7zip)
   - [Téléchargement d'une wordlist](#telechargement-dune-wordlist)
4. [Création du dossier partagé](#creation-du-dossier-partage)
   - [Création dans VM Server Windows 2022](#creation-dans-windows)
   - [Montage dans Ubuntu](#montage-dans-ubuntu)
5. [Test en local](#test-en-local)

## Introduction 

John the Ripper est un outil conçu pour tester la robustesse des mots de passe en simulant des attaques par dictionnaire et par force brute. Ce guide a pour but d'installer l'environnemnt destiné à réaliser une attaque par dictionnaire entre une VM Server 2022 et une VM client sous Ubuntu, en gérant l'accès à un fichier zippé et crypté par le biais d'un dossier partagé.

## Préparation de l'environnement

**Points d'attention :** 
L'installation des mises à jour est très importante pour l'utilisation du terminal Ubuntu et Windows server 2022, sans cela vous ne pourrez l'utilisez.
Required AVX : en cas de problème dans le setup de la machine hote, si conflit entre virtualisation hote et vm, changer les paramètres de sécurité de la machine + désactiver la virtualisation hyperv.

### VM Windows Server

#### Installation Windows Server 2022 
1.	Télécharger l'ISO de Windows Server 2022 : Visitez le site officiel de Microsoft pour obtenir l'image ISO.

2.	Créer une machine virtuelle :

-	Ouvrez votre logiciel de virtualisation.
-	Créez une nouvelle machine virtuelle et sélectionnez l'ISO de Windows Serveur.
-	Configurez la mémoire, le processeur et le stockage selon vos besoins.

3.	Installer Windows Serveur : Suivez les instructions à l'écran pour installer le système d'exploitation.

#### Creation d'un utilisateur Windows

- Depuis Powershell lancer la commande suivante :
   ```powershell
   New-LocalUser -Name "Administrateur" -Password (ConvertTo-SecureString "Azerty1*" -AsPlainText -Force) -FullName "Administrateur" -Description "Compte Administrateur" -PasswordNeverExpires $true -UserCannotChangePassword $true
   ```
   
- Ajouter l'utilisateur au groupe Administrateurs :
  
   ```powershell
   Add-LocalGroupMember -Group "Administrators" -Member "Administrateur"
   ```
   
- Vérifier la création :

   ```powershell
   Get-LocalUser
   ```
#### Configuration de l'adresse l'IP statique

- Lancer la commande suivante pour voir l'addresse ip de la machine et connaitre l’alias de la machine : 
   ```powershell
   Get-NetIPConfiguration
   ``
- Lancer la commande suivante pour configurer l'adresse IP statique en indiquant dans *-IPAddress* la bonne adresse :
   ```powershell
   New-NetIPAddress -InterfaceAlias "Ethernet 2" -IPAddress 172.16.10.10 - PrefixLenth 24
   Set-DnsClientServerAddress -InterfaceAlias "Ethernet 2" -ResetServerAddresses
   ```

### VM client Ubuntu

#### Intallation Ubuntu 22.04

- Intaller la version la plus récente de Ubuntu sur VirtualBox [Ubuntu](https://www.ubuntu-fr.org/download/)
- Suivez les instructions demandés par le système. 
- Crée un compte utilisateur sous le nom "Wilder".

#### Configuration de IP statique

Sur Ubuntu, la configuration réseau utilise Netplan. Le fichier de configuration se trouve généralement dans le dossier /etc/netplan/, il faut donc modifier le fichier de configuration qui se trouve dans ce dossier. 

- Listez toutes les interfaces réseau (par exemple, ens18 ou eth0)

   ```bash
   ip a 
   ```

-  Pour vérifier les fichiers de configuration disponibles.
   ```bash
    ls/etc/netplan
    ```

- Ouvrir le fichier dans un éditeur *(ici le fichier se nomme :50-cloud-init.yaml)* :

   ```bash
   sudo nano /etc/netplan/50-cloud-init.yaml
   ```
**Point d'attention : respectez bien l'intendation attendue dans le script yaml.**

   ```bash
   #This file is generated from information provided by the datasource.  Changes
   #to it will not persist across an instance reboot.  To disable cloud-init's
   #network configuration capabilities, write a file
   #/etc/cloud/cloud.cfg.d/99-disable-network-config.cfg with the following:
   #network: {config: disabled}
   network:
     ethernets:
        enp0s3:
            dhcp4: true
        enp0s8:
            dhcp4: false
            addresses :
              - 172.16.10.20/24  # adresse ip stati
            nameservers :
              addresses :
                - 8.8.8.8  #serveur dns
                - 8.8.4.4
    version: 2
   ```

- Après avoir configuré le fichier, vous devez appliquer les modifications :

   ```bash
   sudo netplan apply
   ```
En relancant la commande *ip a* vous devriez voir l’adresse IP statique que vous avez configurée dans la sortie de cette commande.

### Verification de la connexion entre les deux machines
- Commencer par faire un *ping* sur l'adresse IP du serveur
  
- Installer cette commande qui permettera de connecter les machines en réseaux :
   ```bash
   Sudo apt install openssh-server
   ```

- Lorsque l'installation est terminée, vérifiez que statut du SSH est bien actif :

   ```bash
   Sudo systemctl status ssh
   ```

- Vous pouvez désormais vous connecter de Ubuntu au serveur Windows Server 2022 en utilisant ses commandes suivantes : 

   ```bash
   ssh wilder@172.16.10.20 (nom d’utilisateur@ip de la machine)
   entrez le mot de passe (la machine demandera le mot de passe de l'utilisateur)
   ```


## Téléchargement des outils  

### Installation de John the ripper

- Vérifier que les mises à jours sont effectuées avant d'installer John-The-Ripper : 
    ```bash
   Sudo apt update
   ```
- Installer snapd pour pouvoir installer John-The-Ripper :
   ```bash
   Sudo apt install snapd
   ```
- Installer John-The-Ripper avec la commande suivante :
   ```bash
   Sudo snap install john-the-ripper
   ```
### Installation de 7zip

Pour installer 7-Zip sur un Windows Server en utilisant PowerShell, vous pouvez suivre ces étapes :

- Étape 1 : Téléchargez le fichier d'installation en version 64 bits :
   ```powershell
   	Invoke-WebRequest -Uri "https://www.7-zip.org/a/7z1900-x64.exe" -OutFile "C:\temp\7z1900-x64.exe"
   ```
Assurez-vous que le dossier C:\temp existe, ou modifiez le chemin pour un dossier existant.

- Étape 2 : exécutez le fichier d'installation 7zip :
   ```powershell
   Start-Process -FilePath "C:\temp\7z1900-x64.exe" -ArgumentList "/S" -Wait
   ```
L'option /S permet une installation silencieuse, sans interaction utilisateur.

- Étape 3 : Vérifiez que 7zip soit installé correctement :    
   ```powershell
   Get-Command 7z
   ```

Si 7-Zip est installé, cela affichera le chemin de l'exécutable.

### Téléchargement d'une wordlist

Pour ce test nous avons choisi d'utiliser la liste de mots de passe Rockyou.txt présente dans la liste SecLists. Cette liste contient un nombre important de mots de passe volés et est couramment utilisée par les professionnels de la sécurité informatiques pour réaliser la robustesse des mots de passe.

   ```bash
   git clone htts://github.com/danielmiessler/SecLists.git
   ```

## Création du dossier partagé

### Création dans windows server

Une fois que la configuration de l'adresse IP et l'installation de John-The-Ripper sont effectués sur Ubuntu, vous pouvez créer un dossier de partage selon les étapes suivantes. Par souci de sécurité nous avons choisi de créer le dossier partagé sur le disque dur, ici notre disque s’appelle E.

**Via l'interface graphique**

- Commencer par créer un dossier de partage sur le serveur en tant que utilisateur : 
![creation](https://github.com/user-attachments/assets/b49cc356-bc7b-4c04-8198-167ba33e6ebb)


- Une fois que le dossier de partage crée dans l'utilisateur. Faites clique droit sur le dossier partagé et aller dans "Propriété".
![properties](https://github.com/user-attachments/assets/d270234b-72e0-4da3-8fc5-bd4b17613e3d)


- Puis après avoir cliqué sur 'Propriété' il faut accéder dans l'option "Partage" et dans l'onglet "Sécurité avancé" activé le partage a distance. 
![Capture d'écran 2024-10-18 134145](https://github.com/user-attachments/assets/52439393-73a5-4c48-8ca8-db78f1a66c1e)

- Ensuite aller dans "Sécurité et ajouté l'utilisateur"

![securité](https://github.com/user-attachments/assets/016bdc59-ad08-428d-893f-6dfb2a81b0c1)

**Point d'attention : veillez à cocher "*autoriser les connexions à distance à cet ordinateur*"** 

**Via Powershell**
- Créer le dossier de partage : 
   ```powershell
   New-Item -Path "E:\Dossier_partage" -ItemType Directory

   ```
-  Partager le dossier : 
   ```powershell
    New-SmbShare -Name "Partage" -Path "E:\Dossier_partage" -FullAccess "Admistrateur"**
   ```
- Vérifier que le dossier est bien partagé : 
   ```powershell
  Get-SmbShare**
   ```
- Créer un fichier dans le dossier partagé : 
   ```powershell
   New-Item -Path "E:\Partage\<NomDuFichier>.txt" -ItemType File**
   ```
- Ajouter du contenu
   ```powershell
   Add-Content -Path "E:\Dossier_partage\MonFichier.txt" -Value "Ceci est un exemple de contenu."
   ```
- Activer le bureau à distance : 
   ```powershell
   C > proprieté> parametre d’acces à distance**
   ```

### Donner l'accès au dossier partagé dans Ubuntu

Il convient de réaliser le montage du dossier sur un disque Ubuntu.

- Installer les add-on : 
   ```bash
   Sudo apt install cifs-utils
   ```
  
- Créer un dossier qui servira de point de montage pour le partage : 
   ```bash
   Sudo mkdir /mnt/partage_win
   ```
  
- Donner les droits d'écriture dans le dossier partagé à l'utilisateur pour éviter qu'il n'ait à copier le fichier en local : 
  
   ```bash
   Sudo chmod 744 /mnt/partage_win
   ```
  
- Monter le dossier partagé sur la machine : 
   ```bash
   Sudo mount -t cifs //172.16.10.10/  /mnt/Dossier_partage /mnt/partage_win -o username= « Administrateur », iocharset=utf8
   ```
**Point d'attention : l'option iocharset permet d'éviter les erreurs de conversions entre Windows et Ubuntu**

- Vérifier le montage : 
   ```bash
   df -h | grep /mnt/Towindows
   ```  

## Test local
Pour vérifier que l'installation de l'environnement se soit correctement déroulé et que les étapes du test de robustesse d'un fichier zippé et crypté seront fonctionnelles avec John the Ripper, vous pouvez réaliser un test local selon les étapes suivantes : 

**Zipper un fichier de test dans Ubuntu**

Pour zipper un fichier avec un mot de passe sous Ubuntu, utilisez la ligne de commande avec l'outil zip.
   ```bash
   zip -e nom_du_fichier.zip fichier_a_zipper
   ```
Remplacez nom_du_fichier.zip et fichier_a_zipper par les noms souhaités.
Vous devrez entrer un mot de passe souhaité et le confirmer.

**Lancement John-The-Ripper**

Exécutez les commandes suivantes : 
   ```bash
   John-the-ripper.zip2john test.zip > test.txt
   ```
   ```bash
John-the-ripper –wordlist=/chemin/ test.txt
   ```

**Vérification**

       John-the-ripper –show text.txt
       unzip -p newtest.zip (pour 1 fichier) (c’est l’option p qui permet de l’affichier dans le terminal sinon il extrait le fichier)
       unzip – newtest.zip fichier.txt (pour voir ce qui est dans fichier.txt)

## Conclusion
Nous espérons que ce guide vous a été utile pour l'installation des différentes applications nécessaire à la réalisation du test de robustesse de mot de passe.

En suivant les étapes et les recommandations présentées, vous devriez être capable d'installer votre environnement au mieux pour pouvoir proceder à la phase de réalisation de test.

Merci d'avoir pris le temps de lire ce guide. Nous vous souhaitons beaucoup de succès dans vos futures missions !


