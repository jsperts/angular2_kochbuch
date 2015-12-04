#!/bin/bash
set -e

while read -d '' -r file; do
  FILE_TO_WRITE="./manuscript/$(basename ${file}).md"
  > ${FILE_TO_WRITE}
  cd ${file}
  while read -r section; do
    cat ${section} >> "../${FILE_TO_WRITE}"
  done < "Chapter.txt"
  cd ..
done < <(find . ! -path . ! -path "./manuscript*" ! -path "./.git*" -type d -print0)

