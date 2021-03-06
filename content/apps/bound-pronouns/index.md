+++
draft = false
date = 2020-06-01T21:19:52Z
title = "Bound Pronouns"
weight = 1591046390

[taxonomies]
authors = ["Michael Conrad"]
categories = ["Apps", "Grammar"]
tags = ["Bound Pronouns", "Flash Cards", "Android", "iOS", "Linux", "MacOS", "Windows"]

[extra]
featured_image = "../static/images/bound-pronouns.png"

+++

#### (App updated 2020-06-10)

This is a custom "flash card" style program to assist with learning the bound pronouns. It has options to display using either Latin, Syllabary, both, or none. The software keeps track of your progress and schedules cards based on how well you do. Cards you have problems with are repeated often. Cards you do well with are not.

The program includes spoken audio (synthetic) for each of the challenges, over 1,800 of them.

<!-- more -->
  
All of the "flash cards" use CED style pronunciation marks so that you can see how tone and cadence are used to tell spell alike prefixes such as "deji" "I + them-inanimate" / "You all them-inanimate" apart.  
  
Unlike many other flashcard programs, it isn't designed to be dogmatic about timings. It has an automatic "jump a day forwards" option, where you can jump forwards in the scheduling as if a day had already passed, and, the timings are setup to have a max "jump" of one day if you miss a day so that the software doesn't try and feed you the entire deck in a single session...  
  
Additionally, it only feeds you new cards if you successfully complete all current pending cards within the minimum session time so that you only get new stuff after you perform decently with existing stuff (from session to session).

### App Stores

* [Android App via Google Play](https://play.google.com/store/apps/details?id=com.cherokeelessons.bp.android)
* [iPhone/iPad App via Apple](https://apps.apple.com/us/app/cherokee-bound-pronouns/id966667496?ls=1)
* [Android App via Amazon](https://www.amazon.com/gp/product/B00TCP955U)

### Direct Download

* [Desktop App via Direct Download](BoundPronouns-3.30.jar)
* [Android App via Direct Download](BoundPronouns-3.30-release.apk)

### App Store BETA

* [iPhone/iPad App via Testflight BETA](https://testflight.apple.com/join/EzYA4uQB)
* [Android App via Google Play BETA](https://play.google.com/apps/testing/com.cherokeelessons.bp.android)

## Changelog

### 3.30

Fix issue with "bound pronouns" list screen caused by "csv" to "tsv" filename extension change.

### 3.29

Change minimum Android SDK requirements.

### 3.28

Change "csv" to "tsv" to correctly identify file contents for editing.

### 3.27

Add missing audio files.
Use "alveolar" version of "d" instead of "dental" version of "d" for espeak-ng generated audio.

### 3.26

Fixes for the h/ɂ alternations in stems based on persons.

### 3.25

Reduce cards needed for ᎢᏨ-, ᎢᏍᎩ-, ᎢᏍᏛ-, and ᏍᎩᏂ- by doing "a or b" forms in the English.
Also updated English wording replacement to hopefully produce better English answer sets.

### 3.24

Fix for loading embedded master deck on android.

### 3.23

Switch to using pre-conjugated master deck. Boost volume on audio files to max.

### 3.22

Switch to Brazilian Portuguese &~ instead of French V~ for "v" and "ṿ".
Some adjustments for when to use become acquainted instead of recognize.

### 3.21

Update espeak.txt file.

### 3.20

Master deck sort order fix.

### 3.19

Pronunciation fix for prefix ᎦᏥ- (I+them-animate).
The master entry in the pronouns table was missing a tone mark.

### 3.18

Adjust master deck sorting so that challenges are no longer grouped by bound pronoun or verb.
Each new challenge introduced and added to your active cards should now be a different bound pronoun.

Does not change the ordering of cards already active in a session slot which are solely ordered based on
your accuracy with correct answers and last show time.

### 3.17

Indicate how many total cards are in the deck.

Updated to newest espeak-ng output using most recently updated Cherokee phoneme definitions.

### 3.06

Updated to newer espeak-ng output using updated phonemes. (Improvements one can hopefully hear made to 'a', 'e', and 'i').

### 3.05

Updated to newer espeak-ng output using updated phonemes. (Improvements one can hopefully hear made to 'h', 'g', 'd', 's', and 'v').

Final nasal vowels at the end of words still need adjustment.

Short vowels which should be devoiced when followed by "h" aren't at this time.

### 3.04

Updated list of audio files in app so that it can see the 11 added files.

#### 3.03

Added additional display options for "No Marks" to hide all tone and cadence marks to provide plain Syllabary and Latin forms.

Added additional display option for "Audio Only" for those not wanting visual clues for the answers.

Added 11 missing audio challenges. Updated to newer espeak-ng output using updated phonemes.

#### 3.02

Updated audio with latest espeak-ng generated output using updated phoneme files.

#### 3.01

Initial version with synthetic voice audio for each of the challenges. Mute will disable the voice auto play.

#### 2.32

Update to latest available libGDX and MobiVM's RoboVM.
Removed Sync due to labor involved with tracking API changes for OAUTH and WEBVIEWS.