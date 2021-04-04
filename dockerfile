FROM nginx:latest

USER root
COPY ./html /usr/share/nginx/html

# place in the custom nginx config
COPY nginx.conf /etc/nginx/nginx.conf
EXPOSE 80
EXPOSE 443