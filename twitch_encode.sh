#!/bin/bash

YOUTUBE_DL=$(which youtube-dl)
MENCODER=$(which mencoder)
MPLAYER=$(which mplayer)
#TITLE=$(${YOUTUBE_DL} -e $1 > temp_file.txt; head -n 1 temp_file.txt)

#Get the file names of all of the files in the stream.
${YOUTUBE_DL} --get-filename --restrict-filenames -o "%(id)s_%(autonumber)s.%(ext)s" $1 > filenames.txt

#Download the actual files.
${YOUTUBE_DL} --restrict-filenames -o "%(id)s_%(autonumber)s.%(ext)s" $1 

#Go through each downloaded file and remove them from the list of ones to be encoded if they don't have an audio stream. Muted.
DATA=$(
while read line
do
   # See if the file has a Audio stream. if it does, keep it.
   foo=`${MPLAYER} -identify -frames 0 ${line} 2>/dev/null | grep 'Audio: no sound'`
   if ! [[ $foo && ${foo} ]]
   then
      echo -n "${line} "
   fi
done < filenames.txt)

#Encode the files into one file sized to 640x360.
nice -n 19 ${MENCODER} -ovc lavc -lavcopts vcodec=mpeg4:threads=4 -vf scale=640:360 -oac mp3lame -o $2.mp4 ${DATA}

