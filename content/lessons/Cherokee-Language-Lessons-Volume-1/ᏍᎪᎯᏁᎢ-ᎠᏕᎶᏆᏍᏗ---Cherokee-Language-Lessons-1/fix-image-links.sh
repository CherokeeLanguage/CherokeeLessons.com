#!/bin/bash

set -e
set -o pipefail
trap 'echo error; read a' ERR

src="${HOME}/Documents/ᏣᎳᎩ/Lessons/Cherokee Language Lessons-Volume 1/"

(grep '!\[image\](' index.md 2> /dev/null || true) | while read image; do
    name="$(echo "$image" | cut -f 2 -d '(' | cut -f 1 -d ')')"
    localname="$(echo "$name"|sed 's|/|-|g'|sed 's| |_|g')"
    dir="$(dirname "$name")"
    echo "- $name"
    if [ ! -d "$dir" ]; then
        mkdir -p "$dir"
    fi
    png="$name".png
    jpg="$name".jpg
    if [ -f "${src}$png" ]; then
        localname="${localname}.png"
        if [ ! -f "${localname}" ]; then
            cp -v "${src}${png}" "${localname}"
        fi
        perl -p -i -e 's|\('$name'\)|\('$localname'\)|g' index.md
        continue
    fi
    if [ -f "${src}$jpg" ]; then
        localname="${localname}.jpg"
        if [ ! -f "${jpg}" ]; then
            cp -v "${src}${jpg}" "${localname}"
        fi
        perl -p -i -e 's|\('$name'\)|\('$localname'\)|g' index.md
        continue
    fi
done

