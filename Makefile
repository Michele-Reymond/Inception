all: run

run:
		@if [ ! -e "/Users/$(USER)/data" ]; then \
			echo "Setting up volumes:"; \
			mkdir /home/$USER/data; \
			mkdir /home/$USER/data/db; \
			mkdir /home/$USER/data/wp; \
			echo "volumes installed in /home/$USER/data"; \
		fi
		@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
		@docker compose -f ./srcs/docker-compose.yml down --remove-orphans;

clean:	down
		sudo rm -rf /Users/$(USER)/data
		@echo "Deleting all images : "
		@docker image rmi -f `docker images -qa`;
		@echo "Deleting all volumes : "
		@docker volume rm -f `docker volume ls -q`;

cvol:	down
		sudo rm -rf /Users/$(USER)/data
		@echo "Deleting all volumes : "
		@docker volume rm -f `docker volume ls -q`;

# create:
# 		@sh setup.sh
# 		@docker-compose -f ./srcs/docker-compose.yml create --build

# start:
# 		docker-compose -f ./srcs/docker-compose.yml start;

# stop:
# 		docker-compose -f ./srcs/docker-compose.yml stop;

re:		clean run

# START containers in interactive mode
nginx:
		@docker exec -it nginx bash
wordpress:
		@docker exec -it wordpress bash
mariadb:
		@docker exec -it mariadb bash

# docker usefull cmds
prune: 	down
		@docker system prune;
ps:
		@docker ps
img:
		@docker image ls -a

.PHONY: all run stop start down create clean prune nginx wordpress mariadb ps img re