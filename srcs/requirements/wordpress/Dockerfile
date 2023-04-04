FROM debian:buster


# lance le script pour télécharger wordpress
COPY    ./tool/entrypoint.sh /tmp/


# installe les packets nécessaires pour php-fpm
# intalle wp-cli qui permettra d'installer le plugin redis et pho-redis qui permettra de store PHP sessions
# créer le dossier run/php pour lancer php
RUN	    chmod +x /tmp/entrypoint.sh

RUN     apt-get update && apt-get install -y \
            mariadb-client \
            wget \
            php \
            php-fpm \
            php-mysql \
            php-phar \
            php-curl \
            php-iconv \
            && mkdir /run/php

RUN     wget -P /var/www/ https://wordpress.org/latest.tar.gz
RUN     cd /var/www && tar -xzf latest.tar.gz && rm latest.tar.gz

RUN wget -P /usr/bin https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x /usr/bin/wp-cli.phar

# copie la config pour communiquer avec nginx via le port 9000 au lieu du socket
COPY    ./conf/wp-config.php /var/www/wordpress/wp-config.php
COPY    ./conf/www.conf /etc/php8/php-fpm.d/www.conf

WORKDIR /var/www/wordpress/

EXPOSE 9000

ENTRYPOINT ["/tmp/entrypoint.sh"]
# CMD [ "sleep", "infinity" ]