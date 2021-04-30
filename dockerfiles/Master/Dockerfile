FROM php:7.4.14-cli-buster

RUN apt-get update && apt-get install -y \
        build-essential \
        autoconf \
        libssl-dev \
        # composer \
        unzip \
        # php-pear \
        # pkg-config \
        libxml2-dev \
        libsqlite3-dev \
        libcurl4-openssl-dev \
        libpng-dev \
        libonig-dev  \
    && docker-php-ext-install -j$(nproc) \
        bcmath \
        sockets \
        # curl \
        gd \
        # mbstring \
        mysqli \
        # pdo \
        pdo_mysql \
        soap \
        # openssl \
        # zlib
        # shmop \
        # pcntl \
        # sigchild \
        # sysvshm \
        # sysvsem \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer \
    && pecl install xdebug \
    && docker-php-ext-enable xdebug
WORKDIR "/home/ubuntu/client"
#CMD ["php", "WraithOrchestrator.php", "-d"]