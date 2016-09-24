#!/bin/bash

printUsage() {
    cat <<EOF
usage: $PROGNAME <arg>
EOF
}

readonly PROGNAME=$(basename "$0")
readonly PROGDIR=$(dirname "$(readlink -m "$0")")
readonly -a ARGS=("$@")

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

main() {
    declare list=noten.txt

    mv "$list" "$list.bak"

    "$PROGDIR"/filenames.sh < "$list.bak" > "$list"

    printTitles < "$list" > titel.txt

    printProgram titel.txt > programm.txt
}

main "$@"
