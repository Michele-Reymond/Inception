#!/bin/sh

# 'docker logs wordpress' pour voir l'installation de wordpress
if [ -f ./wordpress/wp-config.php ]
then
	echo "wordpress already downloaded"
else
	# télécharge wordpress
	wget https://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz
	rm -rf latest.tar.gz

	# ajoute notre fichier de conf 
	rm -rf /etc/php/7.3/fpm/pool.d/www.conf
	mv ./www.conf /etc/php/7.3/fpm/pool.d/

	# pour communiquer avec la DB, importe les variables d'env dans le fichier config de wordpress
	cd /var/www/html/wordpress
	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	
	# active le fichier wp-config
	mv wp-config-sample.php wp-config.php

	# -------------------- REDIS
	wp config set WP_REDIS_HOST redis --allow-root
  	wp config set WP_REDIS_PORT 6379 --raw --allow-root
 	wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
 	wp config set WP_REDIS_CLIENT phpredis --allow-root
 	wp config set WP_REDIS_PASSWORD $REDIS_PASSWORD --allow-root
	wp plugin install redis-cache --activate --allow-root
    wp plugin update --all --allow-root
	wp redis enable --allow-root
	# --------------------
fi

# lance php-fpm et ignore le deamon du conf file (-F)
/usr/sbin/php-fpm7.3 -F