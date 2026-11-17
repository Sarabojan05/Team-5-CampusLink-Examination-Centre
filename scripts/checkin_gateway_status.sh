#!/bin/bash
# Checks whether the local CampusLink TCP receiver accepts a connection.
HOST="127.0.0.1"
PORT="9105"

if nc -z -w 2 "$HOST" "$PORT" 2>/dev/null; then
    echo "PASS: CampusLink check-in receiver is accepting connections on ${HOST}:${PORT}"
    exit 0
else
    echo "FAIL: CampusLink check-in receiver cannot be reached at ${HOST}:${PORT}"
    exit 1
fi
