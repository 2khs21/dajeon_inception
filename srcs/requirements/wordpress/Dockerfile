FROM debian:11

RUN apt update && apt upgrade -y
RUN apt install php7.4-fpm php7.4-mysql -y
RUN apt install curl -y
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
RUN mkdir -p /var/www/html/
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
RUN chown -R www-data:www-data /var/www/html/
RUN find /var/www/html/ -type d -exec chmod 755 {} \;
RUN find /var/www/html/ -type f -exec chmod 644 {} \;
WORKDIR /var/www/html/
RUN wp core download --path=/var/www/html --allow-root
RUN wp config create --dbname="wpdb" --dbuser="wpuser" --dbpass="wppass" --dbhost="mariadb:3306" --allow-root
RUN wp core install --url="dajeon.42.fr" --title="dajeonia" --admin_user="iamanadmin" --admin_password="passadmin" --admin_email="dajeon@student.42seoul.kr"

CMD ["php7.4-fpm", "-F"]
