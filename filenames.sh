#!/bin/bash
# For each line of input find matching file and
# give warning when it is not or multiply found.

printUsage() {
    cat <<EOF
usage: $PROGNAME < in-file.txt > out-file.txt
EOF
}

readonly SHEET_MUSIC_DIR=~/Dropbox/Noten

# $1: search term
# $2: temp file with results of find
printOutput() {
    declare searchTerm=$1
    declare tempFile=$2
    n=$(wc -l < "$tempFile")
    if (( n == 0 )); then
        echo "$searchTerm"
        echo "* nicht gefunden: $searchTerm" >&2
    elif (( n == 1 )); then
        cat "$tempFile"
    else
        echo "$searchTerm"
        echo "* mehrfach gefunden: $searchTerm" >&2
        cat "$tempFile" >&2
    fi
}

main() {
    (( $# > 0 )) && { printUsage; exit 1; }

    while read -r line; do
        if [[ -f $line ]]; then
            echo "$line"
        else
            declare tempFile n
            tempFile=$(mktemp)

            find "$SHEET_MUSIC_DIR" -iregex ".*/.*${line// /.*}.*\\.pdf" > "$tempFile"

            printOutput "$line" "$tempFile"
        fi
    done
}

main "$@"
