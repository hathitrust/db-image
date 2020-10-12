FROM mariadb
ENV MYSQL_RANDOM_ROOT_PASSWORD=1
ADD sql/*.sql /docker-entrypoint-initdb.d/

