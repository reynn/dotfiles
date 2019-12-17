#!/usr/bin/env zsh

BASE_PATH=${1:-/media/deadpool/youtube}
CHANNEL_LIST="${2:-$BASE_PATH/channel_list.txt}"
ARCHIVE_LOG="${3:-$BASE_PATH/downloaded.txt}"
SINCE="${4:-`date -d "28 hours ago" '+%Y%m%d'`}"

youtube-dl \
  --playlist-reverse \
  --download-archive "$ARCHIVE_LOG" \
  -i \
  -o "$BASE_PATH/%(uploader)s [%(channel_id)s]/%(uploader)s - S01E%(playlist_index)s - %(title)s [%(id)s].%(ext)s" \
  -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]' \
  --merge-output-format mp4 \
  --add-metadata \
  --no-continue \
  --no-overwrites \
  --write-thumbnail \
  --embed-thumbnail \
  --all-subs \
  --sub-format "srt" \
  --embed-subs \
  --dateafter "$SINCE" \
  --batch-file="$CHANNEL_LIST"