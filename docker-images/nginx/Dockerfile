FROM nginx:1.23.3-alpine

LABEL maintainer="Esteban Garviso <e.garvisovenegas@gmail.com>"

# Global variables
ARG APP_ENV \
    NGINX_HOST \
    PS_FOLDER_ADMIN \
    PS_LANGUAGE \
    PS_DEFAULT_LANGUAGE=en

# Copy custom configuration
COPY nginx/nginx.conf /tmp/nginx.conf
COPY php/config/php.ini /tmp/php.ini

# Replace environment variables in nginx.conf
RUN sed -i "s|__APP_ENV__|${APP_ENV}|g" /tmp/nginx.conf
RUN sed -i "s|__NGINX_HOST__|${NGINX_HOST}|g" /tmp/nginx.conf
RUN sed -i "s|__PS_FOLDER_ADMIN__|${PS_FOLDER_ADMIN}|g" /tmp/nginx.conf
RUN sed -i "s|__NGINX_MAX_UPLOAD__|$(grep upload_max_filesize /tmp/php.ini | cut -d'=' -f2 | tr -d '[:space:]')|g" /tmp/nginx.conf
RUN sed -i "s|__PS_LANGUAGE__|${PS_LANGUAGE}|g" /tmp/nginx.conf
RUN sed -i "s|__PS_DEFAULT_LANGUAGE__|${PS_DEFAULT_LANGUAGE}|g" /tmp/nginx.conf

# Copy custom configuration to nginx
RUN cp /tmp/nginx.conf /etc/nginx/conf.d/default.conf

# Remove temporary files
RUN rm /tmp/nginx.conf /tmp/php.ini
