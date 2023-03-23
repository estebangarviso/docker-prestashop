FROM traefik:v2.9

LABEL maintainer="Esteban Garviso <e.garvisovenegas@gmail.com>"

# Global variables
ARG PROXY_RESOLVER_EMAIL \
    PROXY_LOG_LEVEL \
    PROXY_API_DASHBOARD \
    PROXY_API_INSECURE \
    PROXY_ADD_SELF_SIGNED_CERTIFICATES \
    PS_ENABLE_SSL \
    PS_DOMAIN

ENV PS_ENABLE_SSL=$PS_ENABLE_SSL \
    PROXY_ADD_SELF_SIGNED_CERTIFICATES=$PROXY_ADD_SELF_SIGNED_CERTIFICATES 

# Create acme.json file
RUN mkdir -p /etc/traefik/certs && touch /etc/traefik/certs/acme.json && chmod 600 /etc/traefik/certs/acme.json

# Create empty log file
RUN mkdir -p /var/log/traefik && touch /var/log/traefik/traefik.log

# Copy custom configuration
RUN mkdir -p /tmp/entrypoints
COPY config/traefik.yml /etc/traefik/
COPY config/entrypoints/default.yml config/entrypoints/http-redirect.yml /tmp/entrypoints/

# Replace environment variables in traefik.yml
RUN sed -i "s|__PROXY_RESOLVER_EMAIL__|${PROXY_RESOLVER_EMAIL}|g" /etc/traefik/traefik.yml && \
    sed -i "s|__PROXY_LOG_LEVEL__|${PROXY_LOG_LEVEL}|g" /etc/traefik/traefik.yml && \
    sed -i "s|__PROXY_API_DASHBOARD__|${PROXY_API_DASHBOARD}|g" /etc/traefik/traefik.yml && \
    sed -i "s|__PROXY_API_INSECURE__|${PROXY_API_INSECURE}|g" /etc/traefik/traefik.yml && \
    sed -i "s|__PS_DOMAIN__|${PS_DOMAIN}|g" /etc/traefik/traefik.yml

# Copy entrypoints
COPY config/docker_entrypoint.sh /tmp/docker_entrypoint.sh
RUN chmod +x /tmp/docker_entrypoint.sh

# Execute entrypoint
ENTRYPOINT ["/tmp/docker_entrypoint.sh"]

# Remove temporary files
RUN rm -rf /tmp/*