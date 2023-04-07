FROM debian:buster

COPY ./tools/entrypoint.sh ./

RUN apt-get update && apt-get -y install mariadb-server mariadb-client expect

RUN sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/mysql/mariadb.conf.d/50-server.cnf
RUN sed -i "s|.*skip-networking.*|#skip-networking|g" /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["./entrypoint.sh"]