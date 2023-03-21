FROM traefik:v2.9

LABEL maintainer="Esteban Garviso <e.garvisovenegas@gmail.com>"

# Global variables
ARG PROXY_RESOLVER_EMAIL \
    PS_DOMAIN

# Create acme.json file
RUN mkdir -p /etc/traefik/certs && touch /etc/traefik/certs/acme.json && chmod 600 /etc/traefik/certs/acme.json

# Copy custom configuration
COPY traefik.yml /etc/traefik/

# Replace environment variables in traefik.yml
RUN sed -i "s|__PROXY_RESOLVER_EMAIL__|${PROXY_RESOLVER_EMAIL}|g" /etc/traefik/traefik.yml

# Redirect to https if PROXY_REDIRECT_TO_HTTPS is set to 1
RUN if [ "${PROXY_REDIRECT_TO_HTTPS}" = "1" ]; then \
    sed -i "s|# http:|http:|g" /etc/traefik/traefik.yml \
    && sed -i "s|#   redirections:|  redirections:|g" /etc/traefik/traefik.yml \
    && sed -i "s|#     entryPoint:|    entryPoint:|g" /etc/traefik/traefik.yml \
    && sed -i "s|#       to: https|      to: https|g" /etc/traefik/traefik.yml \
    && sed -i "s|#       scheme: https|      scheme: https|g" /etc/traefik/traefik.yml \
    ;fi

# Copy certificates
COPY certs/local-cert.pem certs/local-key.pem /etc/traefik/certs/
