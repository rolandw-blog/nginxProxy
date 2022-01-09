FROM nginx:latest as common

# Just use root for this
USER root

# make sure nginx folders exist
RUN mkdir -p /etc/nginx/sites-available
RUN mkdir -p /etc/nginx/sites-enabled

# routes go here
RUN mkdir -p /etc/nginx/locations

# keys are mounted here in a volume called "blog_nginx_proxy_certs"
RUN mkdir -p /keys

# prepare the volume
# https://github.com/nodejs/docker-node/blob/cbbf60da587a7ca135b573f4c05810d88f04ace7/16/buster/Dockerfile
# nginx needs to understand this user with id 1000
RUN groupadd --gid 1000 node \
  && useradd --uid 1000 --gid node --shell /bin/bash --create-home node

# Expose HTTPS port
EXPOSE 443

# copy location (route) data over
COPY ./locations/ /etc/nginx/locations/

# Copy sites-available to container
COPY ./sites-available/. /etc/nginx/sites-available/

# symlink sites-available to sites-enabled for nginx to read
RUN ln -s /etc/nginx/sites-available/* /etc/nginx/sites-enabled/

# These env vars will be used to configure nginx
ARG BLOGBUILDER_PORT
ARG BLOGWATCHER_PORT

ENV BLOGBUILDER_PORT $BLOGBUILDER_PORT
ENV BLOGWATCHER_PORT $BLOGWATCHER_PORT

RUN echo "BLOGBUILDER_PORT=$BLOGBUILDER_PORT"
RUN echo "BLOGWATCHER_PORT=$BLOGWATCHER_PORT"
RUN find /etc/nginx/locations -type f -exec sed -i "s/\${BLOGWATCHER_PORT}/$BLOGWATCHER_PORT/g" {} \;
RUN find /etc/nginx/locations -type f -exec sed -i "s/\${BLOGBUILDER_PORT}/$BLOGBUILDER_PORT/g" {} \;
# RUN mkdir /scripts
# COPY ./scripts/substitute_vars.sh /scripts/substitute_vars.sh
# RUN chmod +x /scripts/substitute_vars.sh
# RUN /scripts/substitute_vars.sh

# RUN cat /etc/nginx/locations/blogwatcher.conf

# DEVELOPMENT ======================================================================================
FROM common as development
WORKDIR /etc/nginx
COPY ./development/nginx.conf /etc/nginx

# # PRODUCTION =======================================================================================
FROM common as production
WORKDIR /etc/nginx
COPY ./production/nginx.conf /etc/nginx
