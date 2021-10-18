FROM nginx:latest as common

# Just use root for this
USER root

RUN mkdir -p /etc/nginx/sites-available
RUN mkdir -p /etc/nginx/sites-enabled
RUN mkdir -p /etc/nginx/config
# RUN mkdir /usr/share/nginx/html/landing

# Certificates go here
RUN mkdir -p /keys

# copy favicon
COPY ./html/favicon.ico /usr/share/nginx/html
RUN chown -R nginx:nginx /usr/share/nginx/html/favicon.ico

# prepare the volume
RUN adduser --disabled-password --gecos "" node
RUN mkdir -p /usr/share/nginx/html/dist  && chown node:node /usr/share/nginx/html/dist
VOLUME /usr/share/nginx/html/dist

# create dist
# RUN mkdir -p /usr/share/nginx/html/dist
# RUN echo "temp" > /usr/share/nginx/html/dist/index.html

# Copy the config module bits over
# COPY ./config /etc/nginx/config

EXPOSE 443

# Within the docker-compose.yaml you can specify a build.target: "development" || "production"
# This will build the docker image with the appropriate configuration

FROM nginx:latest as development
WORKDIR /etc/nginx
COPY ./development/nginx.conf /etc/nginx
COPY ./development/config /etc/nginx/config
COPY ./development/sites-available/. /etc/nginx/sites-available
RUN ln -s sites-available/. ./sites-enabled

FROM nginx:latest as production
WORKDIR /etc/nginx
COPY ./production/nginx.conf /etc/nginx
COPY ./production/config /etc/nginx/config
COPY ./production/sites-available/. /etc/nginx/sites-available
RUN ln -s sites-available/. ./sites-enabled
