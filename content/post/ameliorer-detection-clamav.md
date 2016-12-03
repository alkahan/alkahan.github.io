+++
siteInfo = ""
title = "Améliorer la détection de ClamAV"
draft = false
date = "2016-12-02T16:08:54+01:00"

+++

ClamAV est le seul Antivirus Open Source sur le marché, et l'un des rares qui
fonctionne bien sous Linux.  Il a l'avantage d'être livré en standard avec la
plupart des distributions du marché, et sa mise à jour est simple aussi bien
pour le moteur et pour les règles.

Le moteur de ClamAV fonctionne plutôt bien mais le logiciel peut paraitre en
retrait dans la détection des malwares par rapport à certains acteurs du marché.

Il existe plusieurs méthodes de détection dans les antivirus, mais celle qui est
la plus utilisée et qui obtient les meilleurs résultats est la détection par
signature. Et c'est la base des signatures qui différencie les antivirus entre
eux. Et c'est ce point que je propose d'améliorer.

Voici les informations extraites de la commande clamconf des bases livrées par défaut. 

```
daily.cld: version 22646, sigs: 962997, built on Sat Dec  3 04:29:03 2016
bytecode.cld: version 285, sigs: 57, built on Wed Nov 16 20:41:30 2016
main.cvd: version 57, sigs: 4218790, built on Thu Mar 17 00:17:06 2016 
```

Cela nous fait un total de 962 997 + 57 + 4 218 790 = 5 181 844 signatures.

Pour ma part je complète ces signatures à l'aide du script
[clamav-unofficial-sigs](https://github.com/extremeshok/clamav-unofficial-sigs/)

Voici, une fois installé les inforamtions des bases :

```
Database information
--------------------
Database directory: /var/lib/clamav
[3rd Party] phish.ndb: 26511 sigs
daily.cld: version 22646, sigs: 962997, built on Sat Dec  3 04:29:03 2016
[3rd Party] securiteinfo.hdb: 720513 sigs
[3rd Party] EK_Zerox88.yar: 55 sigs
[3rd Party] winnow_malware.yara: 107 sigs
bytecode.cld: version 285, sigs: 57, built on Wed Nov 16 20:41:30 2016
[3rd Party] bofhland_malware_attach.hdb: 1810 sigs
[3rd Party] EK_Phoenix.yar: 483 sigs
[3rd Party] porcupine.hsb: 658 sigs
[3rd Party] porcupine.ndb: 2980 sigs
[3rd Party] winnow_extended_malware.hdb: 1640 sigs
[3rd Party] EK_BleedingLife.yar: 112 sigs
[3rd Party] winnow.attachments.hdb: 5894 sigs
[3rd Party] winnow_bad_cw.hdb: 1 sig 
[3rd Party] EK_ZeroAcces.yar: 211 sigs
[3rd Party] EK_Fragus.yar: 210 sigs
[3rd Party] sanesecurity.ftm: 170 sigs
[3rd Party] Sanesecurity_sigtest.yara: 54 sigs
[3rd Party] foxhole_generic.cdb: 193 sigs
[3rd Party] crdfam.clamav.hdb: 5000 sigs
[3rd Party] phishtank.ndb: 27528 sigs
[3rd Party] scamnailer.ndb: 47879 sigs
[3rd Party] spamattach.hdb: 12 sigs
[3rd Party] securiteinfopdf.hdb: 586 sigs
[3rd Party] blurl.ndb: 1838 sigs
safebrowsing.cld: version 45303, sigs: 2503013, built on Sat Dec  3 06:50:58 2016
[3rd Party] EK_Sakura.yar: 62 sigs
[3rd Party] bofhland_malware_URL.ndb: 354 sigs
[3rd Party] EK_Zeus.yar: 28 sigs
[3rd Party] Sanesecurity_spam.yara: 46 sigs
main.cvd: version 57, sigs: 4218790, built on Thu Mar 17 00:17:06 2016
[3rd Party] javascript.ndb: 71248 sigs
[3rd Party] EK_Eleonore.yar: 165 sigs
[3rd Party] antidebug_antivm.yar: 1812 sigs
[3rd Party] hackingteam.hsb: 435 sigs
[3rd Party] EK_Angler.yar: 283 sigs
[3rd Party] scam.ndb: 12434 sigs
[3rd Party] EK_Crimepack.yar: 49 sigs
[3rd Party] EK_Blackhole.yar: 453 sigs
[3rd Party] rfxn.ndb: 1918 sigs
[3rd Party] securiteinfohtml.hdb: 194935 sigs
[3rd Party] winnow_malware.hdb: 4229 sigs
[3rd Party] EMAIL_Cryptowall.yar: 52 sigs
[3rd Party] jurlbl.ndb: 6549 sigs
[3rd Party] rfxn.hdb: 8907 sigs
[3rd Party] bofhland_cracked_URL.ndb: 44 sigs
[3rd Party] foxhole_filename.cdb: 869 sigs
[3rd Party] spamimg.hdb: 59 sigs
[3rd Party] rogue.hdb: 3962 sigs
[3rd Party] winnow_malware_links.ndb: 12916 sigs
[3rd Party] junk.ndb: 54614 sigs
[3rd Party] bofhland_phishing_URL.ndb: 162 sigs
[3rd Party] securiteinfoascii.hdb: 56434 sigs
[3rd Party] malwarehash.hsb: 188 sigs
Total number of signatures: 8962509
```

Comme vous l'aurez remarqué, le nombre de signature passe de 5 181 844 à 8 962 509 !

A l'usage j'ai remarqué une meilleure détection des malwares PHP sur les
serveurs ainsi que pour les e-mails.

Notez que dans les bases de signatures que le script gère, certaines nécessitent une
inscription, gratuite ou payante.
