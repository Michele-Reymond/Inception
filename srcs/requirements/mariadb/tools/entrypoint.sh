#!/bin/sh

# faire dans le Dockerfile bin-adresse et network
# target=/etc/mysql/mariadb.conf.d/50-server.cnf
# grep -E "bind-address( )+ = 127.0.0.1" $target > /dev/null
# # $? contient le code de retour de la dernière opération

# # si le retour d erreur est 0
# if [ $? -eq 0 ]; then

#     # ajout de la configutation pour le serveur
#     sed -i "s|bind-address            = 127.0.0.1|bind-address            = 0.0.0.0|g" $target

# fi

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
        send \"$MYSQL_ROOT_PASSWORD\r\"
        expect \"Change the root password?\"
        send \"n\r\"
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
        
        # applique les droits sur le répertoire de la base de donnée
        # chown -R mysql:mysql /var/lib/mysql
fi

/etc/init.d/mysql stop

# Lancement du serveur 
/usr/sbin/mysqld

# sleep infinity


# /usr/bin/mysqld_safe
# # controle si la bd est deja cree
# if [ -e /tmp/database.sql ]; then

#     if [ -z "$MYSQL_DATABASE" ]; then

#         echo "[-] no config variables"
#         echo "no config variables" >> /log.err

#     else

#         echo "[+] create database"

#         /usr/bin/mysqld_safe &

#         sleep 1

#         eval "echo \"$(cat /tmp/database.sql)\"" > /tmp/database.compiled.sql
#         cat /tmp/database.compiled.sql | mariadb

#         killall mysqld
#         sleep 2

#         # applique les droits sur le répertoire de la base de donnée
#         chown -R mysql:mysql /var/lib/mysql

#         rm /tmp/database.sql
#     fi

# else

#     echo "[+] database created"

# fi

# if [ -e /usr/bin/mysqld_safe ]; then

#     # echo "-------- test----------"
#     # find / -type s

#     echo "[+] start server mariadb"
#     # Lancement du serveur 
#     /usr/bin/mysqld_safe

# else

#     echo "[-] Server not installed"

# fi