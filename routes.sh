findMediasRoute() {
  add_response_header "Content-Type" "application/json"
  results=$(tree "$DATA_PATH$1" -J)
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

on_uri_match '^/api/subtitles/(.*)$' mediaHasSubtitlesRoute

on_uri_match '^/api/find/tvshows(/*)$' findMediasRoute "/$TV_SHOWS_FOLDER_NAME"
on_uri_match '^/api/find/movies(/*)$' findMediasRoute "/$MOVIES_FOLDER_NAME"
on_uri_match '^/api/find(/*)$' findMediasRoute "/"