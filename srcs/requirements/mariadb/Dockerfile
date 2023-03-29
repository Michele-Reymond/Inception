FROM debian:buster

VOLUME /var/lib/mysql

# COPY ./tools/entrypoint.sh ./
# COPY ./conf/database.sql /tmp/

# # # installe les packets nécessaires 
# # RUN	apt update && apt install -y mariadb-server mariadb-client

# RUN chmod +x /entrypoint.sh
# 	# apt-get clean && rm -rf /var/lib/apt/lists/* && \
# 	# mkdir -p /var/run/mysqld && \
# 	# chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
# 	# chmod 777 /var/run/mysqld

# EXPOSE 3306

# ENV MYSQL_DATABASE=${MYSQL_DATABASE} \
# 	MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} \
# 	MYSQL_USER=${MYSQL_USER} \
# 	MYSQL_PASSWORD=${MYSQL_PASSWORD}

# lance  le script pour créer la database wordpress
# ENTRYPOINT ["./entrypoint.sh"]
CMD [ "sleep", "infinity" ]