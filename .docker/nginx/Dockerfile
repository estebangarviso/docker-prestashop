FROM nginx:1.23-alpine

LABEL maintainer="Esteban Garviso <e.garvisovenegas@gmail.com>"

# Global variables
ARG PHP_CONTAINER_NAME \
    VIRTUAL_HOST \
    VIRTUAL_MAX_UPLOAD \
    PS_FOLDER_ADMIN \
    PS_LANGUAGE \
    PS_DEFAULT_LANGUAGE

# Copy custom configuration
COPY config/nginx.conf /tmp/nginx.conf

# Replace environment variables
RUN sed -i "s|__PHP_CONTAINER_NAME__|${PHP_CONTAINER_NAME}|g" /tmp/nginx.conf
RUN sed -i "s|__VIRTUAL_HOST__|${VIRTUAL_HOST}|g" /tmp/nginx.conf
RUN sed -i "s|__VIRTUAL_MAX_UPLOAD__|${VIRTUAL_MAX_UPLOAD}|g" /tmp/nginx.conf
RUN sed -i "s|__PS_FOLDER_ADMIN__|${PS_FOLDER_ADMIN}|g" /tmp/nginx.conf
RUN sed -i "s|__PS_LANGUAGE__|${PS_LANGUAGE}|g" /tmp/nginx.conf
RUN sed -i "s|__PS_DEFAULT_LANGUAGE__|${PS_DEFAULT_LANGUAGE}|g" /tmp/nginx.conf

# Copy custom configuration to nginx
RUN cp /tmp/nginx.conf /etc/nginx/conf.d/default.conf