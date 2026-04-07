FROM mariadb:11.8
ENV MARIADB_RANDOM_ROOT_PASSWORD=1
ADD sql/*.sql /docker-entrypoint-initdb.d/
