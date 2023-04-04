#!/bin/sh

mysql_install_db

# init mysql 
/etc/init.d/mysql start

# check si la db existe déjà
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then 
	echo "Database already exists"
else
    # lancement de mysql_secure_installation avec réponses automatiques avec expect
    expect -c "
        set timeout 10
        spawn mysql_secure_installation
        expect \"Enter current password for root (enter for none):\"
        send \"\r\"
        expect \"Set root password?\"
        send \"y\r\"
        expect \"New password:\"
        send \"$MYSQL_ROOT_PASSWORD\r\"
        expect \"Re-enter new password:\"
        send \"$MYSQL_ROOT_PASSWORD\r\"
        expect \"Remove anonymous users?\"
        send \"y\r\"
        expect \"Disallow root login remotely?\"
        send \"y\r\"
        expect \"Remove test database and access to it?\"
        send \"y\r\"
        expect \"Reload privilege tables now?\"
        send \"y\r\"
        expect eof
        "

        echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot -p$MYSQL_ROOT_PASSWORD
fi

/etc/init.d/mysql stop

# Lancement du serveur DB et autorise de listen sur tous les ports
/usr/sbin/mysqld --bind-address=0.0.0.0
