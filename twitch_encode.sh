#!/bin/bash

YOUTUBE_DL=$(which youtube-dl)
MENCODER=$(which mencoder)
#TITLE=$(${YOUTUBE_DL} -e $1 > temp_file.txt; head -n 1 temp_file.txt)

${YOUTUBE_DL} --get-filename --restrict-filenames -o "%(id)s_%(autonumber)s.%(ext)s" $1 > filenames.txt

DATA=$(
while read line
do
  echo -n "${line} "
done < filenames.txt)

${YOUTUBE_DL} --restrict-filenames -o "%(id)s_%(autonumber)s.%(ext)s" $1 

nice -n 19 ${MENCODER} -ovc lavc -lavcopts vcodec=mpeg4:threads=4 -vf scale=640:360 -oac mp3lame -o $2.mp4 ${DATA}

