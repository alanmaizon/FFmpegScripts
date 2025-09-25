#!/bin/zsh

INPUT_DIR="$HOME/Documents/macro-output"
OUTPUT_DIR="$HOME/Desktop/Edited Recordings"

mkdir -p "$OUTPUT_DIR"

for f in "$INPUT_DIR"/*.mp3; do
  [ -e "$f" ] || continue
  base=$(basename "$f" .mp3)

  ffmpeg -i "$f" \
    -af "adelay=4000|4000" \
    -ar 44100 -ac 2 -b:a 192k "$OUTPUT_DIR/${base}.mp3"
done