#!/bin/bash

set -e
set -o pipefail

trap "echo ERROR; read a" ERR

cd "$(dirname "$0")"

if [ "$1"x = "x" ]; then
    echo "REQUIRES PAGE TITLE"
    exit -1
fi

title="$1"
folder="${title//[^Ꭰ-Ᏼ[:digit:][:alpha:]]/-}"

echo $title
echo $folder

if [ ! -d "$folder" ]; then
    mkdir "$folder"
fi

postWeight=$(("$(date +%s)" / 10 * 10))
postDate="$(TZ=UTC date -u --iso-8601=seconds|cut -f 1 -d '+')Z"

echo $folder
echo $title
echo $postWeight
echo $postDate

(
    cat << EOT
+++
draft = true
date = $postDate
title = "$title"
weight = $postWeight

[taxonomies]
authors = ["Michael Conrad"]
categories = ["Grammar"]
tags = ["Syllabary", "Dictation"]

[extra]

#featured_image = "lessons/Syllabary-Dictation/$folder/"

+++

<!-- more -->

EOT
) > "$folder/index.md"