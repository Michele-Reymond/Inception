FROM debian:buster


# lance le script pour télécharger wordpress
COPY    ./tool/entrypoint.sh /tmp/


# installe les packets nécessaires pour php-fpm
# intalle wp-cli qui permettra d'installer le plugin redis et pho-redis qui permettra de store PHP sessions
# créer le dossier run/php pour lancer php
RUN chmod +x /tmp/entrypoint.sh

RUN apt-get update && apt-get install -y \
            wget \
            php \
            php-cgi \
            php-mysql \
            php-fpm \
            php-pdo \
            php-gd \
            php-cli \
            php-mbstring \
            && mkdir /run/php

# RUN wget https://wordpress.org/latest.tar.gz && \
# 	tar -xzvf latest.tar.gz && \
# 	rm -rf latest.tar.gz

# RUN     wget -P /usr/bin https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
# RUN     chmod +x /usr/bin/wp-cli.phar && mkdir /var/www/wordpress/config

# copie la config pour communiquer avec nginx via le port 9000 au lieu du socket
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

WORKDIR /var/www

EXPOSE 9000

ENTRYPOINT ["/tmp/entrypoint.sh"]
# CMD [ "sleep", "infinity" ]