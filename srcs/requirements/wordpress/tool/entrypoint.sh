#!/bin/sh

if [ ! -e ./wordpress/wp-config.php ]; then
    #attendre mariaDB
    while ! mysqladmin --host=${MYSQL_HOSTNAME} --user=${MYSQL_USER} --password=${MYSQL_PASSWORD} ping --silent ;
	do
		echo "Waiting for MariaDB..."
		sleep 1
	done

    #install wordpress
    wget https://wordpress.org/latest.tar.gz
    tar -xzvf latest.tar.gz
    rm -rf latest.tar.gz


    cd wordpress
	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php

	# active le fichier wp-config
	mv wp-config-sample.php wp-config.php

    wp core install --url="$WORDPRESS_URL" --title="$WORDPRESS_TITLE" --admin_user="$WORDPRESS_ADMIN_USER" \
    	--admin_password="$WORDPRESS_ADMIN_PASSWORD" --admin_email="$WORDPRESS_ADMIN_EMAIL" --skip-email --allow-root

    # création d'un utilisateur
	wp user create $WORDPRESS_USER $WORDPRESS_USER_EMAIL --role=editor --user_pass=$WORDPRESS_USER_PASSWORD --allow-root
    
    echo "Wordpress fully installed"
else
    echo "Wordpress already installed"
fi

# lance php-fpm et ignore le deamon du conf file (-F)
/usr/sbin/php-fpm7.3 -F
