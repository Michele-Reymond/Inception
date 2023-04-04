#!/bin/sh

# 'docker logs wordpress' pour voir l'installation de wordpress
# if [ -f ./wp-config.php ]
# then
# 	echo "wordpress already downloaded"
# else
#     sed -i "s|.*listen = 127.0.0.1.*|listen = 9000|g" wp-config.php
# 	sed -i "s/username_here/$MYSQL_USER/g" wp-config.php
# 	sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config.php
# 	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config.php
# 	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config.php
	
# fi

while ! mysqladmin --host=${MYSQL_HOSTNAME} --user=${MYSQL_USER} --password=${MYSQL_PASSWORD} ping --silent ;
	do
		echo "Waiting for MariaDB..."
		sleep 1
	done

# Modifier le fichier www.conf pour que ca fonctionne en local comme demande
target="/etc/php/7.3/fpm/pool.d/www.conf"

# Le fichier www.conf est relatif a php-fpm (necessaire communication avec le serveur)
grep -E "listen = 127.0.0.1" $target > /dev/null 2>&1
#$? contient le code de retour de la dernière opération
#si le retour d erreur et egale a 0 alors
if [ $? -eq 0 ]; then
	sed -i "s|.*listen = 127.0.0.1.*|listen = 9000|g" $target
	echo "env[MYSQL_HOSTNAME] = \$MYSQL_HOSTNAME" >> $target
	echo "env[MYSQL_USER] = \$MYSQL_USER" >> $target
	echo "env[MYSQL_PASSWORD] = \$MYSQL_PASSWORD" >> $target
	echo "env[MYSQL_DATABASE] = \$MYSQL_DATABASE" >> $target
fi


# lance php-fpm et ignore le deamon du conf file (-F)
/usr/sbin/php-fpm7.3 -F