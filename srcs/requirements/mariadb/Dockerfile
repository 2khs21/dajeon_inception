FROM debian:11

RUN env
RUN apt update && apt upgrade -y
RUN apt install mariadb-server -y
RUN sed -i '/^bind-address/s/^/# /' /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./tools/docker-entrypoint.sh /tmp/docker-entrypoint.sh

ENTRYPOINT ["sh", "/tmp/docker-entrypoint.sh"]

CMD ["mysqld"]
