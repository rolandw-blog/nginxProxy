# NginxProxy

## Running production

Using [these](https://certbot.eff.org/lets-encrypt/debianbuster-nginx) instructions you can create a wildcard certificate for your domain.
Ensure you have certificates installed to `/etc/letsencrypt/live/DOMAIN.COM-0001/{privkey.pem, fullchain.pem}` and then copy them over to `keys/production/` just temporarily.

Then check `runMe.sh` for details on how the `blog_nginx_proxy_certs` volume is populated with these certificates.