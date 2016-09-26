#!/bin/bash

printUsage() {
    cat <<EOF
usage: $PROGNAME
EOF
}

readonly PROGNAME=$(basename "$0")
readonly PROGDIR=$(dirname "$(readlink -m "$0")")

# Einstellungen:
readonly SHEET_MUSIC_DIR=~/tmp/Noten/
readonly SEJDA_CONSOLE=$PROGDIR/sejda/bin/sejda-console.bat

# $1: error message
exitWithError() {
    echo "$1" >&2
    exit 1
}

printTitles() {
    sed -e 's/.*\///' -e 's/\.pdf$//i' -e 's/_/ /g'
    # Using PDF meta information:
    # pdftk <filename> dump_data | awk 'p{$1=""; gsub(/^ +/, ""); print; exit}; /^InfoKey: Title$/{p=1}'
}

# $1: file with music titles
printProgram() {
    basename "$PWD" | (
    read -r date name
    echo "$name"
    echo
    LC_ALL=de_DE.utf8 date -d "$date" +'%A, %d.%m.%Y'
    # echo "$date"
    echo
    cat "$1"
    )
}

createLinks() {
    mkdir -p noten
    rm -rf noten/*
    declare counter=1
    while read -r f; do
        declare number
        number=$(printf "%02d" $counter)
        ln -s "$f" noten/"${number}_${f##*/}"
        (( counter++ ))
    done
}

# $1: resulting pdf file name
# $*: single pdf files
createPdf() {
    declare result=$1
    shift
    if pdftk --version &> /dev/null; then
        pdftk "$@" cat output "$result"
    elif "$SEJDA_CONSOLE" --version &> /dev/null; then
        "$SEJDA_CONSOLE" -f "$@" -o "$result"
    else
        echo "Fehler: Die PDF-Datei konnte nicht erstellt werden weil das PDF-Programm nicht richtig installiert ist." >&2
    fi
}

main() {
    (( $# > 0 )) && { printUsage; exit 1; }

    declare list=noten.txt

    mv "$list" "$list.bak"

    "$PROGDIR"/find_pdfs.sh "$SHEET_MUSIC_DIR" < "$list.bak" > "$list"

    (( $? == 0 )) || \
        {
            echo >&2
            exitWithError "Bitte oben angegebene Probleme beseitigen und dann nochmal probieren."
        }

    createLinks < "$list"

    createPdf noten.pdf noten/*

    printTitles < "$list" > titel.txt

    printProgram titel.txt > programm.txt
}

main "$@"
