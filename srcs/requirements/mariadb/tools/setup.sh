#!/bin/bash

# Start service temporarily
service mariadb start
sleep 5
# Create database and user
mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '$(cat /run/secrets/db_password)';"
mysql -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"
# mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$(cat /run/secrets/db_root_password)';"
    
mysql -e "FLUSH PRIVILEGES;"
# Stop service
mariadb-admin -u root -p$(cat /run/secrets/db_root_password) shutdown

# Start MariaDB
exec mysqld_safe