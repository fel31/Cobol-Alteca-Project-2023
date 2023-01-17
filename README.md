# Cobol-Alteca-Project-2023 : CHAINE DE MISE A JOUR DES COMPTES 


## Cadre du projet 


Conception d'un module de chaine de mise à jours des comptes bancaires envoyés par différents organismes financiers. Les tables de la base de données impactées seront :
####
* Table de mise à jour des comptes
* Table historique
* Table des opérations
* Table des devices

Le programme prend en entrée un fichier séquentiel ou un fichier xml.

Si c'est un fichier xml, le programme doit pouvoir le convertir en fichier séquentiel. Le programme doit pouvoir renvoyer le fichier séquentiel en Xml si l'entrée fichier était en XML.
####
* Couche contrôle : a partir du fichier séquentiel, le programme doit contrôler la structure du fichier en fonction des règles de gestion. 
Si tout est ok, la chaine de mise peut commencer : il faudra respecter une architecture 4 tiers dont la couche controle et les autres : 

* Couche applicative : création d'un module qui controle le contenu du fichier en fonction de règles de gestion et commence la mise à jour en appelant un sous-programme le module métier. S'il y a un rejet, un fichier séquentiel 'rejets' est émis et transmis à l'organisme financier. A défaut, le processus continu. 

* Couche métier : implémentation d'un module métier où l'on retrouvera les Algorithme métier de mise à jour. Il appellera au fur et à mesure de son algorithme, les différents accesseurs physiques. 

* Couche physique : elle est composée des accesseurs et de la base de données. 
  * un accesseur doit pouvoir interroger une seule table de la base de données. Il est unique à une table et il est le seul module du programme à pouvoir effectuer des requêtes sur cette table.
  
  
## ETAPES D'IMPLEMENTATIONS DU PROJET 

1. Contrôle de la forme du fichier

3. Cas de Tests de contrôle gestion fichier

4. Création objet DB2

5. Génération des DCLGEN

6. Implémentation des ascesseurs

7. Implémentation du programme de tests des accesseurs 

8. Tests unitaires Accesseurs

9. Implémentation module métier

10. Tests unitaires module métier

12. Implémentation module applicative
 
13. Tests d'intégrations à partir d'un fichier séquentiel. 

14. Convertion du  type flux XML en flux Sequentiel

15. Tests d'intégration à partir d'un fichier XML.

16. livrable
