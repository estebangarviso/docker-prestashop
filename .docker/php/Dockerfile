FROM php:8.1-fpm

LABEL maintainer="Esteban Garviso <e.garvisovenegas@gmail.com>"

# Global variables
ARG PHP_DATE_TIMEZONE \
	PHP_SESSION_AUTO_START \
	PHP_SHORT_OPEN_TAG \
	PHP_DISPLAY_ERRORS \
	PHP_MAGIC_QUOTES_GPC \
	PHP_PM_MAX_CHILDREN \
	PHP_MEMORY_LIMIT \
	PHP_MAX_EXECUTION_TIME \
	PHP_MAX_INPUT_TIME \
	PHP_UPLOAD_MAX_FILESIZE \
	PHP_POST_MAX_SIZE \
	PHP_MAX_INPUT_VARS \
	PHP_ALLOW_URL_FOPEN \
	PHP_OPCACHE_ENABLE \
	PHP_OPCACHE_ENABLE_CLI \
	PHP_OPCACHE_MEMORY_CONSUMPTION \
	PHP_OPCACHE_INTERNED_STRINGS_BUFFER \
	PHP_OPCACHE_MAX_ACCELERATED_FILES \
	PHP_OPCACHE_MAX_WASTED_PERCENTAGE \
	PHP_OPCACHE_REVALIDATE_FREQ \
	PHP_OPCACHE_FAST_SHUTDOWN \
	PHP_OPCACHE_ENABLE_FILE_OVERRIDE \
	PHP_OPCACHE_MAX_FILE_SIZE \
	PHP_OPCACHE_VALIDATE_TIMESTAMPS \
	PHP_OPCACHE_REVALIDATE_PATH \
	ADMIN_MAIL \
	ADMIN_PASSWD \
	DB_SERVER \
	DB_PORT \
	DB_NAME \
	DB_USER \
	DB_PASSWD \
	DB_PREFIX \
	PS_VERSION \
	PS_DOMAIN \
	PS_HANDLE_DYNAMIC_DOMAIN \
	PS_LANGUAGE \
	PS_COUNTRY \
	PS_ENABLE_SSL \
	PS_SHOP_NAME \
	PS_SHOP_ACTIVITY \
	PS_TIMEZONE \
	PS_FOLDER_ADMIN \
	PS_FOLDER_INSTALL

ENV ADMIN_MAIL=$ADMIN_MAIL \
	ADMIN_PASSWD=$ADMIN_PASSWD \
	PS_VERSION=$PS_VERSION \
	PS_DOMAIN=$PS_DOMAIN \
	PS_HANDLE_DYNAMIC_DOMAIN=$PS_HANDLE_DYNAMIC_DOMAIN \
	DB_SERVER=$DB_SERVER \
	DB_PORT=$DB_PORT \
	DB_NAME=$DB_NAME \
	DB_USER=$DB_USER \
	DB_PASSWD=$DB_PASSWD \
	DB_PREFIX=$DB_PREFIX \
	PS_LANGUAGE=$PS_LANGUAGE \
	PS_COUNTRY=$PS_COUNTRY \
	PS_ALL_LANGUAGES=0 \
	PS_INSTALL_AUTO=1 \
	PS_ERASE_DB=0 \
	PS_INSTALL_DB=0 \
	PS_DEV_MODE=0 \
	PS_HOST_MODE=0 \
	PS_DEMO_MODE=0 \
	PS_ENABLE_SSL=$PS_ENABLE_SSL \
	PS_SHOP_NAME=$PS_SHOP_NAME \
	PS_SHOP_ACTIVITY=$PS_SHOP_ACTIVITY \
	PS_TIMEZONE=$PS_TIMEZONE \
	PS_FOLDER_ADMIN=$PS_FOLDER_ADMIN \
	PS_FOLDER_INSTALL=$PS_FOLDER_INSTALL

# Install dependencies
RUN apt-get update \
	&& apt-get install -y libmcrypt-dev \
	libjpeg62-turbo-dev \
	libpcre3-dev \
	libpng-dev \
	libwebp-dev \
	libfreetype6-dev \
	libxml2-dev \
	libicu-dev \
	libzip-dev \
	default-mysql-client \
	wget \
	unzip \
	libonig-dev \
	libfcgi0ldbl \
	libmemcached-dev

# Install PHP extensions
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ --with-webp=/usr/include
RUN docker-php-ext-install iconv intl pdo_mysql mbstring soap gd zip bcmath
RUN docker-php-source extract \
	&& if [ -d "/usr/src/php/ext/mysql" ]; then docker-php-ext-install mysql; fi \
	&& if [ -d "/usr/src/php/ext/mcrypt" ]; then docker-php-ext-install mcrypt; fi \
	&& if [ -d "/usr/src/php/ext/opcache" ]; then docker-php-ext-install opcache; fi \
	&& docker-php-source delete

