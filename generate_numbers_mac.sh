#!/bin/bash
#
# Generates mp3 files using `say` and `lame`, and saves them to
# the relative directory ./data on this host.
#
# The files each contain a single spoken word, consisting of the
# numbers 1 through 99, in a file named for that number. e.g. 1.mp3
#
# Install `lame` from homebrew.

for i in {1..99}; do
  # Use vicki voice, at 140 WPM, inserting 300ms of trailing silence
  say -v vicki -r 140 "${i} [[slnc 300]]" -o num.aiff
  # Convert from aiff to mp3 in mono mode, 16khz bitrate
  lame -m m -b 16 num.aiff data/$i.mp3 2>/dev/null
done

rm num.aiff
