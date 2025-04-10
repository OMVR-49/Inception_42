FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
php7.4 php7.4-fpm php-mysql curl mariadb-client

COPY tools/wp_conf.sh .

RUN chmod +x wp_conf.sh

EXPOSE 9000

CMD ["./wp_conf.sh"]