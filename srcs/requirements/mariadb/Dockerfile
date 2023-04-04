# FROM debian:buster

# COPY ./tools/entrypoint.sh ./

# # RUN apt update && apt install  -y vim


# # installe les packets nécessaires 
# RUN apt-get update && apt-get install -y mariadb-server mariadb-client expect

# #  Pour modifier et accepter les connexions en dehors du localhost
# RUN sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf
# RUN sed -i "s|.*skip-networking.*|#skip-networking|g" /etc/mysql/mariadb.conf.d/50-server.cnf

# # gérer les droits d'execution de entrypoint
# RUN chmod +x /entrypoint.sh

# EXPOSE 3306

# # lancer le script au depart du container
# ENTRYPOINT ["./entrypoint.sh"]
# # CMD [ "sleep", "infinity" ]

FROM alpine:3.16

RUN apk update
RUN apk add bash vim
RUN apk add mariadb mariadb-client

#  Pour modifier et accepter les connexions en dehors du localhost
RUN sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf
RUN sed -i "s|.*skip-networking.*|#skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf

COPY ./tools/entrypoint.sh ./

RUN chmod -x /entrypoint.sh

CMD ["bash", "/entrypoint.sh"]
EXPOSE 3306