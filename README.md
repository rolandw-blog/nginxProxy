# NginxProxy

## Running production

Using [these](https://certbot.eff.org/lets-encrypt/debianbuster-nginx) instructions you can create a wildcard certificate for your domain.
Ensure you have certificates installed to `/etc/letsencrypt/live/DOMAIN.COM-0001/{privkey.pem, fullchain.pem}`, then update the volume in `/production.yaml`.

Launch the gateway with.

```none
docker-compose build && docker-compose -f docker-compose.yaml -f production.yaml up
```

## Running development

If you are running in development you can sign your own certificate like this. Place `key.pem` and `cert.pem` in `development/keys`.

```none
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes
```

## Running Development

Make sure that the `keys/development/{cert.pem, key.pem}` exist.

```none
docker-compose build && docker-compose -f docker-compose.yaml -f development.yaml up
```

## Running Production

Not done yet!
