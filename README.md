# LuckyZ – COBOL Dobbelspel 🎲

* Auteur: Xander Geluykens
* Taal: COBOL
* Beschrijving: LuckyZ is een eenvoudig dobbelspel waarin je credits inzet op even of odd nummers. Het spel houdt je credits bij, bepaalt of je wint of verliest, en slaat elke ronde op in een logbestand.

## Werking
1. Je start met 100 credits.
2. Je kiest een inzet voor de ronde.
3. Je kiest 1 = EVEN of 2 = ODD.
4. Het spel gooit een dobbelsteen (1–12).
5. Je credits worden aangepast op basis van winst of verlies.
6. Resultaten worden getoond én weggeschreven naar een logbestand.
7. Je kunt door blijven spelen of stoppen.
8. Het spel stopt automatisch als je credits op zijn of je kiest te stoppen.

## Logging
Elke ronde wordt opgeslagen in het bestand GAME-LOG met de volgende gegevens:
* Inzet (BET)
* Keuze (EVEN of ODD)
* Dobbelsteenworp (DICE)
* Resterende credits (CREDITS)

Voorbeeldregel:
```shell
BET= 10 CHOICE=EVEN DICE= 4 CREDITS=110
```
## JCL
1. Compileer het programma met jouw COBOL-compiler.
2. Voer het spel uit via JCL, geef SYSIN met:
* inzetbedrag
* keuze (1=EVEN, 2=ODD)
* doorgaan? (Y/N)

Voorbeeld SYSIN:
```shell
0010
1
Y
0010
2
Y
1000
1
N
```