# Install Perl dependencies
RUN pecl install xdebug \
	&& pecl install memcached 

# Enable PHP extensions
RUN docker-php-ext-enable \
	xdebug \
	memcached
# This needs in order to run xdebug from VSCode
ENV PHP_IDE_CONFIG 'serverName=DockerApp'

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Prepare install and CMD script
COPY config/ps-extractor.sh config/docker_run.sh config/docker_nightly_run.sh /tmp/

# Prepare post-install script
RUN mkdir -p /tmp/post-install-scripts
COPY config/post-install-scripts/*.sh /tmp/post-install-scripts/
RUN chmod +x /tmp/post-install-scripts/*.sh

# Handle dynamic domain
COPY config/docker_updt_ps_domains.php /tmp/

# PHP env for dev / demo modes
COPY config/defines_custom.inc.php /tmp/
RUN chown www-data:www-data /tmp/defines_custom.inc.php

# Apache configuration
RUN if [ -x "$(command -v apache2-foreground)" ]; then a2enmod rewrite; fi
# Using the following configuration (to set in the mpm_event.conf file) should allow you to test up to 400 concurrent users:

#    ServerLimit             16
#    MaxClients              400
#    StartServers            3
#    ThreadLimit             64
#    ThreadsPerChild         25
#    MaxRequestWorkers       400
#    MaxConnectionsPerChild  0

# PHP configuration
COPY config/php-production.ini /usr/local/etc/php/
RUN echo "date.timezone = ${PHP_DATE_TIMEZONE}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "session.auto_start = ${PHP_SESSION_AUTO_START}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "short_open_tag = ${PHP_SHORT_OPEN_TAG}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "display_errors = ${PHP_DISPLAY_ERRORS}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "magic_quotes_gpc = ${PHP_MAGIC_QUOTES_GPC}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "memory_limit = ${PHP_MEMORY_LIMIT}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "max_execution_time = ${PHP_MAX_EXECUTION_TIME}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "max_input_time = ${PHP_MAX_INPUT_TIME}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "upload_max_filesize = ${PHP_UPLOAD_MAX_FILESIZE}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "post_max_size = ${PHP_POST_MAX_SIZE}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "max_input_vars = ${PHP_MAX_INPUT_VARS}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "allow_url_fopen = ${PHP_ALLOW_URL_FOPEN}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "opcache.enable = ${PHP_OPCACHE_ENABLE}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "opcache.enable_cli = ${PHP_OPCACHE_ENABLE_CLI}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "opcache.memory_consumption = ${PHP_OPCACHE_MEMORY_CONSUMPTION}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "opcache.interned_strings_buffer = ${PHP_OPCACHE_INTERNED_STRINGS_BUFFER}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "opcache.max_accelerated_files = ${PHP_OPCACHE_MAX_ACCELERATED_FILES}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "opcache.max_wasted_percentage = ${PHP_OPCACHE_MAX_WASTED_PERCENTAGE}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "opcache.revalidate_freq = ${PHP_OPCACHE_REVALIDATE_FREQ}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "opcache.fast_shutdown = ${PHP_OPCACHE_FAST_SHUTDOWN}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "opcache.enable_file_override = ${PHP_OPCACHE_ENABLE_FILE_OVERRIDE}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "opcache.max_file_size = ${PHP_OPCACHE_MAX_FILE_SIZE}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "opcache.validate_timestamps = ${PHP_OPCACHE_VALIDATE_TIMESTAMPS}" >> /usr/local/etc/php/conf.d/php.ini
RUN echo "opcache.revalidate_path = ${PHP_OPCACHE_REVALIDATE_PATH}" >> /usr/local/etc/php/conf.d/php.ini

# PHP-FPM configuration
RUN set -xe && echo "pm.max_children = ${PHP_PM_MAX_CHILDREN}" >> /usr/local/etc/php-fpm.d/zz-docker.conf

# Healthcheck
COPY config/php-fpm-healthcheck.sh /usr/local/bin/php-fpm-healthcheck
RUN chmod +x /usr/local/bin/php-fpm-healthcheck
HEALTHCHECK --interval=10s --timeout=3s --retries=3 CMD ["php-fpm-healthcheck"]

# Get PrestaShop
ADD https://github.com/PrestaShop/PrestaShop/releases/download/${PS_VERSION}/prestashop_${PS_VERSION}.zip /tmp/prestashop.zip
RUN mkdir -p /tmp/data-ps \
	&& unzip /tmp/prestashop.zip -d /tmp/data-ps \
	&& bash /tmp/ps-extractor.sh /tmp/data-ps \
	&& rm /tmp/prestashop.zip

# Enable php fpm status page
RUN set -xe && echo "pm.status_path = /healthcheck" >> /usr/local/etc/php-fpm.d/zz-docker.conf

# Clean repository
RUN apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# RUN
CMD ["/tmp/docker_run.sh"]