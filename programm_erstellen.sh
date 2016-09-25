#!/bin/bash

printUsage() {
    cat <<EOF
usage: $PROGNAME
EOF
}

readonly PROGNAME=$(basename "$0")
readonly PROGDIR=$(dirname "$(readlink -m "$0")")

# $1: error message
exitWithError() {
    echo "$1" >&2
    exit 1
}

printTitles() {
    sed -e 's/.*\///' -e 's/\.pdf$//i' -e 's/_/ /g'
}

# $1: file with music titles
printProgram() {
    basename "$PWD" | (
    read -r date name
    echo "$name"
    echo
    LC_ALL=de_DE.utf8 date -d "$date" +'%a, %d.%m.%y'
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
    pdftk "$@" cat output "$result"
    # sejda-console -f "$@" -o "$result"
}

main() {
    (( $# > 0 )) && { printUsage; exit 1; }

    declare list=noten.txt

    mv "$list" "$list.bak"

    "$PROGDIR"/find_pdfs.sh < "$list.bak" > "$list"

    (( $? == 0 )) || \
        exitWithError "\nBitte oben angegebene Probleme beseitigen und dann nochmal probieren."

    createLinks < "$list"

    createPdf noten.pdf noten/*

    printTitles < "$list" > titel.txt

    printProgram titel.txt > programm.txt
}

main "$@"
