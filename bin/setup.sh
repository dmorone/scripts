#!/usr/bin/env bash
set -e
set -u

# MPV - play radio and sounds
# FZF - fuzzy history search
# PANDOC - process markdown files for TTS
# JHEAD - read and edit EXIF data
brew install -q \
   mpv \
   fzf \
   pandoc \
   jhead

brew cleanup
