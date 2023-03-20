FROM traefik:v2.9

LABEL maintainer="Esteban Garviso <e.garvisovenegas@gmail.com>"

# Global variables
ARG PROXY_RESOLVER_EMAIL

# Copy custom configuration
COPY traefik.yml /etc/traefik

# Replace environment variables in traefik.yml
RUN sed -i "s|__PROXY_RESOLVER_EMAIL__|${PROXY_RESOLVER_EMAIL}|g" /etc/traefik/traefik.yml