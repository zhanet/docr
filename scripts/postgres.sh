#!/bin/bash

docker volume create pgdata
docker volume create pgadata

docker run --name docr-postgres \
-v pgdata:/var/lib/postgresql/data \
-e POSTGRES_PASSWORD=postgres \
-p 5432:5432 --restart=always \
-d mdillon/postgis

docker run --link docr-postgres \
-v pgadata:/var/lib/pgadmin \
-e "PGADMIN_DEFAULT_EMAIL=postgres@pgadmin.org" \
-e "PGADMIN_DEFAULT_PASSWORD=postgres" \
-p 5050:80 --name docr-pgadmin \
-d dpage/pgadmin4
