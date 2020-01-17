#!/usr/bin/env zsh

source $DFP/.zshrc.min

FANTIA_KEY="${1:-21829b4c93dd362174b9f827e4607e69}"
FANTIA_DIR="$HOME/Pictures/fantia"
FANTIA_CLUBS=(
  # '4170|eri-kitami'
  # '25385|water-ring'
  '17148|nagisa'
)

for club in $FANTIA_CLUBS; do
  local spl=($(helpers text split -d '|' "$club"))
  print_box "Club ID: ${spl[1]} User: ${spl[2]}"
  docker run -v "$FANTIA_DIR:/tmp" --rm fantia.jp --key "$FANTIA_KEY" --fanclub "${spl[1]}" --output "/tmp/${spl[2]}" --verbose
done
