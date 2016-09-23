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
find . -iname '*.pdf' | sort | perl merge.pl

# convert images to pdfs
find . -iname '*.jpg' -or -iname '*.jpeg' | parallel 'convert {} {.}.pdf && mv {} old_image_{/}'
```
