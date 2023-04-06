FROM alpine:3.16

COPY ./tools/entrypoint.sh ./
COPY ./tools/entrypoint.sh ./

# installe les packets nécessaires 
RUN apk update && apk add mariadb mariadb-client expect

#  Pour modifier et accepter les connexions en dehors du localhost
RUN sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf
RUN sed -i "s|.*skip-networking.*|#skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf
# RUN sed -i "s|.*socket.*|#/var/run/mysld/mysqld.sock|g" /etc/my.cnf.d/mariadb-server.cnf

# gérer les droits d'execution de entrypoint
RUN chmod +x /entrypoint.sh

EXPOSE 3306

# lancer le script au depart du container
ENTRYPOINT ["./entrypoint.sh"]