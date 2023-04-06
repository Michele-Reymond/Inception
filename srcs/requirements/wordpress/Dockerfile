FROM debian:buster

# copie et gèrer les droits du script d'entrée
COPY    ./tool/entrypoint.sh /tmp/
RUN     chmod +x /tmp/entrypoint.sh

# installe les packets nécessaires pour php-fpm
# créer le dossier run/php pour lancer php
RUN apt-get update && apt-get install -y \
            mariadb-client \
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

# pour utiliser la commande wp
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /tmp && \
		mv /tmp/wp-cli.phar /usr/local/bin/wp && \
		chmod +x /usr/local/bin/wp

# copie la config pour communiquer avec nginx via le port 9000 au lieu du socket
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

# changer de working directory
WORKDIR /var/www

EXPOSE 9000

ENTRYPOINT ["/tmp/entrypoint.sh"]
# CMD [ "sleep", "infinity" ]