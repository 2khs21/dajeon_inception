FROM debian:11

RUN apt update
RUN apt upgrade -y
RUN apt install nginx -y

COPY tools/default /etc/nginx/sites-available/default

CMD ["nginx", "-g", "daemon off;"]
