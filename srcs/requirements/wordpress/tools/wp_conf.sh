#!/bin/bash

if ! curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar; then
    echo "Failed to download WP-CLI."
    exit 1
fi

# if [ ! -f ./wp-config.php ]; then
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    cd /var/www/html
    chmod -R 755 /var/www/html/
    chown -R www-data:www-data /var/www/html
    mkdir /run/php/

    touch /run/php/php7.4-fpm.pid

    sleep 15

    wp core download --locale=en_US --allow-root 

    # Configure WordPress with secrets and env vars
    wp config create \
    --dbname=$MYSQL_DATABASE \
    --dbuser=$MYSQL_USER \
    --dbpass=$(cat /run/secrets/db_password) \
    --dbhost=mariadb:3306 \
    --allow-root

    # Install WordPress
    wp core install \
    --url=$DOMAIN_NAME \
    --title=INCEPTION \
    --admin_user=$A_U \
    --admin_password=$(cat /run/secrets/wp_root_password) \
    --admin_email=$A_EMAIL \
    --allow-root

    # Create additional user
    wp user create \
    $U_U $U_EMAIL \
    --role=author \
    --user_pass=$(cat /run/secrets/wp_password) \
    --allow-root

    # sed -i 's!listen = /run/php/php7.4-fpm.sock!listen=wordpress:9000!g' /etc/php/7.4/fpm/pool.d/www.conf
    sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
    # Start PHP-FPM
    php-fpm7.4 -F
# fi