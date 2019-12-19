#!/usr/bin/env sh

mkdir -p /etc/pki/CA/private /etc/pki/CA/certs
mkdir -p /etc/pki/CA/private
openssl req -subj '/CN=*' -x509 -newkey rsa:4096 -nodes -days 365 \
            -keyout /etc/pki/CA/private/nginx-key.pem \
            -out /etc/pki/CA/certs/selfsigned-nginx-cert.pem

cat > /etc/nginx/conf.d/proxy_ssl.conf << __FILE__
server {
  listen 443 ssl;
  ssl_certificate /etc/pki/CA/certs/selfsigned-nginx-cert.pem;
  ssl_certificate_key /etc/pki/CA/private/nginx-key.pem;
  location / {
     proxy_set_header        Host \$host;
     proxy_set_header        X-Real-IP \$remote_addr;
     proxy_set_header        X-Forwarded-For \$proxy_add_x_forwarded_for;
     proxy_set_header        X-Forwarded-Proto \$scheme;

     proxy_pass http://${HOST_URL};
  }
}
__FILE__

nginx -T
exec "$@"
