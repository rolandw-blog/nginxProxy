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

# DEVELOPMENT ======================================================================================
FROM nginx:latest as development
WORKDIR /etc/nginx

# copy the dev nginx.conf over
COPY ./development/nginx.conf /etc/nginx

# copy and link the site configs over
COPY ./development/sites-available/. /etc/nginx/sites-available
RUN ln -s /etc/nginx/sites-available/. /etc/nginx/sites-enabled

# get the locations (routes)
COPY --from=common /etc/nginx/locations/ /etc/nginx/locations/

# PRODUCTION =======================================================================================
FROM nginx:latest as production

# copy the dev nginx.conf over
COPY ./production/nginx.conf /etc/nginx

# copy and link the site configs over
COPY ./production/sites-available/. /etc/nginx/sites-available
RUN ln -s /etc/nginx/sites-available/. /etc/nginx/sites-enabled

# get the locations (routes)
COPY --from=common /etc/nginx/locations/ /etc/nginx/locations/