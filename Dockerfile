FROM php:8-fpm

ENV TZ="America/Sao_Paulo"

WORKDIR /var/www/html

RUN apt-get update --fix-missing \
    && pecl channel-update pecl.php.net \
    && apt-get install -yqq \
    && apt-get install -y apt-utils \
    && apt-get install -y gnupg2 \
    && apt-get install -y git \
    && apt-get install -y libzip-dev zip unzip \
    && docker-php-ext-configure zip \
    && docker-php-ext-install zip \
    && docker-php-ext-install mysqli \
    && php -m | grep -q 'zip'

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && chmod +x /usr/local/bin/composer

COPY ./docker/php-fpm/docker-entrypoint.sh /usr/local/bin/
COPY ./docker/php-fpm/php-ini-overrides.ini /usr/local/etc/php/conf.d/99-overrides.ini
COPY ./docker/php-fpm/www.conf.default /usr/local/etc/php-fpm.d/www.conf

RUN chmod 777 /usr/local/bin/docker-entrypoint.sh \
    && ln -s /usr/local/bin/docker-entrypoint.sh /

COPY . /var/www/html/

RUN chown -R www-data:www-data /var/www/html
RUN chmod 777 -R storage/
RUN ls -la storage/*
RUN chmod 777 -R bootstrap/cache/
