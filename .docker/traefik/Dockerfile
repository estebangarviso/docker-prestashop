FROM traefik:v2.9

LABEL maintainer="Esteban Garviso <e.garvisovenegas@gmail.com>"

# Global variables
ARG PROXY_RESOLVER_EMAIL \
  PROXY_LOG_LEVEL \
  PROXY_API_DASHBOARD \
  PROXY_API_INSECURE \
  PROXY_INTRANET_IP_LIST \
  PS_ENABLE_SSL \
  PS_DOMAIN

# Create acme.json file
RUN mkdir -p /etc/traefik/certs && touch /etc/traefik/certs/acme.json && chmod 600 /etc/traefik/certs/acme.json

# Create empty log folder
RUN mkdir -p /var/log/traefik

# Copy main configuration
COPY config/traefik.yml /etc/traefik/

# Copy dynamic configuration
RUN mkdir -p /etc/traefik/dynamic
COPY config/middlewares.yml /etc/traefik/dynamic/

# Replace environment variables in traefik.yml
RUN sed -i "s|__PROXY_RESOLVER_EMAIL__|${PROXY_RESOLVER_EMAIL}|g" /etc/traefik/traefik.yml && \
  sed -i "s|__PROXY_LOG_LEVEL__|${PROXY_LOG_LEVEL}|g" /etc/traefik/traefik.yml && \
  sed -i "s|__PROXY_API_DASHBOARD__|${PROXY_API_DASHBOARD}|g" /etc/traefik/traefik.yml && \
  sed -i "s|__PROXY_API_INSECURE__|${PROXY_API_INSECURE}|g" /etc/traefik/traefik.yml


# Additional configuration into traefik.yml
RUN echo "# Entry Points configuration" >> /etc/traefik/traefik.yml; \
  echo "# ---" >> /etc/traefik/traefik.yml; \
  echo "entryPoints:" >> /etc/traefik/traefik.yml; \
  echo "  web:" >> /etc/traefik/traefik.yml; \
  echo "    address: :80" >> /etc/traefik/traefik.yml; \
  if [ "$PS_ENABLE_SSL" = "1" ]; then \
  echo "    http:" >> /etc/traefik/traefik.yml; \
  echo "      redirections:" >> /etc/traefik/traefik.yml; \
  echo "        entryPoint:" >> /etc/traefik/traefik.yml; \
  echo "          to: websecure" >> /etc/traefik/traefik.yml; \
  echo "          scheme: https" >> /etc/traefik/traefik.yml; \
  echo "  websecure:" >> /etc/traefik/traefik.yml; \
  echo "    address: :443" >> /etc/traefik/traefik.yml \
  echo "    http:" >> /etc/traefik/traefik.yml; \
  echo "      middlewares:" >> /etc/traefik/traefik.yml; \
  echo "        - secureHeaders@file" >> /etc/traefik/traefik.yml; \
  fi; 

RUN if [ "$PROXY_API_DASHBOARD" = "1" ]; then \
  echo "http:" >> /etc/traefik/traefik.yml; \
  echo "  routers:" >> /etc/traefik/traefik.yml; \
  echo "    traefik:" >> /etc/traefik/traefik.yml; \
  echo "      middlewares:" >> /etc/traefik/traefik.yml; \
  echo "        - default@file" >> /etc/traefik/traefik.yml; \
  echo "      rule: 'Host(`traefik.${PS_DOMAIN}`)'" >> /etc/traefik/traefik.yml; \
  echo "      entrypoints:" >> /etc/traefik/traefik.yml; \
  echo "        - websecure" >> /etc/traefik/traefik.yml; \
  echo "      service: 'api@internal'" >> /etc/traefik/traefik.yml; \
  echo "      tls:" >> /etc/traefik/traefik.yml; \
  echo "        options: modern@file" >> /etc/traefik/traefik.yml; \
  echo "  services:" >> /etc/traefik/traefik.yml; \
  echo "    traefik:" >> /etc/traefik/traefik.yml; \
  echo "      loadBalancer:" >> /etc/traefik/traefik.yml; \
  echo "        servers:" >> /etc/traefik/traefik.yml; \
  echo "          port: 8080" >> /etc/traefik/traefik.yml; \
  echo "        sticky:" >> /etc/traefik/traefik.yml; \
  echo "          cookie:" >> /etc/traefik/traefik.yml; \
  echo "            httpOnly: true" >> /etc/traefik/traefik.yml; \
  echo "            secure: true" >> /etc/traefik/traefik.yml; \
  fi

# Additionnal configuration into dynamic/middlewares.yml
RUN HTTP="http"; \
  if [ "$PS_ENABLE_SSL" = "1" ]; then \
  HTTP="https"; \
  fi; \
  echo "    redirect-non-www:" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "      redirectregex:" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "        # Apply a permanent redirection (HTTP 301)" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "        permanent: true" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "        # The regular expression to match and capture elements from the request URL" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "        regex: \"^${HTTP}?://(?:www\\\.)?(.+)\"" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "        # How to modify the URL to have the new target URL" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "        replacement: \"${HTTP}://www.\${1}\"" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "    redirect-www:" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "      redirectregex:" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "        # Apply a permanent redirection (HTTP 301)" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "        permanent: true" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "        # The regular expression to match and capture elements from the request URL" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "        regex: \"^${HTTP}?://www\\\.(.+)\"" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "        # How to modify the URL to have the new target URL" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "        replacement: \"${HTTP}://\${1}\"" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "    intranet-whitelist:" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "      ipwhitelist:" >> /etc/traefik/dynamic/middlewares.yml; \
  echo "        sourcerange:" >> /etc/traefik/dynamic/middlewares.yml; \
  for ip in $(echo $PROXY_INTRANET_IP_LIST | sed "s/,/ /g"); do \
  echo "          - $ip" >> /etc/traefik/dynamic/middlewares.yml; \
  done; \