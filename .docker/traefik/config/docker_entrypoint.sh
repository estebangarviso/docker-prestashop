#!/bin/sh

# Add redirections if SSL is enabled
if [ "$PS_ENABLE_SSL" = "1" ]; then
    ENTRYPOINTS=$(cat /tmp/entrypoints/default.yml)
    sed -i "s|__ENTRYPOINTS__|$ENTRYPOINTS}|g" /etc/traefik/traefik.yml
else
    ENTRYPOINTS=$(cat /tmp/entrypoints/http-redirect.yml)
    sed -i "s|__ENTRYPOINTS__|$ENTRYPOINTS|g" /etc/traefik/traefik.yml
fi

# Generate self-signed certificate if SSL is enabled
if [ "$PROXY_ADD_SELF_SIGNED_CERTIFICATES" = "1" ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/traefik/certs/${PS_DOMAIN}.key -out /etc/traefik/certs/${PS_DOMAIN}.crt
    sed -i "s|__TLS__|$(cat config/tls/self-signed.yml)|g" /etc/traefik/traefik.yml
else
    sed -i "s|__TLS__||g" /etc/traefik/traefik.yml
fi
