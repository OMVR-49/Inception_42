FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl

# Create SSL certificate
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=MA/ST=Khouribga/L=sa7a/O=42/OU=1337/CN=ojebbari.42.fr"

# Copy nginx configuration
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# Expose HTTPS port
EXPOSE 443

# Start nginx
CMD ["nginx", "-g", "daemon off;"]