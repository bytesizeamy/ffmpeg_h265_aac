#!/bin/bash

input=$1
output=${input//mkv/mp4}
SECONDS=0

args=(
    -hide_banner -loglevel 0 -stats             #minimal output
    -i "$input"
    -c:v libx265 -level 4.1 -preset veryslow    #video settings
    -crf 24 -vsync vfr -tune grain
    -c:a aac -b:a 192k                          #audio settings
    # -c:s vobsub                                 #subtitle
    "$output"
)

echo -e "Input file: $input\nOutput file: $output\n"

ffmpeg "${args[@]}"

HH=$(( SECONDS/3600 )); MM=$(( (SECONDS-HH*3600)/60 )); SS=$(( SECONDS-HH*3600-MM*60 ))
printf "Total processing time: %d:%02d:%02d\n" $HH $MM $SS