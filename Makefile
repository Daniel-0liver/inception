WP_DATA = /home/dateixei/data/wordpress
DB_DATA = /home/dateixei/data/mariadb

all: up

up: build
	@mkdir -p $(WP_DATA)
	@mkdir -p $(DB_DATA)
	docker-compose -f ./srcs/docker-compose.yml up -d

down:
	docker-compose -f ./srcs/docker-compose.yml down

stop:
	docker-compose -f ./srcs/docker-compose.yml stop

start:
	docker-compose -f ./srcs/docker-compose.yml start

build:
	clear
	docker-compose -f ./srcs/docker-compose.yml build

ng:
	@docker exec -it nginx

mdb:
	@docker exec -it mariadb

wp:
	@docker exec -it wordpress

clean:
	@docker stop $$(docker ps -qa) || true
	@docker rm $$(docker ps -qa) || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true
	@sudo rm -rf /home/dateixei/data || true

re: clean up

prune: clean
	@docker system prune -a --volumes -f

.PHONY: all up down stop start build ng mdb wp clean re prune
