#!/bin/bash
set -e

echo "[ ****************** ] Starting Endpoint of Application [ ****************** ]"

echo "Back - Starting Endpoint of Application"
if ! [ -d "./vendor" ]; then
    echo " Install depedences whit composer..."
    composer install --ignore-platform-reqs  --no-interaction --verbose --no-suggest
    echo "DB Migration"
    php artisan migrate:refresh
fi

php artisan cache:clear
php artisan view:clear

exec "$@"

set -- php-fpm

exec "$@"
