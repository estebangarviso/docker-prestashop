# PS E-commerce

[![Docker Pulls](https://img.shields.io/docker/pulls/estebangarviso/ps-ecommerce.svg)](https://hub.docker.com/r/estebangarviso/ps-ecommerce/)
[![Docker Stars](https://img.shields.io/docker/stars/estebangarviso/ps-ecommerce.svg)](https://hub.docker.com/r/estebangarviso/ps-ecommerce/)
[![Docker Automated build](https://img.shields.io/docker/automated/estebangarviso/ps-ecommerce.svg)](https://hub.docker.com/r/estebangarviso/ps-ecommerce/)
[![Docker Build Status](https://img.shields.io/docker/build/estebangarviso/ps-ecommerce.svg)](https://hub.docker.com/r/estebangarviso/ps-ecommerce/)
[![Docker Image Size (tag)](https://img.shields.io/docker/image-size/estebangarviso/ps-ecommerce/latest)](https://hub.docker.com/r/estebangarviso/ps-ecommerce/)
[![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/estebangarviso/ps-ecommerce/latest)](https://hub.docker.com/r/estebangarviso/ps-ecommerce/)

## Supported tags

- `8`, `latest`, `8-nginx`

You can use tags for this. For example:

```
$ docker run -ti --name my-docker-name -e PS_DEV_MODE=false -p 8080:80 -d estebangarviso/ps-ecommerce:8.0
```

PS E-commerce is a project to deploy a high performance [Prestashop on Docker](https://hub.docker.com/r/prestashop/prestashop/).

## Requirements

- [Install Docker](https://docs.docker.com/get-docker/)
- [Install Docker Compose](https://docs.docker.com/compose/install/)

## Services

- [Oracle MySQL v8.0.32](https://www.mysql.com/)
- [Nginx v1.21](https://www.nginx.com/)
- [FastCGI Process Manager PHP v8.1](https://www.php.net/manual/en/install.fpm.php)
- [Traefik Proxy v2.9](https://traefik.io/)

## Docker Compose Profiles

- **default**: This profile is used to create a container with the default configuration.
- **database**: This profile is used to create a database container with the default configuration.
- **reverse-proxy**: This profile is used to create a reverse proxy container with the default configuration.
- **Note:** Edit COMPOSE_PROFILES if you want to use (a) different profile(s). Multiple profiles can be used at the same time by separating them with a comma.

## Data Structure

This is the structure of the cloned project:

```bash
├── .docker
│   └── mysql
│   └── nginx
│   └── php
│   └── traefik
├── .github
│   └── workflows
├── .dockerignore
├── .env
├── .gitignore
├── docker-compose.yml
├── LICENSE.md
└── README.md
```

## How to use

If you want to customize the container execution, here are many available options:

**Note:** You can use the `.env` file to set the environment variables.

### PHP Resource Swapping

- **PHP_PM_MAX_CHILDREN**: The number of child processes to be created when pm is set to 'dynamic' or 'ondemand'. Increase this value if you have many requests per second. _(default value: 5)_
- **PHP_MEMORY_LIMIT**: The maximum amount of memory in bytes that a script is allowed to allocate. This helps prevent poorly written scripts for eating up all available memory on a server. Note that to have no memory limit, set this directive to -1. Recommend 512M for production (256M for development). For highest traffic sites, 1G or more. _(default value: 512M)_
- **PHP_MEMORY_RESERVATION**: The amount of memory in bytes to reserve for each PHP process. This helps prevent memory exhaustion errors in low-memory conditions. Recommend 1/2 of limit. For example, if the limit is 512M, then set reservation to 256M. _(default value: 256M)_
- **PHP_CPUS_LIMIT**: The number of CPUs to limit the container to. This is useful for containers that are CPU intensive. For example, if you have a 4-core server, you can set limit to 2 to limit the container to 2 cores. This will allow other containers to use the remaining 2 cores. Recommend 1 for production (0.5 for development), increase if you have many requests per second. _(default value: 1)_
- **PHP_CPUS_RESERVATION**: The number of CPUs to reserve for the container. Recommend 1/2 of limit. For example, if limit is 2, then set reservation to 1. _(default value: 0.5)_

### [PHP Directives](https://www.php.net/manual/en/ini.list.php)

- **PHP_DATE_TIMEZONE**: The default timezone used by the date functions. _(default value: UTC)_
- **PHP_SESSION_AUTO_START**: Whether or not to automatically start the session. _(default value: Off)_
- **PHP_SHORT_OPEN_TAG**: Whether or not to enable short open tags. _(default value: Off)_
- **PHP_DISPLAY_ERRORS**: Whether or not to display errors. _(default value: Off)_
- **PHP_MAGIC_QUOTES_GPC**: Whether or not to enable magic quotes. _(default value: Off)_
- **PHP_MAX_EXECUTION_TIME**: The maximum time in seconds a script is allowed to run before it is terminated by the parser. This helps prevent poorly written scripts from tying up the server. _(default value: 300)_
- **PHP_MAX_INPUT_TIME**: The maximum time in seconds a script is allowed to parse input data, like POST and GET. _(default value: 300)_
- **PHP_UPLOAD_MAX_FILESIZE**: The maximum size of an uploaded file. _(default value: 20M)_
- **PHP_POST_MAX_SIZE**: The maximum size of POST data that PHP will accept. _(default value: 20M)_
- **PHP_MAX_INPUT_VARS**: The maximum number of variables your server can use for a single function to avoid overloads. _(default value: 20000)_
- **PHP_ALLOW_URL_FOPEN**: Allow or prevent remote file inclusion. _(default value: on)_
- **PHP_OPCACHE_ENABLE**: Enable or disable the opcode cache. _(default value: 1)_
- **PHP_OPCACHE_ENABLE_CLI**: Enable or disable the opcode cache for the CLI version of PHP. _(default value: 0)_
- **PHP_OPCACHE_MEMORY_CONSUMPTION**: The amount of shared memory for storing compiled PHP files. _(default value: 256)_
- **PHP_OPCACHE_INTERNED_STRINGS_BUFFER**: The amount of memory for interned strings in Mbytes. _(default value: 32)_
- **PHP_OPCACHE_MAX_ACCELERATED_FILES**: The maximum number of files that can be stored in the shared memory. _(default value: 16229)_
- **PHP_OPCACHE_MAX_WASTED_PERCENTAGE**: The percentage of "wasted" memory until a restart is scheduled. _(default value: 10)_
- **PHP_OPCACHE_REVALIDATE_FREQ**: How often (in seconds) to check file timestamps for changes to the shared memory storage allocation. Use 0 to validate on each request, useful for development. _(default value: 10)_
- **PHP_OPCACHE_FAST_SHUTDOWN**: Enable or disable fast shutdown. _(default value: 1)_
- **PHP_OPCACHE_ENABLE_FILE_OVERRIDE**: Enable or disable file-based overloading of OPCache API functions. _(default value: 0)_
- **PHP_OPCACHE_MAX_FILE_SIZE**: The maximum size of a file to be cached in OPCache. _(default value: 0)_
- **PHP_OPCACHE_VALIDATE_TIMESTAMPS**: Enable or disable validation of timestamps for cached files. Use 1 in development. _(default value: 0)_
- **PHP_OPCACHE_REVALIDATE_PATH**: Enable or disable revalidation of path for cached files. _(default value: 0)_
- **PHP_REALPATH_CACHE_SIZE**: The size of the realpath cache to be used by PHP. Use 16K in development _(default value: 4096K)_
- **PHP_REALPATH_CACHE_TTL**: The TTL for cache entries of realpaths. Use 120 in development _(default value: 600)_

### MySQL

- **DB_SERVER**: If set, the external MySQL database will be used instead of the volatile internal one _(default value: localhost)_
- **DB_USER**: Override default MySQL user _(default value: db_user)_
- **DB_PASSWD**: Override default MySQL password _(default value: admin)_
- **DB_PREFIX**: Override default tables prefix _(default value: ps\_)_
- **DB_NAME**: Override default database name _(default value: db_name)_

## PrestaShop

- **ADMIN_MAIL**: Override default admin email _(default value: demo@demo.com)_
- **ADMIN_PASSWD**: Override default admin password _(default value: demodemo)_
- **ADMIN_FIRSTNAME**: Override default admin firstname _(default value: John)_
- **ADMIN_LASTNAME**: Override default admin lastname _(default value: Doe)_
- **PS_DOMAIN**: When installing automatically your shop, you can tell the shop how it will be reached. For advanced users only _(default: ps.local)_
- **PS_DEV_MODE**: Enable or disable development mode _(default value: 0)_
- **PS_ENABLE_SSL**: Enable SSL at PrestaShop installation. _(default value: 0)_
- **PS_LANGUAGE**: Change the default language installed with PrestaShop _(default value: es)_
- **PS_COUNTRY**: Change the default country installed with PrestaShop _(default value: CL)_
- **PS_TIMEZONE**: When installing automatically your shop, you can tell the shop which timezone you want to use. For advanced users only _(default: America/Santiago)_
- **PS_SHOP_NAME**: When installing automatically your shop, you can tell the shop which name you want to use. For advanced users only _(default: PS E-commerce)_
- **PS_SHOP_ACTIVITY**: When installing automatically your shop, you can tell the shop which activity you want to use. For advanced users only _(default: 0)_
  1. Lingerie and Adult
  2. Animals and Pets
  3. Art and Culture
  4. Babies
  5. Beauty and Personal Care
  6. Cars
  7. Computer Hardware and Software
  8. Download
  9. Fashion and accessories
  10. Flowers, Gifts and Crafts
  11. Food and beverage
  12. HiFi, Photo and Video
  13. Home and Garden
  14. Home Appliances
  15. Jewelry
  16. Mobile and Telecom
  17. Services
  18. Shoes and accessories
  19. Sports and Entertainment
  20. Travel
- **PS_FOLDER_ADMIN**: Change the name of the admin folder _(default value: admin-ps)_
- **PS_FOLDER_INSTALL**: Change the name of the install folder _(default value: install-ps)_

If your IP / port (or domain) change between two executions of your container, you will need to modify this option:

- **PS_HANDLE_DYNAMIC_DOMAIN**: Add specific configuration to handle dynamic domain _(default value: 0)_

### Traefik

- **PROXY_RESOLVER_EMAIL**: Email address used for registration with the ACME server. This is required for Traefik to obtain certificates from Let's Encrypt. _(default: info@demo.com)_
- **PROXY_API_DASHBOARD**: Enable the Traefik API dashboard. This is useful for debugging. _(default: 0)_
- **PROXY_API_INSECURE**: Enable insecure access to the Traefik API dashboard. This is useful for debugging.. _(default: 0)_
- **PROXY_LOG_LEVEL**: Set the Traefik log level. _(default: ERROR)_ [See more](https://doc.traefik.io/traefik/observability/logs/#level)
- **PROXY_RESOLVER**: Set the Traefik resolver. _(default: none)_
  - staging: Use the Let's Encrypt staging server. This is useful for testing. [See more](https://letsencrypt.org/docs/staging-environment/)
  - production: Use the Let's Encrypt production server. [See more](https://letsencrypt.org/)
  - none: Disable Let's Encrypt. This is useful for testing.
- **PROXY_NGINX_ENTRYPOINTS**: Set the Traefik entrypoints for Nginx. In order to add both HTTP and HTTPS, use `web,websecure`. _(default: web)_ [See more](https://doc.traefik.io/traefik/routing/entrypoints/)
  - web: http port 80
  - websecure: https port 443
- **PROXY_ADD_SELF_SIGNED_CERTIFICATES**: Add self-signed certificates to the Traefik container. This is useful for testing. _(default: 0)_

### Docker Compose

- **COMPOSE_PROJECT_NAME**: Set the Docker Compose project name. _(default: ps-ecommerce)_
- **COMPOSE_PROFILES**: Set the Docker Compose profiles. _(default: database,reverse-proxy)_ [See more](https://docs.docker.com/compose/profiles/)

## Finding your bottleneck(s)

```bash
# PHP-FPM slow requests
sudo grep max_children /var/log/php8.1-fpm-sp.log.1 /var/log/php8.1-fpm-sp.log | tail -n 1
# If you got a warning, you can increase the max_children value (see php-fpm)
```

- [php-fpm](https://serverpilot.io/docs/how-to-change-the-php-fpm-max_children-setting/)

## License

[OSL - Open Software Licence 3.0](https://opensource.org/licenses/OSL-3.0)

## Contributing
