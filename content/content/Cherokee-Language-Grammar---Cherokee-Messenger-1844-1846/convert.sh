#!/bin/bash

set -e
set -o pipefail

trap 'echo ERROR; sleep 30' ERR

cd "$(dirname "$0")"
BASE="$(pwd)"

FILE="grammar"

outformat="commonmark"

exit 0

cp "$FILE".tex "$FILE".tex.tmp
perl -p -i -e 's/\\uline\{/\\emph\{/g' "$FILE".tex.tmp
perl -p -i -e 's/\\label\{[^}]*?\}//g' "$FILE".tex.tmp
perl -p -i -e 's/\\begin\{multicols\}.*$//g' "$FILE".tex.tmp
perl -p -i -e 's/\\end\{multicols\}//g' "$FILE".tex.tmp

pandoc --eol=lf --wrap=preserve -o index.md.tmp --from=latex --to=$outformat "$FILE".tex.tmp
rm "$FILE".tex.tmp

date="$(ls -l --time-style='+%Y-%m-%dT%H:%M:%SZ' "$FILE".tex|cut -f 6 -d ' ')"
weight="$(ls -l --time-style='+%s' "$FILE".tex|cut -f 6 -d ' ')"
(
cat << EOH
+++
draft=false
date = $date
title = "Cherokee Language Grammar - Cherokee Messenger - 1840-1846"
weight = $weight

[taxonomies]

authors = ["Michael Conrad"]
categories = ["Grammar"]
tags = []

[extra]
+++
EOH
) > index.md

cat index.md.tmp >> index.md
rm index.md.tmp

