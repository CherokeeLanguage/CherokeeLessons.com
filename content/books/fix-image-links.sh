#!/bin/bash

set -e
set -o pipefail
trap 'echo error; read a' ERR

cd "$(dirname "$0")"

src="${HOME}/Documents/ᏣᎳᎩ/Lessons/Cherokee Language Lessons-Volume 1/"

(grep '!\[image\](' index.md 2> /dev/null || true) | while read line; do
    line="$(echo "$line"|perl -p -e 's|!\[image\]\((.*?)\)|$1|g')"
    while [ "${line}x" != "x" ]; do
        name="$(echo "$line "|cut -f 1 -d ' ')"
        line="$(echo "$line "|cut -f 2 -d ' ')"
        localname="$(echo "$name"|sed 's|/|-|g'|sed 's| |_|g')"
        echo "- $name"
        png="$name".png
        jpg="$name".jpg
        if [ -f "${src}$png" ]; then
            localname="${localname}.png"
            if [ ! -f "${localname}" ]; then
                cp -v "${src}${png}" "${localname}"
                mogrify -resize 1024x -strip "${localname}"
            fi
            perl -p -i -e 's|\('$name'\)|\('$localname'\)|g' index.md
            continue
        fi
        if [ -f "${src}$jpg" ]; then
            localname="${localname}.jpg"
            if [ ! -f "${jpg}" ]; then
                cp -v "${src}${jpg}" "${localname}"
                mogrify -resize 1024x -strip "${localname}"
            fi
            perl -p -i -e 's|\('$name'\)|\('$localname'\)|g' index.md
            continue
        fi
    done
done

