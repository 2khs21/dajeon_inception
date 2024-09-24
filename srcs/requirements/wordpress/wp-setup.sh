#!/bin/bash
set -e

echo "Starting WordPress setup..."

# WordPress 디렉토리 생성 및 권한 설정
mkdir -p /var/www/html
chown -R www-data:www-data /var/www/html

# WordPress 코어 파일 다운로드 (이미 존재하지 않는 경우에만)
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Downloading WordPress core..."
    wp core download --path=/var/www/html --allow-root
else
    echo "WordPress core files already exist. Skipping download."
fi

# MariaDB 컨테이너가 준비될 때까지 대기
until mysqladmin ping -h"mariadb" -u"$DB_USER" -p"$DB_PASSWORD" --silent; do
    echo "Waiting for database connection..."
    sleep 2
done

echo "Database is ready. Continuing WordPress setup..."

# wp-config.php 파일 생성 (이미 존재하지 않는 경우에만)
if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Creating wp-config.php..."
    wp config create --dbname="$DB_NAME" --dbuser="$DB_USER" --dbpass="$DB_PASSWORD" --dbhost="mariadb" --path=/var/www/html --allow-root
else
    echo "wp-config.php already exists. Skipping creation."
fi

# WordPress 설치 (이미 설치되지 않은 경우에만)
if ! $(wp core is-installed --path=/var/www/html --allow-root); then
    echo "Installing WordPress..."
    wp core install --url="$WP_URL" --title="$WP_TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --path=/var/www/html --allow-root
else
    echo "WordPress is already installed. Skipping installation."
fi

echo "WordPress setup completed. Starting PHP-FPM..."
# PHP-FPM 실행
exec php-fpm7.4 -F