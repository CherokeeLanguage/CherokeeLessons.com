#!/bin/bash

for x in img-original/*.png; do
  convert -crop +25+110 -crop -25-60 "$x" "img/$(basename $x)"
done
