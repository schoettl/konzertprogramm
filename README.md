Konzertprogramm
===============

Ablauf:

 - Ordner für ein neues Konzert erzeugen: `2016-09-23 Das Spektakel`
 - In diesen Ordner wechseln
 - Textdatei `noten.txt` erstellen und (Teile der) Namen der Stücke reinschreiben &ndash; jedes in eine Zeile
 - Git Bash öffnen
 - In der Git Bash das Programm ausführen: `../programm_erstellen.sh`

Das Skript macht dann folgendes:

 - Textdatei zeilenweise durchgehen und die Dateinamen der Stücke raussuchen
 - Aus den Dateien eine große PDF erzeugen, die die Stücke in der korrekten Reihenfolge enthält
 - Eine Liste mit den Titeln der Stücke machen
 - Einen Ordner mit Verknüpfungen zu den einzelnen Noten anlegen
 - Ein Konzertprogramm als Textdatei machen
 - (Ein Konzertprogramm als PDF speichern, wenn ich ein gutes LaTeX Template hätte)
 - (Eine Konzertprogramm-Vorlage (z.B. LibreOffice, Word) kopieren und evtl. öffnen)

Voraussetzungen:

 - [Git Bash](https://git-scm.com/downloads) muss installiert sein

Installation:

 - Git Bash unter "Eigene Dateien" öffnen
 - Diesen Befehl eingeben: `git clone git@github.com:schoettl/konzertprogramm.git`
 - Mit diesem Befehl in den neuen Ordner wechseln: `cd konzertprogramm` (der Ordner darf umbenannt werden)
 - In diesem neuen Ordner können ab dann wie oben angegeben Ordner für Konzerte erstellt werden

-----------

Vorher müssen aber alle Noten als PDF vorliegen (keine Bilder).
Außerdem darf es pro Stück nur ein PDF geben, d.h. Einzelseiten müssen
zusammengefasst werden.
Das geht mit folgenden Befehlen (unter Linux):

```
# convert images to pdfs
find . -iname '*.jpg' -or -iname '*.jpeg' | parallel 'convert -page A4 -compress A4 {} {.}.pdf && mv {} old_image_{/}'

# find pdfs that end with a number (to be merged to one pdf)
find . -iname '*.pdf' | sort | grep -iE '[[:digit:]]\.pdf$' > files-with-number.txt

# merge pdfs with numbers
cat files-with-number.txt | sed -r 's/[-_ ]*[[:digit:]]+\.pdf$//I' | uniq | parallel 'pdftk {}* cat output {}.pdf'

# remove files from files-with-number.txt
```

----------

Weitere Pläne: Spezieller Ordner `Umwandlung` mit zwei Batch-Dateien (`.bat`):

 - `bild-zu-pdf.bat` &ndash; `libreoffice --headless --convert-to pdf *.jpg *.jpeg`
 - `pdfs-zusammenfuehren.bat` &ndash; `sejda-console -f *.pdf -o common-name.pdf`

Die eine wandelt alle Bilder (JPEG) in PDFs um.
Die andere hängt alle PDFs aneinander und macht eine große PDF daraus.

Noch nicht getestet.

Voraussetzung:

 - [LibreOffice](https://de.libreoffice.org/) muss installiert sein
 - [Java 1.8](https://www.java.com/de/download/) oder neuer muss installiert sein (ist es wahrscheinlich schon)
 - [Sejda Console](http://www.sejda.org/) muss installiert sein &ndash; wie man das am Besten macht weiß ich noch nicht

Alle diese Programme sind kostenlos!
