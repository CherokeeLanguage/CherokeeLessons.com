#!/bin/bash

set -e
set -o pipefail

trap "echo ERROR; read a" ERR

cd "$(dirname "$0")"

if [ "$1"x = "x" ]; then
    echo "REQUIRES PAGE FILENAME"
    exit -1
fi

export TZ="UTC"
postWeight=$(("$(date +%s)" / 10 * 10))
postDate="$(date -u --iso-8601=seconds|cut -f 1 -d '+')Z"

echo $postWeight
echo $postDate

(
    cat << EOT
+++
draft = true
date = $postDate
title = ""
weight = $postWeight

[taxonomies]
authors = ["Michael Conrad"]
categories = []
tags = []

[extra]

#featured_image = "../static/images/"

+++

<!-- more -->

EOT
) > "$1"