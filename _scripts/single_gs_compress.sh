#!/bin/bash

overwrite=false
infile=$(realpath "$1")

outfile="$2"
if [ -z "$outfile" ]; then
  outfile=$(dirname "$infile")"/`mktemp -u tmp.XXXXXXXX`"
  overwrite=true
  echo -e "   In File: $infile"
  echo -e " Temp File: $outfile"
else
  echo -e " In File: $infile"
  echo -e "Out File: $(pwd)/$outfile"
fi

filename="${1##*/}"
gs -dQUIET -dNOPAUSE -dBATCH -dSAFER \
   -sDEVICE=pdfwrite \
   -dPDFSETTINGS=/screen \
   -sOutputFile="$outfile" \
   "$infile" \
   -c "[ /Title ($filename) /Author () /Creator () /DOCINFO pdfmark" -f

if $overwrite; then
  echo -e "Overwriting $infile..."
  infile_old="$infile.old"
  mv "$infile" "$infile_old" && mv "$outfile" "$infile" && rm "$infile_old"
fi

