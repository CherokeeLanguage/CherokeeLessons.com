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
title="$subtitle"
folder="${subtitle//[^Ꭰ-Ᏼ[:digit:][:alpha:]]/-}"
folder="$(echo "$folder"|tr '[:upper:]' '[:lower:]')"

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
categories = ["Books"]
tags = ["ePub", "Kindle", "Paperback"]

[extra]
zulma_title="Books and eBooks"
#featured_image = "books/$folder/book-cover.jpg"
featured_image = "../../static/images/The-Three-Kittens.jpeg"

+++

...

<!-- more -->

* [*FREE* eBook (pdf) via Direct Download](/pdf-downloads/)
* [Paperback via Lulu](http://www.lulu.com/shop/michael-joyner/)
* [eBook (ePub) via Smashwords](https://www.smashwords.com/books/view/)
* [eBook (Kindle) via Amazon](https://www.amazon.com/dp/)

EOT
) > "$folder/index.md"

cp -v fix-image-links.sh "$folder/"
chmod +x "$folder/fix-image-links.sh"

xdg-open "$folder/index.md"
xdg-open "$folder/fix-image-links.sh"