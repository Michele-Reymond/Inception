FROM debian:buster

# copie la config pour communiquer avec nginx via le port 9000 au lieu du socket
COPY ./conf/www.conf /var/www/html/

# lance le script pour télécharger wordpress
COPY ./tool/entrypoint.sh /usr/local/bin/

# installe les packets nécessaires pour php-fpm
# intalle wp-cli qui permettra d'installer le plugin redis et pho-redis qui permettra de store PHP sessions
# créer le dossier run/php pour lancer php
RUN	chmod +x /usr/local/bin/entrypoint.sh && \
	apt-get update && apt-get install -y \
		wget \
		php \
		php-cgi \
		php-mysql \
		php-fpm \
		php-pdo \
		php-gd \
		php-cli \
		php-mbstring \
        apt-get clean && rm -rf /var/lib/apt/lists/* && \
	    mkdir /run/php

WORKDIR /var/www/html/

EXPOSE 9000

# ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD [ "sleep", "infinity" ]