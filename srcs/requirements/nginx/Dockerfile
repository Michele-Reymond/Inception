# Un container Docker contenant NGINX avec TLSv1.2 ou TLSv1.3 uniquement

FROM debian:buster

# Install nginx
RUN apt-get -y update && apt-get -y install nginx

# copy default config
COPY ./conf/default ./default

# expose the port for acess
EXPOSE 80/tcp

# run nginx
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
