#!/bin/sh

chown -R mysql:mysql /var/lib/mysql/
chmod -R 750 /var/lib/mysql/

# mysql_install_db --datadir=/var/lib/mysql


# init mysql 
# /etc/init.d/mysql start
# /usr/bin/mysqld_safe --datadir=/var/lib/mysql --nowatch

# check si la db existe déjà
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then 
	echo "Database already exists"
else

    mariadb-install-db --datadir=/var/lib/mysql

    /usr/bin/mariadbd-safe --datadir=/var/lib/mysql --nowatch

    # # RETURN values examples: 0 OK | 2 unreachable
    # while ! mysqladmin --host=${MYSQL_HOSTNAME} ping --silent ;
    # do
    #     echo "Waiting..."
    #     sleep 1
    # done

    # lancement de mysql_secure_installation avec réponses automatiques avec expect
    echo "Secure installation..."
    sleep 1

    expect -c "
        set timeout 10
        spawn mysql_secure_installation
        expect \"Enter current password for root (enter for none):\"
        send \"\r\"
        expect \"Switch to unix_socket authentication\"
        send \"n\r\"
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
        sleep 1
        pkill -9 maria
fi

/usr/bin/mariadbd-safe --datadir=/var/lib/mysql

# /etc/init.d/mysql stop

# sleep 1
# Lancement du serveur DB et autorise de listen sur tous les ports
# /usr/sbin/mysqld
# /usr/bin/mysqld_safe & --datadir='/var/lib/mysql'

#!/bin/bash

# chown -R mysql:mysql /var/lib/mysql/
# chmod -R 750 /var/lib/mysql/
# if [ ! -d /var/lib/mysql/mysql ]
# then
# 	echo "Installing MariaDB..."
# 	mariadb-install-db --datadir=/var/lib/mysql

# 	/usr/bin/mariadbd-safe --datadir=/var/lib/mysql --nowatch

# 	# RETURN values examples: 0 OK | 2 unreachable
# 	while ! mysqladmin --host=${MYSQL_HOSTNAME} ping --silent ;
# 	do
# 		echo "Waiting..."
# 		sleep 1
# 	done

# 	echo "Securing MariaDB..."
# 	# Any subsequent tries to run queries this way will get access denied because lack of usr/pwd param
# 	mariadb -e "DROP USER ''@'localhost'"
# 	mariadb -e "DROP USER ''@'$(hostname)'"
# 	mariadb -e "DROP DATABASE test"

# 	echo "Creating the database and a user..."
# 	mariadb -e "CREATE DATABASE ${MYSQL_DATABASE}"
# 	mariadb -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'"
# 	mariadb -e "GRANT ALL PRIVILEGES ON wordpress.* TO '${MYSQL_USER}'@'%'"
# 	mariadb -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'"
# 	mariadb -e "FLUSH PRIVILEGES"

# 	echo "Restarting MariadB for changes..."
# 	sleep 1
# 	pkill -9 maria
# else
# 	echo "MariaDB already installed."
# fi
# /usr/bin/mariadbd-safe --datadir=/var/lib/mysql
