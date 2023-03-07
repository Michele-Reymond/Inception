# Un container Docker contenant WordPress + php-fpm (installé et configuré) uniquement sans nginx

FROM debian:buster

RUN apk update && \
    apk add php-fpm &&;

COPY ./config/default.conf /etc/nginx/conf.d/default.conf