FROM php:8.1-fpm

LABEL maintainer="Esteban Garviso <e.garvisovenegas@gmail.com>"

# Global variables
ARG ADMIN_MAIL \
	ADMIN_PASSWD \
	PS_VERSION \
	PS_DOMAIN \
	DB_SERVER \
	DB_PORT \
	DB_NAME \
	DB_USER \
	DB_PASSWD \
	DB_PREFIX \
	PS_LANGUAGE \
	PS_COUNTRY \
	PS_ENABLE_SSL \
	PS_SHOP_NAME \
	PS_TIMEZONE \
	PS_HANDLE_DYNAMIC_DOMAIN \
	PS_FOLDER_ADMIN \
	PS_BASE_URI \
	PS_FOLDER_INSTALL

ENV ADMIN_MAIL=$ADMIN_MAIL \
	ADMIN_PASSWD=$ADMIN_PASSWD \
	PS_VERSION=$PS_VERSION \
	PS_DOMAIN=$PS_DOMAIN \
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
	PS_TIMEZONE=$PS_TIMEZONE \
	PS_HANDLE_DYNAMIC_DOMAIN=$PS_HANDLE_DYNAMIC_DOMAIN \
	PS_FOLDER_ADMIN=$PS_FOLDER_ADMIN \
	PS_BASE_URI=$PS_BASE_URI \
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
	libfcgi0ldbl

# Install PHP extensions
RUN rm -rf /var/lib/apt/lists/*
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/ --with-webp=/usr/include
RUN docker-php-ext-install iconv intl pdo_mysql mbstring soap gd zip bcmath
RUN docker-php-source extract \
	&& if [ -d "/usr/src/php/ext/mysql" ]; then docker-php-ext-install mysql; fi \
	&& if [ -d "/usr/src/php/ext/mcrypt" ]; then docker-php-ext-install mcrypt; fi \
	&& if [ -d "/usr/src/php/ext/opcache" ]; then docker-php-ext-install opcache; fi \
	&& docker-php-source delete

# XDEBUG
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug
# This needs in order to run xdebug from VSCode
ENV PHP_IDE_CONFIG 'serverName=DockerApp'

# Install Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Prepare install and CMD script
COPY config/ps-extractor.sh config/docker_run.sh config/docker_nightly_run.sh /tmp/

# Handle dynamic domain
COPY config/docker_updt_ps_domains.php /tmp/

# PHP env for dev / demo modes
COPY config/defines_custom.inc.php /tmp/
RUN chown www-data:www-data /tmp/defines_custom.inc.php

# Apache configuration
RUN if [ -x "$(command -v apache2-foreground)" ]; then a2enmod rewrite; fi

# PHP configuration
COPY config/php.ini /usr/local/etc/php/

# Get PrestaShop
ADD https://github.com/PrestaShop/PrestaShop/releases/download/${PS_VERSION}/prestashop_${PS_VERSION}.zip /tmp/prestashop.zip
RUN mkdir -p /tmp/data-ps \
	&& unzip /tmp/prestashop.zip -d /tmp/data-ps \
	&& bash /tmp/ps-extractor.sh /tmp/data-ps \
	&& rm /tmp/prestashop.zip

# Healthcheck
COPY config/php-fpm-healthcheck.sh /usr/local/bin/php-fpm-healthcheck
RUN chmod +x /usr/local/bin/php-fpm-healthcheck
HEALTHCHECK --interval=10s --timeout=3s --retries=3 CMD ["php-fpm-healthcheck"]

# RUN
CMD ["/tmp/docker_run.sh"]
