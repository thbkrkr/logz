NAME = krkr/logzui

build:
	docker build -t $(NAME) .

run-ti:
	docker run --rm -ti --name logzui \
		-e URL=${LOGS_URL} \
		-e USERNAME=${LOGS_USERNAME} \
		-e PASSWORD=${LOGS_PASSWORD} \
		-p 80:4242 \
		$(NAME)

run:
	docker run -d --name logzui \
		-e URL=${LOGS_URL} \
		-e USERNAME=${LOGS_USERNAME} \
		-e PASSWORD=${LOGS_PASSWORD} \
		-p 80:4242 \
		$(NAME)

dev:
	docker run --rm -ti \
		-v $$(pwd)/api:/api \
		-e URL=${LOGS_URL} \
		-e USERNAME=${LOGS_USERNAME} \
		-e PASSWORD=${LOGS_PASSWORD} \
		-p 80:4242 \
		$(NAME)