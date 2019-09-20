#!/usr/bin/env bash

require() {
	source $(pwd)/$1.sh
}

require http
processHeaders
require routes

exit 0