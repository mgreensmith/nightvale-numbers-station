#!/bin/bash

# This is a "Playlist Program" for ezstream
# https://www.mankier.com/1/ezstream#Scripting-Playlist_Programs
# It generates a pseudorandom numbers station a la Night Vale
#
# Playlist rules
# - One time in twenty, we should return /data/chime.mp3
# - The rest of the time, we should return a random file in /data/[1-99].mp3

# generate random number in range of 0 - $1 and store it in $RAND
random() {
    local range=${1:-1}
    RAND=`od -t uI -N 4 /dev/urandom | awk '{print $2}'`
    let "RAND=$RAND%($range+1)"
}

# One time in twenty, we should return /data/chime.mp3
random 19
if [ $RAND -eq 0 ]; then
  echo '/data/chime.mp3'
  exit 0
fi

# return a random file in /data/[1-99].mp3
random 98
number=$(($RAND + 1))
echo "/data/${number}.mp3"
