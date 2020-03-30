#!/bin/bash

cd "$(dirname "$0")"
set -e
set -o pipefail
trap 'echo error; read a' ERR

FILE="Na_Kanoheda_Kwiti_Jisdu"

cp "$FILE".tex "$FILE".tex.tmp
perl -p -i -e 's/\\uline\{/\\emph\{/g' "$FILE".tex.tmp
perl -p -i -e 's/\\label\{[^}]*?\}//g' "$FILE".tex.tmp
perl -p -i -e 's/\\begin\{multicols\}.*$//g' "$FILE".tex.tmp
perl -p -i -e 's/\\end\{multicols\}//g' "$FILE".tex.tmp
pandoc -o "$FILE".md.temp --to=commonmark --from=latex "$FILE".tex.tmp

postWeight=$(("$(date +%s)" / 10 * 10))
postDate="$(TZ=UTC date -u --iso-8601=seconds|cut -f 1 -d '+')Z"

(
echo "+++"
echo "draft=true"
echo "date = $postDate"
echo 'title = "$FILE"'
echo "weight = $postWeight"
echo "+++"
echo 
) > "$FILE".md
cat "$FILE".md.temp >> "$FILE".md
rm "$FILE".md.temp

rm "$FILE".tex.tmp
