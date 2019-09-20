findMediasRoute() {
  add_response_header "Content-Type" "application/json"
  results=$(tree "$DATA_PATH$1" -J -P "*.mkv")
  send_response_ok_exit <<< $results 
}

mediaHasSubtitlesRoute() {
  add_response_header "Content-Type" "application/json"
  SUBTITLES=()
  SEARCHING_FILE="$DATA_PATH/$(urldecode $2)"
  if [ -f "$SEARCHING_FILE" ]; then
    require lang-handler
  fi
  results=$(printf '%s\n' "${SUBTITLES[@]}" | jq -R . | jq -s .)
  send_response_ok_exit <<< $results
}

shiftSubtitlesRoute() {
  add_response_header "Content-Type" "application/json"
  URL=$(echo $2 | awk -F'[?=&]' '{print $1}')
  TIME=$(echo $2 | awk -F'[?=&]' '{print $3}')
  SUBTITLE_FILE="$DATA_PATH/$(urldecode $URL)"
  if [ -f "$SUBTITLE_FILE" ]; then
    require subsync
    subSync "$TIME seconds" "$SUBTITLE_FILE"
    STATUS="RE-SYNC"
  else
    STATUS="FILE_NOT_FOUND"
  fi
  results=$(jq -n ".status = \"$STATUS\"")
  send_response_ok_exit <<< $results
}

on_uri_match '^/api/find/tvshows(/*)$' findMediasRoute "/$TV_SHOWS_FOLDER_NAME"
on_uri_match '^/api/find/movies(/*)$' findMediasRoute "/$MOVIES_FOLDER_NAME"
on_uri_match '^/api/find(/*)$' findMediasRoute "/"

on_uri_match '^/api/subtitles/find(.*)$' mediaHasSubtitlesRoute

on_uri_match '^/api/subtitles/shift(.*)$' shiftSubtitlesRoute
