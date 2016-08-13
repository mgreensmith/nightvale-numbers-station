#!/bin/bash
#
# Generates mp3 files in a docker container, and saves them to
# the relative directory ./data on this host.
#
# The files each contain a single spoken word, consisting of the
# numbers 1 through 99, in a file named for that number. e.g. 1.mp3
#

DATA_DIR="$(pwd)/data"

# Given a single parameter containing the word to speak,
# using the docker espeak/mbrola/sox container from
# https://github.com/ozzyjohnson/docker-tts,
# generate an mp3 of that word and put it in the ./data directory
function make_mp3 () {
  docker run -it --rm -v ${DATA_DIR}:/data ozzyjohnson/tts \
  bash -c "espeak -vmb-us1 -s70 -p90 $1 --stdout | sox -t wav -c 1 - -t mp3 $1.mp3"
  # -vmb-us-1 is Mbrola us1 voice, -s is speed in wpm, -p is pitch in 1-99
}

# Make an mp3 file for each number from 1 to 99
for i in {1..99}; do
  make_mp3 $i
done
