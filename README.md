Proefsleuven
============

Dit is een Git repository voor het onderzoeksproject "Archeologisch vooronderzoek met proefsleuven: op zoek naar een optimale strategie".

Resultaten van dit onderzoek werden gepubliceerd als:
- Haneca K., Debruyne S., Vanhoutte S. & Ervynck A. 2016: Archeologisch vooronderzoek met proefsleuven. Op zoek naar een optimale strategie., Onderzoeksrapport agentschap Onroerend Erfgoed Brussel [online: https://www.vlaanderen.be/nl/publicaties/detail/archeologisch-vooronderzoek-met-proefsleuven-op-zoek-naar-een-optimale-strategie].
- Haneca K., Debruyne S., Vanhoutte S., Ervynck A., Vermeyen M. & Verhagen P. 2017: Simulating trial trenches for archaeological prospection: assessing the variability in intersection rates, Archaeological Prospection 24, p.195–210 [online: https://onlinelibrary.wiley.com/doi/abs/10.1002/arp.1564].

Het originele Python script proefsleufsimulaties.py werd ontwikkeld door Philip Verhagen (Faculty of Humanities, Department of Art and Culture, History, Antiquity, Vrije Universiteit Amsterdam, De Boelelaan 1105, 1081 HV Amsterdam, The Netherlands) in opdracht van het agentschap Onroerend Erfgoed. Nadien werd dit script nog aangevuld en aangepast door medewerkers van het agentschap Onroerend Erfgoed.

Dit scrip mag door derden gebruikt worden voor onderzoek onder de voorwaarden beschreven in de MIT licentie. 

Installatie
-----------

1. Download of clone repository (best onder de d:\):

 ```
 git clone git@github.com:OnroerendErfgoed/proefsleuven.git
 ```

 of over https (op vonet wordt ssh geblokkeerd):

 ```
 https://github.com/OnroerendErfgoed/proefsleuven.git
 ```

2. Voeg vervolgens het bestand python\proefsleufsimmulaties.py toe aan ArcGIS (volgens handleiding doc/handleiding_v1.1.pdf).

3. Plaats ten slotte een snelkoppeling op het bureablad die het volgende commando uitvoert:

 ```
 C:\Python27\ArcGIS10.1\python.exe D:\proefsleuven\python\run_batch.py -i "D:\SIMULATIES PROEFSLEUVEN\batch_input\simbatch.csv" -o  "d:\SIMULATIES PROEFSLEUVEN\batch_resultaten" 
 ```

 Het bestand simbatch.csv moet hiervoor aanwezig zijn. Een voorbeeld kan je vinden onder doc/simbatch.csv
