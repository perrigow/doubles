#!/bin/bash

function gs_compress() {
  newfile="${1/assets/assets_small}"
  parentdir="$(dirname "$newfile")"
  if [ ! -d "$parentdir" ]; then
    mkdir -p "$parentdir"
  fi
  # echo -e "$1 - $newfile"
  filename="${1##*/}"
  echo -e "$filename"
  gs -dQUIET -dNOPAUSE -dBATCH -dSAFER \
     -sDEVICE=pdfwrite \
     -dPDFSETTINGS=/screen \
     -sOutputFile="$newfile" \
     "$1" \
     -c "[ /Title ($filename) /Author () /Creator () /DOCINFO pdfmark" -f
}

export -f gs_compress
find "$1" -type f -name "*.pdf" -exec bash -c "gs_compress \"{}\"" \;

