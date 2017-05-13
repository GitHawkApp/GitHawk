#!/bin/bash
# script from: https://gist.github.com/peoplesbeer/8af70a90e7eb1c66510b

for file in "$@"
do
  s=${file##*/}
  base=${s%.svg}
  
  echo 'Converting' $file'...'

  mkdir -p out

  convert -density 1200 -background none -resize "60x60" "${file}" "out/${base}@2x.png"
  convert -density 1200 -background none -resize "90x90" "${file}" "out/${base}@3x.png"

  #inkscape --export-png "out/${base}@2x.png" -h 2*$size "${file}"
  #inkscape --export-png "out/${base}@3x.png" -h 3*$size "${file}"

done