findSubtitle() {
  local FILNAME="${SEARCHING_FILE%%.*}"
  FOUND=false
  if [ -f "$FILNAME.$1.srt" ]; then
    SHORT_NAME=$(basename -- "$FILNAME")
    echo "$SHORT_NAME.$1.srt"
  fi
}

SUBTITLES=()
SUBTITLES+=($(findSubtitle "fr"))
SUBTITLES+=($(findSubtitle "en"))