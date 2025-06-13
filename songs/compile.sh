#! /bin/bash

for f in /songs/*.cho; do
    base=$(basename $f .cho)
    chordpro /songs/$base.cho -o /output/$base.pdf
done
