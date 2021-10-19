openssl req -sha256 -addext "subjectAltName = IP:192.168.0.100" -newkey rsa:4096 -nodes -keyout privkey.pem -x509 -days 730 -out fullchain.pem
