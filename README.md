# NginxProxy

## Create a SSL certificate for development

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
