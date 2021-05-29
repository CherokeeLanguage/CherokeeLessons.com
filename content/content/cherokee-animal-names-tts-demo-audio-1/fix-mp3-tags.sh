#!/bin/bash

for x in *.mp3; do
    y="$(echo $x|sed 's/Animals_2021-..-.._00//g'|sed 's/.mp3//g')"
    id3v2 -a "Michael Conrad" -g 101 -A "Animals [2021-05-29]" -T "$y/12" -t "Animals [$y]" -y 2021 "$x"
done

