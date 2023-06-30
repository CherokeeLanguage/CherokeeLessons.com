#!/usr/bin/env bash
"""true" '''\'
set -e
eval "$(conda shell.bash hook)"
conda deactivate
conda activate cherokee-lessons
exec python "$0" "$@"
exit $?
''"""
import textwrap


def main() -> None:
    import argparse
    import pathlib
    from datetime import datetime
    import re
    import os

    parser = argparse.ArgumentParser(prog="new_page",
                                     description="Create template index.md in a new folder for editing then publishing via Zola")
    parser.add_argument("--title", type=str, required=True,  #
                        help="The title of the new page. Also determines folder name.")
    parser.add_argument("--folder", type=pathlib.Path, required=True,  #
                        help="The parent folder for the new page.")
    args: argparse.Namespace = parser.parse_args()

    utcnow = datetime.utcnow()

    title: str = args.title.strip()
    folder: pathlib.Path = pathlib.Path(args.folder)
    sub_folder_name = utcnow.isoformat()[:10] + "_" + re.sub(  #
            "--+", "-", re.sub("[^\\wᎠ-Ᏼ]", "-", title).strip("-")).lower()

    sub_folder: pathlib.Path = folder.joinpath(sub_folder_name)

    post_date: str = utcnow.isoformat(timespec="seconds") + "Z"
    post_weight: int = int(utcnow.strftime("%s")) // 10 * 10

    print(f"""
    Folder: {sub_folder_name}
    Title: "{title}"
    Post weight: {post_weight}
    Post date: {post_date}    
    """)

    index_md = textwrap.dedent(f"""
    +++
    
    draft = true
    date = {post_date}
    title = "{title}"
    weight = {post_weight}
    
    [taxonomies]
    authors = ["Michael Conrad"]
    categories = []
    tags = []
    
    [extra]
    # featured_image = "{folder}/{sub_folder_name}/img.png"

    +++
    
    <!-- more -->        
    """).strip() + "\n\n"

    sub_folder.mkdir(exist_ok=True)
    index_md_file = sub_folder.joinpath("index.md")
    if index_md_file.exists():
        raise RuntimeError(f"File {index_md_file.resolve()} already exists.")

    with sub_folder.joinpath("index.md") as w:
        w.write_text(index_md)

    os.system(f"xdg-open {index_md_file.resolve()}")


if __name__ == '__main__':
    main()
