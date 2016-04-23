#!/bin/bash -u

IN="$(cat /dev/stdin)"

g() { jq -r .var.$1 <<< $IN; }

request() {
  req=$(jq -c .request <<< $IN)
  while read v; do
    req=$(sed "s|{{$v}}|$(g $v)|g" <<< $req)
  done < \
    <(jq -r '.var | keys[]' <<< $IN)
  echo $req
}

  curl -s \
    -u ${LOGZ_USERNAME:-"yo"}:${LOGZ_PASSWORD:-"lo"} \
    -XGET $LOGZ_ES/$(g index)/_search -d "$(request)"
}

post()  {
  curl -s \
    -u ${LOGZ_USERNAME:-"yo"}:${LOGZ_PASSWORD:-"lo"} \
    -XGET $LOGZ_ES/$(g index)/_search -d @-
}

main () { request | post; }