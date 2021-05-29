#!/bin/bash

for x in *.mp3; do
    y="$(echo $x|sed 's/walc-1_2021-..-.._00//g'|sed 's/.mp3//g')"
    id3v2 -a "Michael Conrad" -g 101 -A "We are Learning Cherokee 1" -T "$y/31" -t "WALC 1 [$y]" -y 2021 "$x"
done

