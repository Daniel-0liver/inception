WP_DATA = /home/dateixei/data/wordpress
DB_DATA = /home/dateixei/data/mariadb

all: up

up: build
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

build:
	clear
	docker-compose -f ./srcs/docker-compose.yml build

clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true

re: clean up

prune: clean
	@docker system prune -a --volumes -f

.PHONY: all up down build clean re prune
