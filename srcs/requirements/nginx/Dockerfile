# Un container Docker contenant NGINX avec TLSv1.2 ou TLSv1.3 uniquement
FROM debian:buster

# Install nginx and ssl
RUN apt-get -y update && apt-get -y install nginx 

RUN mkdir -p /etc/ssl && apt-get -y install openssl && \
    openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    -out /etc/ssl/mreymond.42.fr.crt \
    -keyout /etc/ssl/mreymond.42.fr.key \
    -subj "/C=CH/ST=VD/L=Lausanne/O=42/OU=student/CN=mreymond.42.fr/UID=mreymond"

# copy default config
COPY ./conf/default /etc/nginx/conf.d/default.conf

# expose the port for access
EXPOSE 443

# run nginx
CMD ["nginx", "-g", "daemon off;"]
