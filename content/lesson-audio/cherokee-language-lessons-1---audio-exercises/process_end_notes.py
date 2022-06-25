#!/usr/bin/env bash
"""true" '''\'
set -e
eval "$(${CONDA_EXE:-conda} shell.bash hook)"
conda activate cherokee-lessons
exec python "$0" "$@"
exit $?
''"""


def main() -> None:

    shell_md: str = """
+++
draft = false
date = 2022-06-25T22:20:23Z
title = "Cherokee Language Lessons 1 - Audio Exercises"
weight = 1656195620

[taxonomies]
authors = ["Michael Conrad"]
categories = ["Lessons", "Grammar", "Lesson Audio"]
tags = ["TTS", "IMS-Toucan", "Challenge-Response"]

[extra]

featured_image = "lesson-audio/cherokee-language-lessons-1---audio-exercises/Cherokee-Language-Lessons-Volume-1.png"

+++

__above_fold__

<!-- more -->

__below_fold__

"""

    above_fold_md: str = """
## Audio Lessons - About

These audio exercise sessions complement the book 'Cherokee Language Lessons 1',
3rd Edition, by Michael Conrad.

Each set of audio exercises should be completed **before** working through the 
corresponding chapters in the book. The audio will indicate when you should
switch to the book exercises.

When repeating an audio exercise on the same day,
you should wait about an hour between sessions.

Do not and try to cram multiple audio exercises into a single day, you will not
retain the material. The ideal schedule is one exercise repeated at least twice per day.
Do the session in the morning, then repeat the session in the evening.
Others prefer morning, noon, and then evening.

Some people can cram two or more exercises per day without issue.
You should wait an least an hour between such cram sessions.

By the time you complete the audio exercises, you should have
little to no difficulty with reading the Cherokee in the chapter texts.
"""

    below_fold_md: str = """
## Audio Exercises

SESSION|MP3 FILE
--|--
"""
    # cll1-v3-0001.mp3
    with open("end-notes.txt", "r") as r:
        for line in r:
            line = line.strip()
            if ":" not in line:
                continue
            parts = line.split(":")
            number = parts[0]
            if len(number) < 4:
                number = "0" + number
            text = parts[1]
            below_fold_md += f"{number}|"
            below_fold_md += "{{audio (file=\""
            below_fold_md += f"cll1-v3-{number}.mp3\")"
            below_fold_md += "}}\n"
            if text:
                below_fold_md += f"----|{text}\n"
    # below_fold_md += "----|\n"

    index_md: str = shell_md
    index_md = index_md.replace("__above_fold__", above_fold_md)
    index_md = index_md.replace("__below_fold__", below_fold_md)

    with open("index.md", "w") as w:
        w.write(index_md)
        w.write("\n")


if __name__ == '__main__':
    main()

