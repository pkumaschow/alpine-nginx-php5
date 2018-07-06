FROM php:5.6.36-alpine3.7

MAINTAINER Peter Kumaschow <pkumaschow@gmail.com>

RUN apk update
RUN apk add nginx php5-fpm php5-mcrypt php5-mysql php5-pdo_mysql php5-mysqli php5-pcntl php5-gd

RUN mkdir /run/nginx
RUN mkdir /www
RUN chown www-data:www-data /www
RUN mkdir /docker-entrypoint-init.d

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

COPY ./files/etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY ./files/etc/nginx/fastcgi.conf /etc/nginx/fastcgi.conf
COPY ./files/www/index.php /www/index.php
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ADD ./files/docker-entrypoint-init.d /docker-entrypoint-init.d

EXPOSE 80 443

ENTRYPOINT ["/bin/sh", "/docker-entrypoint.sh"]
