#!/bin/bash

IN="$(cat /dev/stdin)"

_() { jq -r .$1 <<< $IN; }

curl -s \
  -u "${LOGZ_USERNAME:-"yo"}:${LOGZ_PASSWORD:-"lo"}" \
  -XGET "$LOGZ_URL/$(jq -r .index <<< $IN)/_search" \
  -d "$(jq .request <<< $IN)"
