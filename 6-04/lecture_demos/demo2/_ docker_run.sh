#Создаем сеть 'wordpress' : host, bridge, no
docker network create --driver=bridge wordpress

#Запускаем контейнер с Mysql в сети 'wordpress'. Благо вольюм сздается автоматически!
docker run -d --network='wordpress' --hostname='db' -v 'db_data:/var/lib/mysql' -e 'MYSQL_ROOT_PASSWORD=somewordpress' -e 'MYSQL_DATABASE=wordpress' -e 'MYSQL_USER=wordpress' -e 'MYSQL_PASSWORD=wordpress' mariadb:10.6.4-focal  --default-authentication-plugin='mysql_native_password'

#Запускаем контейнер с wordpress в сети 'wordpress'
docker run -d --network='wordpress' --hostname='wordpress' -v 'wp_data:/var/www/html' -p '80:80' -e 'WORDPRESS_DB_HOST=db' -e 'WORDPRESS_DB_USER=wordpress' -e 'WORDPRESS_DB_PASSWORD=wordpress' -e 'WORDPRESS_DB_NAME=wordpress' wordpress:latest
