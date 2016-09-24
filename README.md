Konzertprogramm
===============

Ablauf:

 - Ordner für ein neues Konzert erzeugen: "2016-09-23 Das Spektakel"
 - In diesen Ordner wechseln
 - Textdatei "noten.txt" erstellen und (Teile der) Namen der Stücke reinschreiben -- jedes in eine Zeile.
 - Git Bash öffnen
 - In der Git Bash das Programm ausführen: ../programm_erstellen.sh

Das Skript macht dann folgendes:

 - Textdatei zeilenweise durchgehen und die Dateinamen der Stücke raussuchen
 - Aus den Dateien eine große PDF erzeugen, die die Stücke in der korrekten Reihenfolge enthält
 - Eine Liste mit den Titeln der Stücke machen
 - Ein Konzertprogramm als Textdatei machen
 - (Ein Konzertprogramm als PDF speichern, wenn ich ein gutes LaTeX Template hätte)

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

Weitere Pläne: Spezieller Ordner mit zwei Batch-Dateien (.bat):

 - `bild-zu-pdf.bat` &ndash; `libreoffice --headless --convert-to pdf *.jpg *.jpeg`
 - `pdfs-zusammenfuehren.bat` &ndash; `sejda-console -f *.pdf -o common-name.pdf`

Die eine wandelt alle Bilder (JPEG) in PDFs um.
Die andere hängt alle PDFs aneinander und macht eine große PDF daraus.
