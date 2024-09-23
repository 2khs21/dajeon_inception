# SRCS: srcs/docker-compose.yml

all:
	docker compose -f srcs/docker-compose.yml up

clean:
	# docker compose down
	docker rm -f $$(docker ps -qa) || true
	docker rmi -f $$(docker image ls -q) || true
	docker volume rm $$(docker volume ls -q) || true
