# Processing Audio Workflow + Overwrite

This repository contains a simple shell script for batch-processing MP3 files with FFmpeg.
The script is designed to normalize audio loudness and add consistent silence padding at the start of each track.

## Features
	•	Batch-processes all .mp3 files in a given folder
	•	EBU R128 loudness normalization to –20 LUFS (perceived loudness)
	•	True Peak limited to –3 dB
	•	Adds 4 seconds of silence at the beginning of each file
	•	Overwrites the original MP3s in place

## Requirements
	•	macOS or Linux
	•	FFmpeg installed and available in your PATH
	•	On macOS with Homebrew:

`brew install ffmpeg`



## Usage
	1.	Clone or download this repository.
	2.	Place your MP3 files inside a folder called Recordings on your Desktop.

`~/Desktop/Recordings/`


	3.	Make the script executable:

`chmod +x processing_overwrite.sh`


	4.	Run the script:

`./processing_overwrite.sh`



Each MP3 in Recordings will be normalized and padded, replacing the original file.

## How It Works

The script uses a two-pass loudness normalization workflow:
 • 1.	First pass measures integrated loudness, loudness range, and true peak.
	• 2.	Second pass applies normalization based on those measurements, ensuring precise LUFS and peak compliance.
	• 3.	An adelay filter inserts 4 seconds of silence at the start.

## Notes
	•	The script overwrites your original MP3s. If you want to keep the raw versions, back them up before running.
	•	For a non-destructive workflow, you can edit the script to save processed files into a new folder instead.

⸻
