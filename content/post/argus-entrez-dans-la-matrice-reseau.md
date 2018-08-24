+++
tags = [
  "réseau",
  "argus",
]
date = "2016-12-08T13:42:22+01:00"
title = "Argus: entrez dans la matrice réseau"

+++

Pour commencer, qu'est-ce qu'une matrice réseau ? c'est un document qui
représente les flux réseau qui sont établit au sein de votre réseau (flux
internes) et/ou avec l'extérieur (flux externe).

Sur un réseau, les informations sont échangées sous forme de paquets, c'est ce
que vous pouvez visualiser à l'aide d'un outil comme wireshark par exemple. Mais
lorsque l'on souhaite avoir la vision de ce qui se passe sur le réseau, cette
vue n'est pas pratique, elle est trop précise, pas assez synthétique et lorsque
l'on souhaite mener une analyse ou tout simplement la stocker, les ressources en
termes de temps de calcul ou de stockage deviennent vite conséquent. On va alors
agréger les paquets entre eux afin de former un flux. Et c'est l'ensemble des
flux qui constituent notre matrice.

L'agrégation peut se faire sur plusieurs critères, mais généralement on souhaite
que cela corresponde aux connexions établies à travers le réseau.  Pour cela on
utilise communément le 5-uplets suivant:

 - protocole
 - adresse IP source
 - port source
 - adresse IP destination
 - port destination

Maintenant, à quoi ça sert tout ça ? Eh bien à pas mal de choses. Dès qu'il
s'agit de savoir ce qu'il se passe sur son réseau, en dehors de cas spécifiques
où on a besoin de déboguer au niveau des paquets, on va préférer utiliser la
matrice. Bien sur la matrice n'indique pas les cinq éléments que nous avons
cités, elle va également contenir des métriques comme le nombre de paquets,
la quantité de données échangées, la durée du flux et bien d'autres encore. On
peut donc établir une métrologie, faire l'analyse d'une attaque passée, vérifier
si une personne qui tente de se connecter à votre réseau arrive jusqu'à nous.

C'est bien beau tout ça mais comment on fait une matrice réseau ?  Il existe
plusieurs outils dont les plus connus sont les protocoles netflow et sflow que
l'on retrouve dans la plupart des équipements réseau (routeur, swicth), mais
vous l'aurez compris nous allons parler d'un autre outil :
[argus](http://qosient.com/argus/). A ne pas confondre avec
[argus](http://argus.tcp4me.com/) qui est un outil de monitoring système et
réseau.

Argus peut utiliser des flux sflow ou netflow comme source, mais il peut
également écouter sur une interface réseau à l'aide de la libpcap pour
construire la matrice. Dans ce mode il permet d'acquérir plus de données:

- adresses MAC source et destination
- une partie des données utilisateurs
- calculer les pertes de paquet
- mesure du jitter

L'architecture est basée sur un serveur et un client. Le serveur va lire une
source netflow, sflow ou pcap et générer la matrice argus en mémoire. Cette
matrice peut ensuite être lues par un client qui sera utilisé pour l'archivage
sur disque par exemple ou pour visualiser les flux en temps réel.

