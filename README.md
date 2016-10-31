Proefsleuven
============

Dit is een Git repository voor het onderzoeksproject Archeologisch vooronderzoek met proefsleuven: op zoek naar een optimale strategie.

Installatie
-----------

Download of clone repository (best onder de d:\):

```
git clone git@github.com:OnroerendErfgoed/proefsleuven.git
```

of over https (op vonet wordt ssh geblokkeerd):

```
https://github.com/OnroerendErfgoed/proefsleuven.git
```

Voeg vervolgens het bestand python\proefsleufsimmulaties.py toe aan ArcGIS (volgens handleiding doc/handleiding_v1.1.pdf).

Plaats ten slotte een snelkoppeling op het bureablad die het volgende commando uitvoert:

```
C:\Python27\ArcGIS10.1\python.exe D:\proefsleuven\python\run_batch.py -i "D:\SIMULATIES PROEFSLEUVEN\batch_input\simbatch.csv" -o "d:\SIMULATIES PROEFSLEUVEN\batch_resultaten"
```

Het bestand simbatch.csv moet hiervoor aanwezig zijn. Een voorbeeld kan je vinden onder handleiding/simbatch.csv
