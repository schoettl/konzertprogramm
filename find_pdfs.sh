#!/bin/bash
# For each line of input find matching file and
# give warning when it is not or multiply found.

printUsage() {
    cat <<EOF
usage: $PROGNAME SHEET_MUSIC_DIR < in-file.txt > out-file.txt
EOF
}

# $1: search term
# $2: temp file with results of find
printOutput() {
    declare searchTerm=$1
    declare tempFile=$2
    declare n errorFlag
    n=$(wc -l < "$tempFile")
    if (( n == 0 )); then
        echo "$searchTerm"
        echo "* nicht gefunden: $searchTerm" >&2
        errorFlag=1
    elif (( n == 1 )); then
        cat "$tempFile"
    else
        echo "$searchTerm"
        echo "* mehrfach gefunden: $searchTerm" >&2
        cat "$tempFile" >&2
        errorFlag=1
    fi

    [[ -z $errorFlag ]]
}

main() {
    (( $# == 1 )) || { printUsage; exit 1; }
    declare sheetMusicDir=$1

    declare errorFlag
    while read -r line; do
        if [[ -f $line ]]; then
            echo "$line"
        else
            declare tempFile
            tempFile=$(mktemp)

            find "$sheetMusicDir" -iregex ".*${line// /.*}.*" -iname '*.pdf' > "$tempFile"

            printOutput "$line" "$tempFile" || errorFlag=1
        fi
    done

    [[ -z $errorFlag ]]
}

main "$@"
