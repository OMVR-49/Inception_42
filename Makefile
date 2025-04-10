LOGIN = ojebbari

all: prepare up

prepare:
	mkdir -p /home/$(LOGIN)/data/wordpress
	mkdir -p /home/$(LOGIN)/data/mariadb

up:
	cd srcs && docker compose up --build -d
logs:
	docker logs $2
down:
	cd srcs && docker compose down

clean: down
	docker system prune -af
	sudo rm -rf /home/$(LOGIN)/data

re: clean all

.PHONY: all prepare up down clean re