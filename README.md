# logz

A small app to effectively explore data in elasticsearch.

```
export LOGZ_URL=https://es1.pim:9200
export LOGZ_USERNAME=super.man
export LOGZ_PASSWORD=35s4p2t0m154pT5enIcec

docker run -d \
  -e URL=${LOGZ_ES} \
  -e LOGZ_USERNAME=${LOGZ_USERNAME} \
  -e LOGZ_PASSWORD=${LOGZ_PASSWORD} \
  -p 80:4242 \
  krkr/logz
```