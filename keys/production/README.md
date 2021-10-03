# Instructions

## For Certbot

You will need to intergrate this into your automatic cert refresh that certbot does.

```bash
# change this to your cert location
BASE="/etc/letsencrypt/live/rolandw.dev-0001"

# create temp container
/usr/bin/docker create --name temp_container -v blog_nginx_proxy_certs:/certs alpine

# copy certs over (-L to follow symlinks)
sudo /usr/bin/docker cp -L "$BASE/cert.pem" temp_container:/certs/
sudo /usr/bin/docker cp -L "$BASE/chain.pem" temp_container:/certs/
sudo /usr/bin/docker cp -L "$BASE/fullchain.pem" temp_container:/certs/
sudo /usr/bin/docker cp -L "$BASE/privkey.pem" temp_container:/certs/

# kill container
/usr/bin/docker rm temp_container

# verify certs are placed correctly
docker run --rm --name temp_container -v blog_nginx_proxy_certs:/certs alpine ls -l /certs
```
