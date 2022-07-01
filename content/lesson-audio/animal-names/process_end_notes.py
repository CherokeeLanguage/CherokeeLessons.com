#!/usr/bin/env bash
"""true" '''\'
set -e
eval "$(${CONDA_EXE:-conda} shell.bash hook)"
conda activate cherokee-lessons
exec python "$0" "$@"
exit $?
''"""
from datetime import datetime
from datetime import timezone


def main() -> None:

    shell_md: str
    with open("index-template.txt", "r") as r:
        shell_md = r.read()

    now = datetime.now(timezone.utc)
    weight: str = str(int(now.timestamp()/60)*60)
    post_date: str = now.isoformat(timespec="seconds").replace("+00:00", "Z")

    shell_md = shell_md.replace("__post_date__", post_date)
    shell_md = shell_md.replace("__weight__", weight)

    above_fold_md: str = """
> Language and culture which are not shared and taught openly and freely will die.
> If our language and culture die, then, as a people, so do we.

These sessions closely follow the vocabulary from the Animals app.

Much the same way that English speakers shorten phrases such as “do not” into “don't”
and “can not” into “can't”,
Cherokee speakers also shorten phrases by dropping certain vowels, syllables,
and words in everyday speech.
Vocabulary will be introduced using the long form of the word or phrase.
Many challenges will be using a mixture of full and short forms.
"""

    below_fold_md: str = """

Try doing one session each day. Three times per day, morning, noon, then evening.

Leave comments below.    
    
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
            below_fold_md += f"animals-{number}.mp3\")"
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

