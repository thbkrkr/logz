## logszui

An small UI to effectively explore the logs.

    export LOGS_URL=https://es1.pim:9200
    export LOGS_USERNAME=super.man
    export LOGS_PASSWORD=IFEQl7Z998vC58krBocy

    docker run -d \
      -e URL=${LOGS_URL} \
      -e USERNAME=${LOGS_USERNAME} \
      -e PASSWORD=${LOGS_PASSWORD} \
      -p 80:4242 \
      krkr/logzui