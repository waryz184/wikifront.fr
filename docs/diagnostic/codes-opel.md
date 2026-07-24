# Codes Opel

###  **STRUCTURE DES CODES DÉFAUTS (DTC)**

Les codes sont composés d'une lettre suivie de 4 chiffres. La lettre indique la famille du défaut :

- **P (Powertrain) :** Moteur et transmission.
- **C (Chassis) :** Châssis (ABS, direction, etc.).
- **B (Body) :** Carrosserie (airbags, clim, centralisation).
- **U (Network) :** Réseaux de communication (Bus CAN).

**Type de code :**

- **0 (ex: P0xxx) :** Code standardisé (identique pour toutes les marques).
- **1 (ex: P1xxx) :** Code spécifique au constructeur (Opel).

###  **CODES MOTEUR (SÉRIE P0xxx)**

Ces codes sont subdivisés selon les fonctions suivantes :

- **P01xx et P02xx :** Contrôle du dosage air/carburant.
- *Exemples :* P0100 (Débitmètre), P0110 (Sonde température air), P0115 (Température liquide refroidissement), P0130 (Sonde Lambda).
- **P03xx :** Système d'allumage ou ratés de combustion.
- *Exemples :* P0335 (Capteur vilebrequin), P0340 (Capteur arbre à cames).
- **P04xx :** Contrôle des émissions auxiliaires (EGR, échappement).
- *Exemples :* P0400 (Système EGR), P0420 (Efficacité catalyseur).
- **P05xx :** Contrôle du ralenti moteur et vitesse du véhicule.
- **P06xx :** Ordinateur de bord (Calculateur ECU) et sorties auxiliaires.
- **P07xx, P08xx et P09xx :** Contrôle de la transmission (Boîte de vitesses).

###  **LISTE DES CODES LES PLUS COURANTS (SÉLECTION)**

**Circuit d'air et Carburant :**

- **P0001 :** Commande de régulateur de volume de carburant (ouvert).
- **P0030 :** Sonde Lambda 1 (commande de chauffage défaillante).
- **P0033 :** Électrovanne de décharge du turbocompresseur.
- **P0045 :** Électrovanne de commande de pression de suralimentation (ouvert).
- **P0070 :** Sonde de température extérieure (panne circuit).
- **P0087 :** Pression de la rampe de distribution trop faible.
- **P0089 :** Régulateur de pression de carburant (performance).
- **P0100 :** Débitmètre d'air (panne circuit).
- **P0105 :** Capteur de pression absolue du collecteur (MAP).

**Systèmes de Communication (Série U) :**

- **U0001 :** Bus de données CAN (haute vitesse).
- **U0010 :** Bus de données CAN (vitesse moyenne).
- **U0201 à U0226 :** Perte de communication avec différents boîtiers (portes, sièges, colonne de direction).

**Codes spécifiques Opel (Série P1xxx) :**

- **P1895 :** Mode dégradé (Limp home) - Performance limitée.
- **P1900 :** Capteur de température des gaz d'échappement (non plausible).
- **P1901 :** Capteur de pression du filtre à particules (FAP) - Tension haute/basse ou tuyau défaillant.

###  **CODES DE FIN DE DIAGNOSTIC (ÉTATS)**

Certains codes indiquent le "type" de panne électrique constaté par le calculateur :

- **00 :** Pas d'information.
- **01 :** Court-circuit au plus.
- **02 :** Court-circuit à la masse.
- **04 :** Circuit ouvert.
- **08 :** Signal incorrect.
- **0B :** Signal trop haut.
