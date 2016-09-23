#!/bin/bash

while read -r f; do
  if [[ -f $f ]]; then
    echo "$f"
  else
    find . -iregex ".*/.*${f// /.*}.*\\.pdf" > temp.txt
    n=$(wc -l < temp.txt)
    if (( n == 0 )); then
      echo "$f"
      echo "nicht gefunden: $f" >&2
    elif (( n == 1 )); then
      cat temp.txt
    else
      echo "$f"
      echo "mehrfach gefunden: $f" >&2
      cat temp.txt >&2
    fi
  fi
done

