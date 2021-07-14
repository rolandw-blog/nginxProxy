FROM nginx:latest

# Just use root for this
USER root

RUN mkdir -p /etc/nginx/sites-available/development
RUN mkdir -p /etc/nginx/sites-available/production
RUN mkdir -p /etc/nginx/config
# RUN mkdir /usr/share/nginx/html/landing

# Certificates go here
RUN mkdir -p /etc/letsencrypt/live/localhost
RUN mkdir -p /etc/letsencrypt/live/rolandw.dev-0001

# Copy the http config over
COPY nginx.conf /etc/nginx/nginx.conf

# Copy the config module bits over
COPY ./config /etc/nginx/config

EXPOSE 443