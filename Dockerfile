# base
FROM jazzdd/alpine-flask:python3

# build arguments
ARG timezone="America/Santiago"

RUN apk update && apk add --no-cache \
	tzdata \
	gcc \
	libxml2-dev \
	musl-dev \
	python-dev \
	py-lxml && \
	# pip installs
	pip install lxml IMDbPy && \
	# clean dev packages
	apk del \
	gcc \
	libxml2-dev \
	musl-dev \
	python-dev \
	&& rm -rf /var/cache/apk/* \
	# clean nginx default host
	&& rm /etc/nginx/conf.d/default.conf

# disable nginx sendfile option
RUN sed -i '/http {/,/}/ s/sendfile on;/sendfile off;/' /etc/nginx/nginx.conf && \
	sed -i "/@flaskApp {/a add_header 'Access-Control-Allow-Origin' '*';" /etc/nginx/nginx.conf

# timezone
ENV TZ=$timezone

RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && \
	echo $TZ > /etc/timezone && date

# go to server dir
WORKDIR /app

# project code
COPY app.py .
