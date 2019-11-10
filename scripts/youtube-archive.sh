#!/usr/bin/env zsh

for z in $(find $DFP/zsh -type f -name "*.zsh"); do source $z ; done

BASE_PATH=${1:-/media/deadpool/youtube}
CHANNEL_LIST="${2:-$BASE_PATH/channel_list.txt}"
ARCHIVE_LOG="${3:-$BASE_PATH/downloaded.txt}"

print_debug "youtube-archive.BASE_PATH   " "$BASE_PATH"
print_debug "youtube-archive.CHANNEL_LIST" "$CHANNEL_LIST"
print_debug "youtube-archive.ARCHIVE_LOG " "$ARCHIVE_LOG"

youtube-dl \
  --playlist-reverse \
  --download-archive "$ARCHIVE_LOG" \
  -i \
  -o "$BASE_PATH/%(uploader)s [%(channel_id)s]/%(uploader)s - S01E%(playlist_index)s - %(title)s [%(id)s].%(ext)s" \
  -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]' \
  --merge-output-format mp4 \
  --add-metadata \
  --write-thumbnail \
  --batch-file="$CHANNEL_LIST"
