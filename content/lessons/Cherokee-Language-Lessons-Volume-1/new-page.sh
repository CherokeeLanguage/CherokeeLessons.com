#!/bin/bash

set -e
set -o pipefail

trap "echo ERROR; read a" ERR

cd "$(dirname "$0")"

if [ "$1"x = "x" ]; then
    echo "REQUIRES PAGE SUBTITLE"
    exit -1
fi

subtitle="$1"
title="$subtitle / Cherokee Language Lessons 1"
folder="${title//[^Ꭰ-Ᏼ[:digit:][:alpha:]]/-}"

echo $title
echo $folder

if [ -d "$folder" ]; then
    echo "FOLDER ALREADY EXISTS!"
    exit -1
fi

mkdir "$folder"

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
title = "$subtitle"
weight = $postWeight

[taxonomies]
authors = ["Michael Conrad"]
categories = ["Lessons", "Grammar"]
tags = []

[extra]
zulma_title="Cherokee Language Lessons 1"
featured_image = "lessons/Cherokee-Language-Lessons-Volume-1/Cherokee-Language-Lessons-Volume-1.png"

+++

<!-- more -->

EOT
) > "$folder/index.md"