# NginxProxy

## Running production

Using [these](https://certbot.eff.org/lets-encrypt/debianbuster-nginx) instructions you can create a wildcard certificate for your domain.
Ensure you have certificates installed to `/etc/letsencrypt/live/DOMAIN.COM-0001/{privkey.pem, fullchain.pem}`, then update the volume in production.yaml.

```yaml
volumes:
    # Replace DOMAIN.COM with your own domain
    - "/etc/letsencrypt/live/DOMAIN.COM-0001/fullchain.pem:/etc/letsencrypt/live/DOMAIN.COM/fullchain.pem"
    - "/etc/letsencrypt/live/DOMAIN.COM-0001/privkey.pem:/etc/letsencrypt/live/DOMAIN.COM/privkey.pem"
```

Build the [management UI](https://github.com/rolandw-blog/managementUI) app.

```none
npm run build
```

This will place the apps contents into the build directory. Then ensure that you have the build mounted in your production.yaml like so.

```yaml
volumes:
    - "../managementUI/frontend/build:/usr/share/nginx/html/admin"
```

```none
docker-compose build && docker-compose -f docker-compose.yaml -f production.yaml up
```

## Running development

If you are running in development you can sign your own certificate like this. Place `key.pem` and `cert.pem` in `development/keys`.

Make sure that the files you generate for development are placed in `keys/development/{cert.pem, key.pem}`.

```none
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes
```

Launch the gateway with.

```none
docker-compose build && docker-compose -f docker-compose.yaml -f development.yaml up
```
