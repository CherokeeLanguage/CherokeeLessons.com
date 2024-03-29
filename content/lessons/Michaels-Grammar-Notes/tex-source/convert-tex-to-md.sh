#!/bin/bash

cd "$(dirname "$0")"
set -e
set -o pipefail
trap 'echo error; read a' ERR

FILE="Michaels-Cherokee-Grammar-Notes"

cp "$FILE".tex "$FILE".tex.tmp
perl -p -i -e 's/\\uline\{/\\emph\{/g' "$FILE".tex.tmp
perl -p -i -e 's/\\label\{[^}]*?\}//g' "$FILE".tex.tmp
perl -p -i -e 's/\\begin\{multicols\}.*$//g' "$FILE".tex.tmp
perl -p -i -e 's/\\end\{multicols\}//g' "$FILE".tex.tmp
perl -p -i -e 's/\\ldots\s/\\ldots\{\} /g' "$FILE".tex.tmp
perl -p -i -e 's/\s\\ldots\{\}/\\ldots\{\}/g' "$FILE".tex.tmp
pandoc -o "$FILE".md.temp --to=commonmark --from=latex "$FILE".tex.tmp
perl -p -i -e 's/ …/…/g' "$FILE".md.temp

(
echo "+++"
echo "draft=true"
echo "date = 2019-03-21"
echo 'title = ""'
echo "weight = 100000"
echo "+++"
echo 
) > "$FILE".md
cat "$FILE".md.temp >> "$FILE".md
rm "$FILE".md.temp

rm "$FILE".tex.tmp
