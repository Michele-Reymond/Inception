FROM debian:buster

COPY ./tools/entrypoint.sh ./

# RUN apt update && apt install  -y vim

# installe les packets nécessaires 
RUN apt-get update && apt-get install -y mariadb-server mariadb-client expect

# gérer les droits d'execution de entrypoint
RUN chmod +x /entrypoint.sh

EXPOSE 3306

# lancer le script au depart du container
ENTRYPOINT ["./entrypoint.sh"]
# CMD [ "sleep", "infinity" ]