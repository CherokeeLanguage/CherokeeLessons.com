+++

draft = false
date = 2023-06-29T20:24:01Z
title = "Cherokee CAT (Computer Aided Translation) Translation Memory and Glossary Files"
weight = 1688084640

[taxonomies]
authors = ["Michael Conrad"]
categories = ["Computer Aided Translation", "OmegaT"]
tags = ["Computer Aided Translation", "Translation Memory", "Glossary File", "Machine Translation"]

[extra]
featured_image = "content/2023-06-29_cherokee-cat-computer-aided-translation-translation-memory-and-glossary-files/coyote-translating-dream-catcher.png"

+++

If you are interested in translating English texts into Cherokee or Cherokee texts into English, you might want to check
out these files. They are called "Translation Memory" and "Glossary" files, and they are designed to work with a
computer program called [OmegaT](https://omegat.org/). In this blog post, I will explain what these files are, how they
can help you with your translations, and how you can use them with [OmegaT](https://omegat.org/).

A Translation Memory (TM) file is a collection of sentences or segments that have been translated before. For example,
if you have a TM file for Cherokee and English, it will contain pairs of sentences in both languages that correspond to
each other. A Glossary file is a list of words or terms that have a specific meaning or usage in a certain context. For
example, if you have a Glossary file for Cherokee and English, it will contain pairs of words in both languages that are
related to a certain topic or field.

<!-- more -->

The main purpose of these files is to help you with your translations by providing you with previous examples and
suggestions. When you use a computer program like [OmegaT](https://omegat.org/), it can search these files and show you
the matches that are relevant to the text that you are translating. This way, you can see how other people have
translated similar texts or words before, and you can reuse or adapt them for your own translation. This can save you
time and effort, and also ensure consistency and accuracy in your translations.

Another benefit of using these files is that they can help you learn more about the Cherokee language and its structure.
By analyzing the matches that OmegaT shows you, you can discover patterns and rules that govern the language, such as
grammar, syntax, morphology, and semantics. You can also compare the differences and similarities between Cherokee and
English, and learn new vocabulary and expressions.

To use these files with [OmegaT](https://omegat.org/), you need to download and install the program on your
computer. [OmegaT](https://omegat.org/) is free and open source, and it works on Windows, macOS, and Linux. You can find
more information about [OmegaT](https://omegat.org/) on its website. Once you have [OmegaT](https://omegat.org/)
installed, you need to create a project folder where you will store your source texts, your translations, and your TM
and Glossary files. You can then import the files that we have provided into your project folder, and start translating
with OmegaT.

You can get [OmegaT](https://omegat.org/) from here [https://omegat.org/](https://omegat.org/).

We hope that these files will be useful for you and that they will inspire you to translate various texts into Cherokee.
I believe that translation is a powerful way to preserve and promote the Cherokee language and culture, and I encourage
you to share your translations with others with a permissive license such as CC-BY. If you have any questions or
feedback about these files or [OmegaT](https://omegat.org/), please feel free to leave a comment below.

## Glossary Files

For OmegaT, after you create your project, these files should be placed in the `glossary` sub-folder.

* [CED Glossary](./glossary/ced-glossary.txt) - Based on the Cherokee English Dictionary.
* [RRD Glossary](./glossary/rrd-glossary.txt) - Based on the Raven Rock Dictionary.
* [Motorola Mobility Glossary](./glossary/motorola-mobility.tbx) - Conversion of a bitext spreadsheet found online.
* [Microsoft Terminology](./glossary/MicrosoftTermCollection.tbx) - Microsoft Technology terms. OBEY THE
  LICENSE! [Microsoft License Agreement](https://www.microsoft.com/en-us/language/LicenseAgreement)

## Translation Memory Files

For OmegaT, after you create your project, these files should be placed in the `tm` sub-folder.

* [CED Example Sentences](./tm/ced.en.utf8.tmx) - Examples sentences from the Cherokee English Dictionary.
* [Foxy Fagan Comic](./tm/foxy-fagan.en.utf8.tmx) - Dialogue from Foxy Fagan as translated by Lawrence Panther.
* [Peter Rabbit](./tm/peter-rabbit.tmx) - The text of Beatrix Potter's "Peter Rabbit" as translated by Lawrence Panther.

### For the Action, Imitation, and Fun Series of grade school primers.

*These are as translated by Michael Conrad, a student of the language, and who is not a first language speaker.*

* [The Little Red Hen](./tm/red-hen-omegat.tmx) - The text for the primer "The Little Red Hen"
* [The Three Pigs](./tm/three-pigs-omegat.tmx) - The story of the "Three Bears" and the "Big Bad Wolf".
* [The Three Bears](./tm/three-bears-omegat.tmx) - The story of "Silver Locks" and the "Three Bears".
* [The Three Little Kittens | Chicken Little](./tm/three-kittens-and-chicken-little-omegat.tmx) - The stories of "The
  Three Kittens and Their Mittens" and "Chicken Little (Henny Penny)"
* [Red Riding Hood | The Seven Kids](./tm/red-riding-hood-seven-kids-omegat.tmx) - The stories of "Red Riding Hood"
  and "The Seven Kids (baby goats)"

## MT Translation Memory Files

* [CED Synthetic](./tm/corpus-synthetic.en.utf8.tmx) - Computer Generated Entries - *Always double check these for
  correctness!*

For OmegaT, after you create your project, these files should be placed in the `tm/mt` sub-folder.

## Notes

The image for this blog post was generated using [Dream Studio](https://dreamstudio.ai/).
