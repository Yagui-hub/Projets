# Guide Utilisateur : Test de robustesse de mot de passe avec John the Ripper

## Sommaire
1. [Introduction](#introduction)
2. [Installation et Configuration](#installation-et-configuration)
   - [Prérequis](#prérequis)
   - [Vérification de l'accès à l'application John the Ripper](#verification-de-lacces-a-lapplication-john-the-ripper)
   - [Vérification de l'accès à la wordlist](#Verification-de-lacces-a-la-wordlist)
   - [Configuration initiale](#configuration-initiale)
3. [Utilisation de Base](#utilisation-de-base)
   - [Géneration du fichier de hash](#Generation-du-fichier-de-hash)
   - [Lancement de l'attaque par dictionnaire avec John the ripper](#lancement-de-lattaque-par-dictionnaire-avec-john-the-ripper)
   - [Vérification des résultats](#verification-des-resultats)
   - [Test du mot de passe trouvé par John the Ripper](#test-du-mot-de-passe-trouve-par-john-the-ripper)
4. [Utilisation Avancée](#utilisation-avancée)
   - [Options de ligne de commande avancées](#options-de-ligne-de-commande-avancées)
   - [Techniques d’optimisation](#techniques-doptimisation)
5. [FAQ (Questions Fréquemment Posées)](#faq-questions-fréquemment-posées)
6. [Conclusion](#conclusion)
7. [Ressources supplémentaires](#ressources-supplementaires)

## Introduction
John the Ripper est un outil conçu pour tester la robustesse des mots de passe en simulant des attaques par dictionnaire et par force brute. Ce guide a pour but de sensibiliser les collaborateurs à l'importance de choisir des mots de passe forts et de les changer régulièrement.

## Installation et Configuration

### Prérequis
- Système d'exploitation : Ubuntu 22.04/24.04 LTS
- Accès au terminal
- Accès au dossier partagé
- Disposer de john the ripper
- Disposer d'une wordlist qui correspondra au "dictionnaire" utilisé lors de *l'attaque par dictionnaire* (Cf. ressource supplémentaire n°2à la fin du document)

### Vérification de l'accès à l'application John the Ripper
1. Ouvrez le terminal.
2. Exécutez la commande suivante :

   ```bash
   john-the-ripper
   ```
   ![Capture d’écran 2024-10-17 101418](https://github.com/user-attachments/assets/66a330d5-24cc-4cfa-8e1e-4e0fe00cbcd3)

### Vérification de l'accès à la wordlist
Notez le chemin d'accès de la wordlist qui sera utilisée pour l'attaque, afin de l'indiquer ultérieurement dans la commande d'attaque.

### Configuration initiale
Aucune configuration supplémentaire n'est requise pour une utilisation de base.

## Utilisation de Base

### Génération du fichier de hash
Commencer par extraire les hash du fichier ZIP crypté :
  - exécutez la commande john-the-ripper suivie de l'extension *.zip2john*
  - notez le nom du fichier à décrypter, dans notre exemple il s'appelera *fichier.zip*
  - dirigez la sortie vers un fichier texte qui sera utilisé dans la commande d'attaque, dans notre exemple il s'appelera *fichier_hash.txt*
    
   ```bash
   john-the-ripper.zip2john fichier.zip > fichier_hash.txt
   ```
La commande *john-the-ripper.zip2john*, sert à extraire les hash des mots de passe d'un fichier ZIP pour les utiliser avec John the Ripper.
Les hash sont des représentations cryptographiques des mots de passe. En extrayant les hash du fichier à décrypter, on obtient les valeurs à "craquer" en utilisant les mots de passe potentiels de la wordlist choisie.

### Lancement de l'attaque par dictionnaire avec John the Ripper
Pour lancer l'attaque par dictionnaire :
  - lancez la commande john-the-ripper
  - indiquez le nom du fichier qui contient les hash du fichier à "craquer", dans notre exemple *fichier_hash.txt*
  - ajoutez l'option *--wordlist* avec le chemin d'accès vers la wordlist choisie (dictionnaire), nommée dans notre exemple _wordlist.txt_)
  - exécutez
     
   ```bash
   john-the-ripper fichier_hash.txt --wordlist=chemin/vers/wordlist.txt
   ```

### Vérification des résultats
Pour vérifier les résultats obtenus par l'attaque, exécutez la commande suivante :

   ```bash
   john-the-ripper --show fichier_hash.txt
   ```

   ```bash
   Session completed. 
   wilder@CLILIN01:~$ john-the-ripper fichier_hash.txt --show
   fichier.zip/fichier_hash.txt:**soleil**:fichier_hash.txt:fichier.zip:fichier.zip
   1 password hash cracked, 0 left
   ```

On peut voir le mot de passe **soleil** s'afficher

Point d'attention : l'efficacité du test d'intrusion dépend en grande partie de la qualité de la wordlist utilisée. En effet, plus une wordlist est riche de nombreux mots, de variantes avec des majuscules et des caractères spéciaux, plus les essais comparatifs de John the Ripper avec les hash du fichier à décrypter pourront s'avérer fructueux pour trouver le mot de passe existant. 

### Test du mot de passe trouvé par John the Ripper
Pour dézipper le fichier et vérifier si le mot de passe trouvé par John the Ripper ouvre bien le fichier crypté, utilisez la commande unzip et indiquez le mot de passe. Si le mot de passe ouvre bien le fichier, c'est que l'opération a réussi.

   ```bash
   unzip nom_du_fichier.zip
   ```
   ![Capture d’écran du 2024-10-18 12-21-31](https://github.com/user-attachments/assets/abff0d95-e9f6-4fe2-8769-e297aaafdc02)

## Utilisation Avancée

### Options de ligne de commande avancées
Pour essayer toutes les combinaisons possibles sans wordlist, il est possible d'avoir recours au mode de **force brute**.
pour cela, exécutez l'une des deux commandes ci dessous :
  
  ```bash
  john-the-ripper fichier_hash.txt 
  ```
   
   ```bash
   john-the-ripper --incremental fichier_hash.txt
   ```
Le mode de **force brute** offre une méthode supplémentaire pour essayer toutes les combinaisons possibles. En effet, la force brute consiste à essayer des millions de noms d’utilisateur et de mots de passe chaque seconde, jusqu’à trouver la bonne combinaison. 
Une attaque par force brute utilise la méthode de l’essai-erreur pour deviner les identifiants, les clés de chiffrement ou pour trouver une page Internet cachée, en examinant toutes les combinaisons possibles dans l’espoir de deviner la bonne.

### Techniques d’optimisation
Pour améliorer l'efficacité des tests, utilisez des options comme `--rules` pour appliquer des transformations sur les mots de passe de la wordlist
L'option --rules permet à John the Ripper d'appliquer automatiquement des transformations sur les mots de ta wordlist (ajout de chiffres, majuscules, caractères spéciaux par exemple).


## FAQ

### Problèmes courants et solutions
**Q : Pourquoi John ne trouve-t-il pas le mot de passe ?**
R : Assurez-vous d'utiliser une wordlist appropriée et que le fichier hash est correctement formaté.

**Q : Comment améliorer la vitesse de craquage ?**
R : Utilisez une machine plus puissante ou optimisez votre wordlist en y intégrant des mots de passe plus probables.

## Conclusion
Pour garantir la sécurité de vos données, choisissez des mots de passe complexes, utilisez des caractères spéciaux, et changez-les régulièrement. La sensibilisation à ces pratiques est cruciale pour éviter les intrusions par différentes méthodes d'attaque. 

## Ressources supplémentaires
1. [Documentation officielle de John the Ripper](https://www.openwall.com/john/)
2. [crunch : générateur de listes de mots](https://technobrice.com/tech/tbg/crunch-wordlist-generator-command-examples/)
3. [Attaques par mot de passe : les 9 types les plus courants et comment les prévenir](https://www.wpade.com/fr/password-attacks.html)

---

