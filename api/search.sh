#!/bin/bash

IN="$(cat /dev/stdin)"

g() { jq -r .$1 <<< $IN; }

curl -s \
  -u "${LOGZ_USERNAME:-"yo"}:${LOGZ_PASSWORD:-"lo"}" \
  -XGET "$LOGZ_URL/$(g index)/_search" \
    -d "$(g request)"
