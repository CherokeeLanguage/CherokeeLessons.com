+++
draft = false
date = 2020-06-11T02:06:21Z
title = "espeak-ng and CED phonetics"
weight = 1591841180

[taxonomies]
authors = ["Michael Conrad"]
categories = ["espeak-ng"]
tags = ["phonetics"]

[extra]

featured_image = "content/espeak-ng-and-ced-phonetics/espeak-ng-android-launcher.png"

+++

(Audio updated 2020-06-10)

I've been working on adding Cherokee support to the [espeak-ng](https://github.com/espeak-ng/espeak-ng) speech synthesizer. While more work definitely needs done, I think this is a good start.

I have chosen to use the Cherokee-English Dictionary phonetics, as this is the only written form that indicates both tone and cadence that is in common use. Hopefully the results will be good enough at a future date to be able to add pronunciations for all the C.E.D. and Raven Rock entries at the [Cherokee Dictionary Project](https://www.cherokeedictionary.net)

I have posted here the [espeak-ng](https://github.com/espeak-ng/espeak-ng) output for 100 of the 1,903 conjugated challenges from the [Bound Pronouns](@/apps/bound-pronouns/index.md) app for review by those interested.

<!-- more -->

I've been pondering the creation of a basic vocabulary training app using the CED entries as the source in combination with the synthetic speech. Your thoughts?

Comments are welcome. Please use the comments box at the bottom of this page.

* Ꭱ³Ꭶ [e³ga](ee3gaa_.mp3): He is going

    {{audio (file="ee3gaa_.mp3")}}

* Ꭱ²Ꮵ [e²ji](ee2jii_.mp3): Mother

    {{audio (file="ee2jii_.mp3")}}

* Ꭴ¹Ꭽ [u¹ha](uu1haa_.mp3): He has a solid object

    {{audio (file="uu1haa_.mp3")}}

* Ꮸ⁴Ꮜ [jv⁴sa](jvv4saa_.mp3): You (1) alone

    {{audio (file="jvv4saa_.mp3")}}

* Ꭿ²Ꭺ¹Ꮹ²Ꮤ [hi²go¹wah²ta](hii2goo1waah2taa_.mp3): Let you (1) see him

    {{audio (file="hii2goo1waah2taa_.mp3")}}

* Ꭸ³Ꭶ [ge³ga](gee3gaa_.mp3): I am going

    {{audio (file="gee3gaa_.mp3")}}

* Ꮪ²Ꭽ [du²ha](duu2haa_.mp3): He has solid objects

    {{audio (file="duu2haa_.mp3")}}

* Ꭾ³Ꭶ [he³ga](hee3gaa_.mp3): You (1) are going

    {{audio (file="hee3gaa_.mp3")}}

* Ꮨ̣²Ꭶ [tị²ga](ti2gaa_.mp3): Let you (1) eat solid foods

    {{audio (file="ti2gaa_.mp3")}}

* Ꭰ¹Ꮛ⁴Ꮜ [a¹gwv⁴sa](aa1gwvv4saa_.mp3): I alone

    {{audio (file="aa1gwvv4saa_.mp3")}}

* Ꮣ̣²Ꭶ² [dạ²ga²](da2gaa2_.mp3): He ate solid foods recently

    {{audio (file="da2gaa2_.mp3")}}

* ᏍᏕ³Ꭶ [sde³ga](sdee3gaa_.mp3): You two are going

    {{audio (file="sdee3gaa_.mp3")}}

* Ꭰ¹Ꮑ³Ꭶ [a¹ne³ga](aa1nee3gaa_.mp3): They are going

    {{audio (file="aa1nee3gaa_.mp3")}}

* ᏍᏉ²Ꮅ¹Ꭶ [sgwo²li¹ga](sgwoo2lii1gaa_.mp3): You (1) recognize me

    {{audio (file="sgwoo2lii1gaa_.mp3")}}

* Ꭲ¹Ꮑ³Ꭶ [i¹ne³ga](ii1nee3gaa_.mp3): You (1) and I are going

    {{audio (file="ii1nee3gaa_.mp3")}}

* Ꭲ¹Ꮥ³Ꭶ [i¹de³ga](ii1dee3gaa_.mp3): All of us are going

    {{audio (file="ii1dee3gaa_.mp3")}}

* Ꭰ¹Ꭺ²Ꮅ¹Ꭶ [a¹go²li¹ga](aa1goo2lii1gaa_.mp3): He is being recognized

    {{audio (file="aa1goo2lii1gaa_.mp3")}}

* Ꭲ¹Ꮴ³Ꭶ [i¹je³ga](ii1jee3gaa_.mp3): You all are going

    {{audio (file="ii1jee3gaa_.mp3")}}

* Ꭳ¹Ꮴ³Ꭶ [o¹je³ga](oo1jee3gaa_.mp3): They and I are going

    {{audio (file="oo1jee3gaa_.mp3")}}

* Ꮣ¹Ꭹ²Ꭽ [da¹gị²ha](daa1gi2haa_.mp3): I have solid objects

    {{audio (file="daa1gi2haa_.mp3")}}

* Ꭳ¹ᏍᏕ³Ꭶ [o²sde³ga](oo2sdee3gaa_.mp3): He and I are going

    {{audio (file="oo2sdee3gaa_.mp3")}}

* Ꮥ²Ꮵ̣²Ꭶ² [de²jị²ga²](dee2ji2gaa2_.mp3): I ate solid foods recently

    {{audio (file="dee2ji2gaa2_.mp3")}}

* Ꭵ¹ᏉᎵ͓²Ꭶ [v¹gwohl²ga](vv1gwoohl2gaa_.mp3): I am being recognized

    {{audio (file="vv1gwoohl2gaa_.mp3")}}

* Ꮽ¹Ꮣ̣²Ꮪ²³Ꮃ [wu¹dạ²du²³la](wuu1da2duu23laa_.mp3): Let him want himself

    {{audio (file="wuu1da2duu23laa_.mp3")}}

* Ꭸ²Ꭺ²Ꮅ¹Ꭶ [ge²go²li¹ga](gee2goo2lii1gaa_.mp3): They are being recognized

    {{audio (file="gee2goo2lii1gaa_.mp3")}}

* Ꭲ¹ᏍᎩ²Ꭺ¹Ꮹ²Ꮤ [i¹sgi²go¹wah²ta](ii1sgii2goo1waah2taa_.mp3): Let you (1) see them and me

    {{audio (file="ii1sgii2goo1waah2taa_.mp3")}}

* Ꮳ̣²Ꮣ̣²Ꮪ²³Ꮃ [jạ²dạ²du²³la](ja2da2duu23laa_.mp3): Let you (1) want yourself

    {{audio (file="ja2da2duu23laa_.mp3")}}

* Ꭽ̣²Ꮣ²Ꭺ¹Ꮹ²Ꮤ [hạ²da²go¹wah²ta](haa_2daa2goo1waah2taa_.mp3): Let you (1) see yourself

    {{audio (file="haa_2daa2goo1waah2taa_.mp3")}}

* Ꭼ²ᏉᎵ͓²Ꭶ [gv²gwohl²ga](gvv2gwoohl2gaa_.mp3): They recognize me

    {{audio (file="gvv2gwoohl2gaa_.mp3")}}

* Ꭼ²Ᏺ²Ꮅ¹Ꭶ [gv²yo²li¹ga](gvv2yoo2lii1gaa_.mp3): I recognize you (1)

    {{audio (file="gvv2yoo2lii1gaa_.mp3")}}

* Ꮵ²Ᏺ²Ꮅ¹Ꭶ [ji²yo²li¹ga](jii2yoo2lii1gaa_.mp3): I recognize him

    {{audio (file="jii2yoo2lii1gaa_.mp3")}}

* ᏍᏓ̣²Ꮣ²Ꭺ¹Ꮹ²Ꮤ [sdạ²da²go¹wah²ta](sdaa_2daa2goo1waah2taa_.mp3): Let you two see yourselves

    {{audio (file="sdaa_2daa2goo1waah2taa_.mp3")}}

* Ꭲ¹Ꭶ̣²Ꮣ̣²Ꮪ²³Ꮃ [i¹gạ²dạ²du²³la](ii1ga2da2duu23laa_.mp3): Let all of us want ourselves

    {{audio (file="ii1ga2da2duu23laa_.mp3")}}

* ᏍᏛ²Ᏺ²Ꮅ¹Ꭶ [sdv²yo²li¹ga](sdvv2yoo2lii1gaa_.mp3): I recognize you two

    {{audio (file="sdvv2yoo2lii1gaa_.mp3")}}

* Ꮹ¹Ꮖ̣²Ꮣ̣²Ꮪ²³Ꮃ [wa¹gwạ²dạ²du²³la](waa1gwaa_2da2duu23laa_.mp3): Let me want myself

    {{audio (file="waa1gwaa_2da2duu23laa_.mp3")}}

* Ꭰ¹Ꮣ²ᏙᎵ͓²Ꭶ [a¹da²dohl²ga](aa1daa2doohl2gaa_.mp3): He recognizes himself

    {{audio (file="aa1daa2doohl2gaa_.mp3")}}

* Ꭲ¹Ꮸ²Ᏺ²Ꮅ¹Ꭶ [i¹jv²yo²li¹ga](ii1jvv2yoo2lii1gaa_.mp3): I recognize you all

    {{audio (file="ii1jvv2yoo2lii1gaa_.mp3")}}

* Ꮶ¹Ꭶ̣²Ꮩ²Ꮅ³ᏍᏗ [jo¹gạ²da²do²hlị³sdi](joo1ga2daa2doo2hli3sdii_.mp3): For them and me to become acquainted with each other

    {{audio (file="joo1ga2daa2doo2hli3sdii_.mp3")}}

* Ꮷ¹Ꮎ̣²Ꮩ²Ꮅ³ᏍᏗ [ju¹nạ²da²do²hlị³sdi](juu1na2daa2doo2hli3sdii_.mp3): For them to become acquainted with each other

    {{audio (file="juu1na2daa2doo2hli3sdii_.mp3")}}

* Ꭲ¹Ꮎ̣²Ꮣ²Ꭺ¹Ꮹ²Ꮤ [i¹nạ²da²go¹wah²ta](ii1na2daa2goo1waah2taa_.mp3): Let you (1) and me see ourselves

    {{audio (file="ii1na2daa2goo1waah2taa_.mp3")}}

* Ꭲ¹Ꮣ̣²Ꮣ²Ꭺ¹Ꮹ²Ꮤ [i¹dạ²da²go¹wah²ta](ii1da2daa2goo1waah2taa_.mp3): Let all of us see ourselves

    {{audio (file="ii1da2daa2goo1waah2taa_.mp3")}}

* Ꮧ̣²Ꭶ̣²Ꮩ²Ꮅ³ᏍᏗ [dị²gạ²da²do²hlị³sdi](di2ga2daa2doo2hli3sdii_.mp3): For all of us to become acquainted with each other

    {{audio (file="di2ga2daa2doo2hli3sdii_.mp3")}}

* Ꭲ¹Ꮳ̣²Ꮣ²Ꭺ¹Ꮹ²Ꮤ [i¹jạ²da²go¹wah²ta](ii1ja2daa2goo1waah2taa_.mp3): Let you all see yourselves

    {{audio (file="ii1ja2daa2goo1waah2taa_.mp3")}}

* Ꮧ̣²Ꮎ̣²ᏙᎵ͓²Ꭹ [dị²nạ²da²dohl²gi](di2na2daa2doohl2gii_.mp3): Let you (1) and me become acquainted with each other

    {{audio (file="di2na2daa2doohl2gii_.mp3")}}

* Ꭶ̣²Ꮣ²ᏙᎵ͓²Ꭶ [gạ²da²dohl²ga](ga2daa2doohl2gaa_.mp3): I recognize myself

    {{audio (file="ga2daa2doohl2gaa_.mp3")}}

* Ꮧ̣²Ꮣ̣²ᏙᎵ͓²Ꭹ [dị²dạ²da²dohl²gi](di2da2daa2doohl2gii_.mp3): Let all of us become acquainted with each other

    {{audio (file="di2da2daa2doohl2gii_.mp3")}}

* Ꮼ¹Ꭶ̣²Ꮣ̣²Ꮪ²³Ꮃ [wo¹gạ²dạ²du²³la](woo1ga2da2duu23laa_.mp3): Let them and me want ourselves

    {{audio (file="woo1ga2da2duu23laa_.mp3")}}

* Ꮧ̣²Ꮳ̣²ᏙᎵ͓²Ꭹ [dị²jạ²da²dohl²gi](di2ja2daa2doohl2gii_.mp3): Let you all become acquainted with each other

    {{audio (file="di2ja2daa2doohl2gii_.mp3")}}

* Ꮽ¹Ꮎ̣²Ꮣ̣²Ꮪ²³Ꮃ [wu¹nạ²dạ²du²³la](wuu1na2da2duu23laa_.mp3): Let them want themselves

    {{audio (file="wuu1na2da2duu23laa_.mp3")}}

* Ꭹ̣²Ꮎ̣²Ꮣ̣²Ꮪ²³Ꮃ [gị²nạ²dạ²du²³la](gi2na2da2duu23laa_.mp3): Let you (1) and me want ourselves

    {{audio (file="gi2na2da2duu23laa_.mp3")}}

* Ꮶ¹Ꭹ̣²Ꮎ̣²Ꮩ²Ꮅ³ᏍᏗ [jo¹gị²nạ²da²do²hlị³sdi](joo1gi2na2daa2doo2hli3sdii_.mp3): For him and me to become acquainted with each other

    {{audio (file="joo1gi2na2daa2doo2hli3sdii_.mp3")}}

* Ꭰ¹Ꮎ̣²Ꮣ²ᏙᎵ͓²Ꭶ [a¹nạ²da²dohl²ga](aa1naa_2daa2doohl2gaa_.mp3): They recognize themselves

    {{audio (file="aa1naa_2daa2doohl2gaa_.mp3")}}

* Ꮧ̣²Ꭹ̣²Ꮎ̣²Ꮩ²Ꮅ³ᏍᏗ [dị²gị²nạ²da²do²hlị³sdi](di2gi2na2daa2doo2hli3sdii_.mp3): For you (1) and me to become acquainted with each other

    {{audio (file="di2gi2na2daa2doo2hli3sdii_.mp3")}}

* Ꭳ¹Ꮳ̣²Ꮣ²ᏙᎵ͓²Ꭶ [o¹jạ²da²dohl²ga](oo1ja2daa2doohl2gaa_.mp3): They and I recognize ourselves

    {{audio (file="oo1ja2daa2doohl2gaa_.mp3")}}

* Ꮣ¹Ꮎ̣²Ꮣ²ᏙᎵ͓²Ꭶ [da¹nạ²da²dohl²ga](daa1naa_2daa2doohl2gaa_.mp3): They are acquainted with each other

    {{audio (file="daa1naa_2daa2doohl2gaa_.mp3")}}

* Ꮧ̣²ᏍᏓ̣²ᏙᎵ͓²Ꭹ [dị²sdạ²da²dohl²gi](di2sdaa_2daa2doohl2gii_.mp3): Let you two become acquainted with each other

    {{audio (file="di2sdaa_2daa2doohl2gii_.mp3")}}

* Ꮩ¹Ꮳ̣²Ꮣ²ᏙᎵ͓²Ꭶ [do¹jạ²da²dohl²ga](doo1ja2daa2doohl2gaa_.mp3): They and I are acquainted with each other

    {{audio (file="doo1ja2daa2doohl2gaa_.mp3")}}

* Ꭳ¹ᏍᏓ̣²Ꮣ²ᏙᎵ͓²Ꭶ [o¹sdạ²da²dohl²ga](oo1sda2daa2doohl2gaa_.mp3): He and I recognize ourselves

    {{audio (file="oo1sda2daa2doohl2gaa_.mp3")}}

* Ꮩ¹ᏍᏓ̣²Ꮣ²ᏙᎵ͓²Ꭶ [do¹sdạ²da²dohl²ga](doo1sda2daa2doohl2gaa_.mp3): He and I are acquainted with each other

    {{audio (file="doo1sda2daa2doohl2gaa_.mp3")}}

* Ꮼ¹Ꭹ̣²Ꮎ̣²Ꮣ̣²Ꮪ²³Ꮃ [wo¹gị²nạ²dạ²du²³la](woo1gi2na2da2duu23laa_.mp3): Let him and me want ourselves

    {{audio (file="woo1gi2na2da2duu23laa_.mp3")}}

* Ꭴ²Ꮵ [u²ji](uu2jii_.mp3): His mother

    {{audio (file="uu2jii_.mp3")}}

* Ꭾ¹Ꮎ [he¹na](hee1naa_.mp3): Let you (1) go

    {{audio (file="hee1naa_.mp3")}}

* Ꭴ¹Ꮀ³Ꭲ [u¹ho³ɂi](uu1hoo3-ii_.mp3): He often has a solid object

    {{audio (file="uu1hoo3-ii_.mp3")}}

* Ꭸ¹Ꮎ² [ge¹na²](gee1naa2_.mp3): I went recently

    {{audio (file="gee1naa2_.mp3")}}

* Ꮺ¹Ꮎ [we¹na](wee1naa_.mp3): Let him go

    {{audio (file="wee1naa_.mp3")}}

* Ꮪ²Ꮀ³Ꭲ [du²ho³ɂi](duu2hoo3-ii_.mp3): He often has solid objects

    {{audio (file="duu2hoo3-ii_.mp3")}}

* Ꭼ²Ꭺ²Ꮂ²³Ꭲ [gv²go²hv²³ɂi](gvv2goo2hvv23-ii_.mp3): I saw you (1) a while ago

    {{audio (file="gvv2goo2hvv23-ii_.mp3")}}

* ᏍᏉ²Ꮅ¹Ꭹ [sgwo²li¹gi](sgwoo2lii1gii_.mp3): Let you (1) recognize me

    {{audio (file="sgwoo2lii1gii_.mp3")}}

* ᏍᏕ¹Ꮎ [sde¹na](sdee1naa_.mp3): Let you two go

    {{audio (file="sdee1naa_.mp3")}}

* Ꭲ¹Ꮑ¹Ꮎ [i¹ne¹na](ii1nee1naa_.mp3): Let you (1) and me go

    {{audio (file="ii1nee1naa_.mp3")}}

* Ꮣ̣²Ꭹ̣³Ꭰ [dạ²gị³ɂa](da2gi3-aa_.mp3): He is eating solid foods

    {{audio (file="da2gi3-aa_.mp3")}}

* Ꭲ¹Ꭹ²Ꭽ [i¹gi²ha](ii1gii2haa_.mp3): All of us have a solid object

    {{audio (file="ii1gii2haa_.mp3")}}

* Ꭲ¹Ꮥ¹Ꮎ [i¹de¹na](ii1dee1naa_.mp3): Let all of us go

    {{audio (file="ii1dee1naa_.mp3")}}

* Ꮵ²Ꭺ²Ꮂ²³Ꭲ [ji²go²hv²³ɂi](jii2goo2hvv23-ii_.mp3): I saw him a while ago

    {{audio (file="jii2goo2hvv23-ii_.mp3")}}

* Ꭲ¹Ꮴ¹Ꮎ [i¹je¹na](ii1jee1naa_.mp3): Let you all go

    {{audio (file="ii1jee1naa_.mp3")}}

* Ꭳ¹Ꭹ²Ꭽ [o¹gi²ha](oo1gii2haa_.mp3): They and I have a solid object

    {{audio (file="oo1gii2haa_.mp3")}}

* Ꭴ¹Ꮒ²Ꭽ [u¹ni²ha](uu1nii2haa_.mp3): They have a solid object

    {{audio (file="uu1nii2haa_.mp3")}}

* Ꮣ¹Ꭹ²Ꮀ³Ꭲ [da¹gị²ho³ɂi](daa1gi2hoo3-ii_.mp3): I often have solid objects

    {{audio (file="daa1gi2hoo3-ii_.mp3")}}

* Ꮥ³Ꭹ²Ꭽ [de³gi²ha](dee3gii2haa_.mp3): All of us have solid objects

    {{audio (file="dee3gii2haa_.mp3")}}

* Ꭱ¹Ꭺ²Ꮅ¹Ꭶ [e¹go²li¹ga](ee1goo2lii1gaa_.mp3): All of us are being recognized

    {{audio (file="ee1goo2lii1gaa_.mp3")}}

* Ꮣ¹Ꮒ²Ꭶ² [da¹ni²ga²](daa1nii2gaa2_.mp3): They ate solid foods recently

    {{audio (file="daa1nii2gaa2_.mp3")}}

* Ꮩ¹Ꭹ²Ꭽ [do¹gi²ha](doo1gii2haa_.mp3): They and I have solid objects

    {{audio (file="doo1gii2haa_.mp3")}}

* Ꭱ¹Ꮓ²Ꮅ¹Ꭶ [e¹no²li¹ga](ee1noo2lii1gaa_.mp3): You (1) and I recognize him

    {{audio (file="ee1noo2lii1gaa_.mp3")}}

* Ꮩ¹Ꮵ²Ꭶ² [do¹ji²ga²](doo1jii2gaa2_.mp3): They and I ate solid foods recently

    {{audio (file="doo1jii2gaa2_.mp3")}}

* Ꮪ¹Ꮒ²Ꭽ [du¹ni²ha](duu1nii2haa_.mp3): They have solid objects

    {{audio (file="duu1nii2haa_.mp3")}}

* Ꭱ¹Ꮩ²Ꮅ¹Ꭶ [e¹do²li¹ga](ee1doo2lii1gaa_.mp3): All of us recognize him

    {{audio (file="ee1doo2lii1gaa_.mp3")}}

* Ꭰ¹Ꭹ̣²Ꭽ [a¹gị²ha](aa1gi2haa_.mp3): I have a solid object

    {{audio (file="aa1gi2haa_.mp3")}}

* Ꭱ¹Ꮶ²Ꮅ¹Ꭶ [e¹jo²li¹ga](ee1joo2lii1gaa_.mp3): You all recognize him

    {{audio (file="ee1joo2lii1gaa_.mp3")}}

* Ꭹ̣²Ꮒ²Ꭽ [gị²ni²ha](gi2nii2haa_.mp3): You (1) and I have a solid object

    {{audio (file="gi2nii2haa_.mp3")}}

* Ꭱ¹ᏦᎵ͓²Ꭶ [e¹johl²ga](ee1joohl2gaa_.mp3): You (1) are being recognized

    {{audio (file="ee1joohl2gaa_.mp3")}}

* Ꮥ²ᏍᏗ²Ꭽ [de²sdi²ha](dee2sdii2haa_.mp3): You two have solid objects

    {{audio (file="dee2sdii2haa_.mp3")}}

* Ꮥ²Ꮳ̣²Ꭽ [de²jạ²ha](dee2ja2haa_.mp3): You (1) have solid objects

    {{audio (file="dee2ja2haa_.mp3")}}

* Ꮥ²Ꮵ̣²Ꭹ̣³Ꭰ [de²jị²gị³ɂa](dee2ji2gi3-aa_.mp3): I am eating solid foods

    {{audio (file="dee2ji2gi3-aa_.mp3")}}

* Ꮹ¹Ꭺ²Ꮅ¹Ꭹ [wa¹go²li¹gi](waa1goo2lii1gii_.mp3): Let him be recognized

    {{audio (file="waa1goo2lii1gii_.mp3")}}

* Ꮹ¹Ꮣ²Ꭺ¹Ꮹ²Ꮤ [wa¹da²go¹wah²ta](waa1daa2goo1waah2taa_.mp3): Let him see himself

    {{audio (file="waa1daa2goo1waah2taa_.mp3")}}

* Ꮥ³Ꮒ̣²Ꭶ² [de³ni²ga²](dee3nii2gaa2_.mp3): You (1) and I ate solid foods recently

    {{audio (file="dee3nii2gaa2_.mp3")}}

* Ꮥ³Ꮵ̣²Ꭽ [de³ji²ha](dee3jii2haa_.mp3): You all have solid objects

    {{audio (file="dee3jii2haa_.mp3")}}

* Ꮥ³Ꮧ̣²Ꭶ² [de³di²ga²](dee3dii2gaa2_.mp3): All of us ate solid foods recently

    {{audio (file="dee3dii2gaa2_.mp3")}}

* Ꭳ¹Ꭹ̣²Ꮒ²Ꭽ [o¹gị²ni²ha](oo1gi2nii2haa_.mp3): He and I have a solid object

    {{audio (file="oo1gi2nii2haa_.mp3")}}

* Ꮥ²Ꭹ̣²Ꮒ²Ꭽ [de²gị²ni²ha](dee2gi2nii2haa_.mp3): You (1) and I have solid objects

    {{audio (file="dee2gi2nii2haa_.mp3")}}

