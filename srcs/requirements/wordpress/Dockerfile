FROM debian:11
RUN apt update && apt upgrade -y
RUN apt install php7.4-fpm php7.4-mysql curl -y mariadb-client -y
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
RUN mkdir -p /run/php
RUN mkdir -p /var/www/html/
RUN chown -R www-data:www-data /var/www/html/
WORKDIR /var/www/html/
COPY wp-setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp-setup.sh
CMD ["/usr/local/bin/wp-setup.sh"]