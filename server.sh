#!/usr/bin/env bash

DATA_PATH="/Users/pasteu_e/Documents/Work/Subfixx/data"
TV_SHOWS_FOLDER_NAME="TV Shows"
MOVIES_FOLDER_NAME="Movies"

require() {
	source $(pwd)/$1.sh
}

require http
processHeaders
require routes

exit 0