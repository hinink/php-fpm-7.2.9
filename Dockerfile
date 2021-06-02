FROM php:7.2.9-fpm-alpine
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories && \
    curl -L "https://install.phpcomposer.com/composer.phar" -o /usr/local/bin/composer  && \
    chchmod +x /usr/local/bin/composer  && \
    apk add --no-cache bzip2-dev && docker-php-ext-install -j 2 bz2 && \
    docker-php-ext-install -j 2 calendar exif && \
    apk add --no-cache freetype-dev libjpeg-turbo-dev libpng-dev && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install -j 2 gd && \
    apk add --no-cache gettext-dev && docker-php-ext-install -j 2 gettext && \
    apk add --no-cache gmp-dev libxml2-dev libxslt-dev && docker-php-ext-install -j 2 gmp mysqli pcntl pdo_mysql sockets shmop sysvmsg sysvsem sysvshm wddx xsl zip && \
    docker-php-ext-enable opcache bz2 calendar exif gd gettext gmp mysqli pcntl pdo_mysql sockets shmop sysvmsg sysvsem sysvshm wddx xsl zip && \
    apk add --no-cache autoconf gcc g++ make && \
    pecl install -o -f redis && docker-php-ext-enable redis && \
    pecl install -o -f igbinary && docker-php-ext-enable igbinary && \
    apk del autoconf gcc g++ make && \
    rm -rf /tmp/pear
