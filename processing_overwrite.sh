#!/bin/zsh

INPUT_DIR="$HOME/Desktop/Recordings"

for f in "$INPUT_DIR"/*.mp3; do
  [ -e "$f" ] || continue
  base=$(basename "$f" .mp3)

  echo "Processing: $base.mp3"

  # Temporary files
  stats_file="$(mktemp)"
  temp_out="$(mktemp).mp3"

  # Pass 1: measure loudness
  ffmpeg -i "$f" -af loudnorm=I=-20:TP=-3:LRA=11:print_format=json -f null - 2> "$stats_file"

  # Extract measured values
  input_i=$(grep "input_i" "$stats_file" | awk -F: '{print $2}' | tr -d ' ",')
  input_tp=$(grep "input_tp" "$stats_file" | awk -F: '{print $2}' | tr -d ' ",')
  input_lra=$(grep "input_lra" "$stats_file" | awk -F: '{print $2}' | tr -d ' ",')
  input_thresh=$(grep "input_thresh" "$stats_file" | awk -F: '{print $2}' | tr -d ' ",')
  offset=$(grep "target_offset" "$stats_file" | awk -F: '{print $2}' | tr -d ' ",')

  # Pass 2: apply normalization + 4s silence at start
  ffmpeg -i "$f" \
    -af "loudnorm=I=-20:TP=-3:LRA=11:measured_I=$input_i:measured_TP=$input_tp:measured_LRA=$input_lra:measured_thresh=$input_thresh:offset=$offset:linear=true:print_format=summary,adelay=4000|4000" \
    -ar 44100 -ac 2 -b:a 192k "$temp_out"

  # Replace original file
  mv "$temp_out" "$f"
  rm "$stats_file"
done