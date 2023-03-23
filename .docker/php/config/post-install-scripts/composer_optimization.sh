#!/bin/sh
##
# This script is used to optimize the composer installation
# @ref https://devdocs.prestashop-project.org/8/scale/optimizations/#3-composer-autoloading-optimizations
##

cd /var/www/html || exit

echo "Optimizing composer autoloading"
composer dump-autoload --optimize --no-dev --classmap-authoritative

echo "Composer optimization done"
