# SRCS: srcs/docker-compose.yml

all:
	docker compose -f srcs/docker-compose.yml up

clean:
	# docker compose down
	docker rm -f $$(docker ps -qa)
	docker rmi -f $$(docker image ls -q)
