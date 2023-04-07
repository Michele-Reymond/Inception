#!/bin/sh

# change owner
chown -R mysql:mysql /var/lib/mysql/
chmod -R 750 /var/lib/mysql/

# install la DB
mysql_install_db
sleep 10s

# check si la db existe déjà
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then 
	echo "Database already exists"
else
    # init mysql 
    /etc/init.d/mysql start

    # lancement de mysql_secure_installation avec réponses automatiques avec expect
    echo "Secure installation..."
    sleep 1

    expect -c "
        set timeout 10
        spawn mysql_secure_installation
        expect \"Enter current password for root (enter for none):\"
        send \"\r\"
        expect \"Set root password?\"
        send \"Y\r\"
        expect \"New password:\"
        send \"$MYSQL_ROOT_PASSWORD\r\"
        expect \"Re-enter new password:\"
        send \"$MYSQL_ROOT_PASSWORD\r\"
        expect \"Remove anonymous users?\"
        send \"Y\r\"
        expect \"Disallow root login remotely?\"
        send \"Y\r\"
        expect \"Remove test database and access to it?\"
        send \"Y\r\"
        expect \"Reload privilege tables now?\"
        send \"Y\r\"
        expect eof
        "

        echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot -p$MYSQL_ROOT_PASSWORD
        
        echo "Restarting..."
        killall mysqld
	    sleep 1
fi

# Lancement du serveur DB
echo "Launching mariadb..."
/usr/sbin/mysqld
