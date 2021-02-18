+++
draft = false
date = 2020-11-05T19:09:17Z
title = "Tacotron2 and Cherokee TTS"
weight = 1604603350

[taxonomies]
authors = ["Michael Conrad"]
categories = []
tags = []

[extra]

featured_image = "content/tacotron2-and-cherokee-tts/04-08.jpg"

+++

I've abandoned trying to use the [espeak-ng](https://github.com/espeak-ng/espeak-ng) speech synthesizer. After spending many weeks working it, it still will not correctly apply stress rules (adding stress to unstressed words) and has other issues I've run into that are very problematic, such as where "d", "g", "n" sound so similar that it is easy to mishear these consonants.

Instead I've switched to using a [Tacotron 2 TTS system](https://github.com/Tomiinek/Multilingual_Text_to_Speech) published by [Tomáš Nekvinda](https://github.com/Tomiinek) for speaking Cherokee. While more work definitely needs done, I think this is a good start, and generally sounds much better than espeak-ng. Samples follow.

<!-- more -->

A very big challenge has been trying to collect together enough MCO annotated Cherokee language audio of a decent quality. I really need 3 or more hours of MCO annotated audio to get better results. These types of TTS systems really need _a lot_ of properly annotated audio to generate acceptable results.

I have also switched to using the "MCO" Modified Community Orthography from the paper [Tone and Accent in Oklahoma Cherokee](https://arts-sciences.buffalo.edu/content/dam/arts-sciences/linguistics/AlumniDissertations/Uchihara%20dissertation.pdf) by Hiroto Uchihara instead of Cherokee-English Dictionary phonetics. I find the newer orthography significantly easier to read for vowel length and tone markings than the historical CED orthography.

The following TTS generated samples include both good and bad examples for the "Two Bragging Hunters" story. The TTS system does not handle punctuation very well and will sometimes take a period to mean stop talking instead of a pause in speech.

Samples:

* Anǐ:táɂli ani:sgaya à:ni:no:halǐ:dô:he, ahwi dù:ni:hyohe.

    {{audio (file="bragging-hunter-cno-spk_0-01.mp3")}}

    {{audio (file="bragging-hunter-cno-spk_3-01.mp3")}}

* Sà:gwű:hno asgaya galò:gwé ga:ne:he sóɂíhnv́ hlā.

    {{audio (file="bragging-hunter-cno-spk_0-02.mp3")}}

    {{audio (file="bragging-hunter-cno-spk_3-02.mp3")}}

* Ná:hnv́ galò:gwé ga:ne̋:hi u:dlv̌:kwsati gè:sé, ale go:hű:sdi yǔ:dv̂:ne̋:la à:dlv̌:kwsgé.

    {{audio (file="bragging-hunter-cno-spk_0-03.mp3")}}

    {{audio (file="bragging-hunter-cno-spk_3-03.mp3")}}

* À:ná:ɂi:sv̋:hnv go:hű:sdi wǔ:ní:go:he do:juwáɂihlv, ná:hnv́ galò:gwé ga:ne̋:hi kilagwu iyv̋:da widǔ:sdáyo:hlé ǒ:sdagwu nǔ:ksestanv̋:na iyú:sdi dà:sdayo:hihv̋.

    {{audio (file="bragging-hunter-cno-spk_0-04.mp3")}}

    {{audio (file="bragging-hunter-cno-spk_3-04.mp3")}}

* U:do:hiyű:hnv́ wǔ:yó:hlé ale ù:ni:go:hé ganv́:gv̋.

    {{audio (file="bragging-hunter-cno-spk_0-05.mp3")}}

    {{audio (file="bragging-hunter-cno-spk_3-05.mp3")}}

* Ná:hnv́ galò:gwé nigǎ:né:hv̋:na "Ahwi è:ni:yó:ɂa!", ù:dv:hne.

    {{audio (file="bragging-hunter-cno-spk_0-06.mp3")}}

    {{audio (file="bragging-hunter-cno-spk_3-06.mp3")}}

* "Ji:yó:ɂê:ga", ù:dv:hne ná galò:gwé ga:ne̋:hi, à:dlv̌:kwsgv́.

    {{audio (file="bragging-hunter-cno-spk_0-07.mp3")}}

    {{audio (file="bragging-hunter-cno-spk_3-07.mp3")}}

* Ù:ná:ne:lǔ:gî:se do:juwáɂihlv́ dí:dla, naɂv̌:hníge̋:hnv wǔ:ní:luhja ù:ni:go:hé sǒ:gwíli gáɂnv̋.

    {{audio (file="bragging-hunter-cno-spk_0-08.mp3")}}

    {{audio (file="bragging-hunter-cno-spk_3-08.mp3")}}

* "Sǒ:gwílílê ì:nada:hísi", ù:dv:hné ná u:yo:hlv̋. "Hada:hísê:gá", à:gò:sě:lé.

    {{audio (file="bragging-hunter-cno-spk_0-09.mp3")}}

    {{audio (file="bragging-hunter-cno-spk_3-09.mp3")}}

