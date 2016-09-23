#!/bin/bash

declare list=$1

mv "$list" "$list.bak"

./filenames.sh < "$list.bak" > "$list"

sed -e 's/.*\///' -e 's/\.pdf$//i' -e 's/_/ /g' < "$list" > titel.txt

basename "$PWD" | while read -r date name; do
  echo Konzert: "$name"
  echo Datum: "$date"
done
