#!/bin/sh

cat ./wordpress/wp-config.php

if [ $? -eq 1 ]; then
    wget https://wordpress.org/latest.tar.gz
    
    sleep 1
    tar -xzvf latest.tar.gz
    rm -rf latest.tar.gz

    cd wordpress
	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php
	
    sleep 1
	# active le fichier wp-config
	mv wp-config-sample.php wp-config.php
    echo "Wordpress installed"
else
    echo "Wordpress already installed"
fi

# lance php-fpm et ignore le deamon du conf file (-F)
/usr/sbin/php-fpm7.3 -F
