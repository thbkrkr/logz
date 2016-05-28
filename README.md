# logz

A clean UI to effectively explore data in Elasticsearch.

```
docker run -d \
  -e LOGZ_URL=https://es1.pim:9200 \
  -e LOGZ_USERNAME=super.man \
  -e LOGZ_PASSWORD=35s4p2t0m154pT5enIcec \
  -p 80:4242 \
  krkr/logz
```