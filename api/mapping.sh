#!/bin/bash -eu

delete_mapping() {
  curl -su $LOGZ_USERNAME:$LOGZ_PASSWORD $LOGZ_URL/$INDEX -XDELETE
}

create_mapping() {
  curl -su $LOGZ_USERNAME:$LOGZ_PASSWORD $LOGZ_URL/$INDEX -XPUT -d '
{
  "mappings": {
    "events": {
      "properties": {
        "Kind": {
          "type": "string",
          "index": "not_analyzed"
        },
        "Node": {
          "type": "string",
          "index": "not_analyzed"
        },
        "Service": {
          "type": "string",
          "index": "not_analyzed"
        },
        "Status": {
          "type": "string",
          "index": "not_analyzed"
        },
        "Timestamp": {
          "type": "date",
          "format": "epoch_second"
        }
      }
    }
  }
}'
}

main() {
  INDEX=events
  delete_mapping
  create_mapping
}

main