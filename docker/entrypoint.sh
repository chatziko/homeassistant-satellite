#!/bin/bash

args=(
	# Enter your Home Assistant host and long-lived access token here
	--host="..."
	--token="..."

	# If needed, enter specific speaker / microphone ALSA devices here
	# --mic-device="plughw:0,4"
	# --snd-device="plughw:0,2"

	--awake-sound="/venv/sounds/awake.wav"
	--volume=1.0
	--volume-multiplier=1.5
	--vad silero

	--debug
)

/venv/bin/python3 -m homeassistant_satellite "${args[@]}"
