#!/bin/bash

set -e
set -o pipefail

trap "echo ERROR; read a" ERR

for jpg in *.jpg; do
    if [ ! -f "$jpg" ]; then continue; fi
    rm "$jpg"
done

for png in *.png; do
    convert "$png" -background white -alpha remove -alpha off "$(echo "$png"|sed s/.png$/.jpg/g)"
done

exit 0
