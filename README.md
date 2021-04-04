# NginxProxy

## Create a SSL certificate for development

```none
openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -nodes
```

## Running dev

```none
docker-compose build && docker-compose -f docker-compose.yaml -f development.yaml up
```
