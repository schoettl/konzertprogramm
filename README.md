Konzertprogramm
===============

## So wird's gemacht

 - Ordner für ein neues Konzert erzeugen: `2016-09-23 Das Spektakel`
 - In diesen Ordner wechseln
 - Textdatei `noten.txt` erstellen und (Teile der) Namen der Stücke reinschreiben &ndash; jedes in eine Zeile
 - Git Bash öffnen
 - In der Git Bash das Programm ausführen: `../programm_erstellen.sh`

Das Skript macht dann folgendes:

 - Textdatei zeilenweise durchgehen und die Dateinamen der Stücke raussuchen
 - **Aus den Dateien eine große PDF erzeugen**, die die Stücke in der korrekten Reihenfolge enthält
 - Eine Liste mit den Titeln der Stücke machen
 - Einen Ordner mit Verknüpfungen zu den einzelnen Noten anlegen
 - Ein Konzertprogramm als Textdatei machen
 - (Ein Konzertprogramm als PDF speichern, wenn ich ein gutes LaTeX Template hätte)
 - (Eine Konzertprogramm-Vorlage (z.B. LibreOffice, Word) kopieren und evtl. öffnen)

## Der Umwandlungsordner

Es gibt einen speziellen Ordner `Umwandlung` mit zwei Batch-Dateien (`.bat`):

 - Umwandeln von Bildern zu PDFs
 - Zusammenführen von mehreren PDFs zu einer großen

(Noch nicht getestet.)

## Voraussetzungen

 - [Git Bash](https://git-scm.com/downloads) muss installiert sein
 - [Java 1.8](https://www.java.com/de/download/) oder neuer muss installiert sein (ist es wahrscheinlich schon)
 - [Sejda Console](http://www.sejda.org/) muss installiert sein &ndash; wie man das am Besten macht weiß ich noch nicht
 - Statt Java und Sejda Console kann unter Linux auch [pdftk](http://www.lagotzki.de/pdftk/) installiert sein

Für den Umwandlungsordner:

 - [LibreOffice](https://de.libreoffice.org/) muss installiert sein
 - Java und Sejda Console müssen installiert sein

Alle diese Programme sind kostenlos!

## Installation

 - Git Bash unter "Eigene Dateien" öffnen
 - Diesen Befehl eingeben: `git clone git@github.com:schoettl/konzertprogramm.git`
 - Mit diesem Befehl in den neuen Ordner wechseln: `cd konzertprogramm` (der Ordner darf auch umbenannt werden)
 - Mit diesem Befehl Sejda Console installieren: `make install`
 - In diesem neuen Ordner können ab dann wie oben angegeben Ordner für Konzerte erstellt werden

-----------

## Notenarchiv vorbereiten

Vorher müssen aber alle Noten als PDF vorliegen (keine Bilder).
Außerdem darf es pro Stück nur ein PDF geben, d.h. Einzelseiten müssen
zusammengefasst werden.
Das geht mit folgenden Befehlen (unter Linux):

```
# convert images to pdfs
mkdir -p old_images
find . -iname '*.jpg' -or -iname '*.jpeg' -or -iname '*.png' | parallel 'convert -page A4 {} {.}.pdf && mv {} old_images/{/}'

# find pdfs that end with a number (to be merged to one pdf)
find . -iname '*.pdf' | sort | grep -iE '[[:digit:]]\.pdf$' > files-with-number.txt

# merge pdfs with numbers
cat files-with-number.txt | sed -r 's/[-_ ]*[[:digit:]]+\.pdf$//I' | uniq | parallel 'pdftk {}* cat output {}.pdf'

# remove files from files-with-number.txt
```
