#!/bin/bash
socat TCP4-LISTEN:$PORT,fork EXEC:./server.sh
