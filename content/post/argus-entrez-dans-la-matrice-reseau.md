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

Pour lancer le serveur argus:
```
argus -d
```

parallèlement on peut lancer un client comme ratop, qui permet d'afficher les
flux en mettant les plus consommateur en premier.
```
ratop -S 127.0.0.1
```

Voici à quoi ressemble la sortie

```
      StartTime      Flgs  Proto      SrcAddr  Sport Dir DstAddr  Dport  TotPkts   TotBytes State
21:46:05.300859  e g         tcp    1.13.33.1.55056   -> 1.0.10.28.http    20638   23377652   CON
21:45:45.441610  *           tcp  100.1.119.1.54435   -> 1.0.10.14.http    17260   22400768   FIN
21:45:44.796263  e d         tcp   100.1.92.1.53479   -> 197.0.3.7.hacl-*  13325   13518824   CON
21:45:32.272255  * s t       tcp   197.0.85.1.44109   -> 1.0.13.3.10229    12686   11539803   CON
21:45:43.389782  * s t       tcp   197.0.85.1.58523   -> 1.0.13.3.10229    11446   10358491   CON
21:45:43.894009  e s         tcp     1.0.13.6.57438   -> 197.0.223.1.ssh   10548    1706046   CON
21:45:42.965458  * s t       tcp   197.0.85.1.61758   -> 1.0.13.3.10229    10505    9498544   CON
21:45:32.520107  * s t       tcp   197.0.85.1.37367   -> 1.0.13.3.10229    10416    9462260   CON
21:45:43.754303  * s t       tcp   197.0.85.1.46850   -> 1.0.13.3.10229     9893    8866591   CON
21:45:45.250917  * s t       tcp    1.8.106.1.45645   -> 1.0.13.18.6595     9169    9323470   CON
21:45:44.225946  * s t       tcp   197.0.85.1.13559   -> 1.0.13.3.10229     8814    7848023   CON
21:45:30.583562  e *         tcp    1.0.111.1.55295   -> 1.0.10.4.http      7462    7286768   CON
21:45:32.227044  e           tcp    1.3.112.1.56150   -> 1.0.2.8.http       6879   12975066   FIN
21:45:53.460738  e d         tcp   1.11.191.1.route*  -> 1.0.11.43.http     5747    5608264   FIN
21:46:15.771788  e dSt       tcp    1.17.74.1.60528   -> 1.0.11.7.http      4972    5760077   CON
21:45:32.801323  e d         tcp    1.4.130.1.44521   -> 197.0.1.1.http     4310    5206092   CON
21:45:32.732753  e d         tcp    1.1.163.1.24049   -> 1.0.13.10.https    3507    3661509   FIN
21:45:52.665569  e d         tcp   100.2.40.1.57428   -> 1.0.2.16.https     3402    3464743   FIN
```

On y retrouve les 5-uplets que nous avons évoqué au début de cet article, protocole, IP source, port source, IP destination,
port destination. On a également la direction du flux le nombre de paquets et le
nombre d'octets échangés, et l'état de la connexion.

```
ARGUS_INTERFACE=any

ARGUS_GO_PROMISCUOUS=yes
ARGUS_GENERATE_RESPONSE_TIME_DATA=yes
ARGUS_GENERATE_PACKET_SIZE=yes
ARGUS_GENERATE_JITTER_DATA=yes
ARGUS_GENERATE_MAC_DATA=yes
ARGUS_GENERATE_APPBYTE_METRIC=yes
ARGUS_GENERATE_TCP_PERF_METRIC=yes
ARGUS_GENERATE_BIDIRECTIONAL_TIMESTAMPS=yes
ARGUS_CAPTURE_DATA_LEN=32
ARGUS_FILTER_OPTIMIZER=yes
```





