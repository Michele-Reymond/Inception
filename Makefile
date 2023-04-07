all: run

run:
		@if [ ! -e "/home/mreymond/data" ]; then \
			echo "Setting up volumes:"; \
			mkdir /home/mreymond/data; \
			mkdir /home/mreymond/data/db; \
			mkdir /home/mreymond/data/wp; \
			echo "volumes installed in /home/mreymond/data"; \
		fi
		sudo chmod 777 /etc/hosts
		sudo echo "127.0.0.1 mreymond.42.fr" >> /etc/hosts
		sudo echo "127.0.0.1 www.mreymond.42.fr" >> /etc/hosts
		@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
		@docker compose -f ./srcs/docker-compose.yml down --remove-orphans;

clean:	down
		@echo "Deleting all images : "
		@docker image rmi -f `docker images -qa`;
		@echo "Deleting all volumes : "
		@docker volume rm -f `docker volume ls -q`;
		rm -rf /home/mreymond/data

cvol:	down
		@echo "Deleting all volumes : "
		@docker volume rm -f `docker volume ls -q`;
		rm -rf /home/mreymond/data

re:		clean run

# START containers in interactive mode
nginx:
		@docker exec -it nginx bash
wp:
		@docker exec -it wordpress bash
db:
		@docker exec -it mariadb sh

# docker usefull cmds
prune: 	down
		@docker system prune;
ps:
		@docker ps
img:
		@docker image ls -a

.PHONY: all run stop start down create clean prune nginx wp db ps img re