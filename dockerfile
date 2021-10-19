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
RUN adduser --disabled-password --gecos "" node

# Expose HTTPS port
EXPOSE 443

# copy location (route) data over
COPY ./locations/ /etc/nginx/locations/

# Copy sites-available to container
COPY ./sites-available/. /etc/nginx/sites-available/

# symlink sites-available to sites-enabled for nginx to read
RUN ln -s /etc/nginx/sites-available/* /etc/nginx/sites-enabled/

# DEVELOPMENT ======================================================================================
FROM nginx:latest as development
WORKDIR /etc/nginx

# Copy nginx config from common stage
COPY --from=common /etc/nginx /etc/nginx

# copy the dev nginx.conf over for development
COPY ./development/nginx.conf /etc/nginx

# # PRODUCTION =======================================================================================
FROM nginx:latest as production
WORKDIR /etc/nginx

# Copy nginx config from common stage
COPY --from=common /etc/nginx /etc/nginx

# copy the dev nginx.conf over for development
COPY ./production/nginx.conf /etc/nginx
