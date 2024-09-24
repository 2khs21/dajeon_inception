#!/bin/bash

# MariaDB 컨테이너가 준비될 때까지 대기
until mysqladmin ping -h"mariadb" --silent; do
  echo "Waiting for database connection..."
  sleep 2
done

echo "Database is ready. Setting up WordPress..."

# WordPress 코어 파일 다운로드 (이미 존재하지 않는 경우에만)
if [ ! -f /var/www/html/wp-config.php ]; then
  wp core download --path=/var/www/html --allow-root
  
  # wp-config.php 파일 생성
  wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost="mariadb" --path=/var/www/html --allow-root

  # WordPress 설치
  wp core install --url="dajeon.42.fr" --title="dajeonia" --admin_user="iamanadmin" --admin_password="passadmin" --admin_email="dajeon@student.42seoul.kr" --path=/var/www/html --allow-root
else
  echo "WordPress already set up. Skipping installation."
fi

# PHP-FPM 실행
php-fpm7.4 -F