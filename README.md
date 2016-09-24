Konzertprogramm
===============

Ablauf:

 - Ordner für jedes Konzert erzeugen: "2016-09-23 Das Spektakel"
 - In diesen Ordner wechseln
 - Git Bash öffnen
 - Textdatei öffnen und (Teile der) Namen der Stücke reinschreiben -- jedes in eine Zeile.
 - In der Git Bash das Programm ausführen: ../programm_erstellen.sh

Das Skript macht dann folgendes:

 - Textdatei zeilenweise durchgehen und die Dateinamen der Stücke raussuchen
 - Aus den Dateien eine große PDF machen
 - Eine Liste mit den Titeln der Stücke machen
 - Ein Konzertprogramm als PDF speichern

-----------

```
# convert images to pdfs
find . -iname '*.jpg' -or -iname '*.jpeg' | parallel 'convert {} {.}.pdf && mv {} old_image_{/}'

# find pdfs that end with a number (to be merged to one pdf)
find . -iname '*.pdf' | sort | grep -iE '[[:digit:]]\.pdf$' > files-with-number.txt

# merge pdfs with numbers
cat files-with-number.txt | sed -r 's/[-_ ]*[[:digit:]]+\.pdf$//I' | uniq | parallel 'pdftk {}* cat output {}.pdf'

# remove files from files-with-number.txt
```
