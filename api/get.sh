#!/bin/bash -eux

fetch() {
  local index="$1"
  local query="$2"
  local since="$3"

  declare program="docker"

  curl -s -u $USERNAME:$PASSWORD \
    -XGET $URL/$index/_search -d '
  {
    "from" : 0, "size" : 10,
    "query": {
      "bool": {
        "must": [
          { "range": { "timestamp": {"gt": "now-'$since'"} } },
          { "term": { "program": "'$program'"} },
          { "query_string": {
              "query": "'$query'"
            }
          }
        ]
      }
    },
    "aggregations": {
      "tags": { "terms": { "field": "tag" } }
    },
    "sort": { "timestamp": { "order": "desc" } }
  }'
      #,"hosts": { "terms": { "field": "source" } }
}

main () {
  local params=$1
  declare index=$(cut -d '_' -f1 <<< "$params")
  declare query=$(cut -d '_' -f2 <<< $params)
  declare since=$(cut -d '_' -f3 <<< $params)

  fetch "$index" "$query" "$since" | jq '
  {
    aggregations:.aggregations,
    total:.hits.total,
    hits:[
      .hits.hits[] | {
        d:._source.timestamp,
        s:._source.source,
        t:._source.tag,
        m:._source.message,
        p:._source.program
      }
    ]
  }'
}

main "$@"
