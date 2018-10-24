#!/bin/bash

mkdir ~/postgres
cd ~/postgres

cat << EOF > pg-env.list
PG_MODE=primary
PG_PRIMARY_USER=pgmaster
PG_PRIMARY_PASSWORD=pgmaster
PG_DATABASE=testdb
PG_USER=testuser
PG_PASSWORD=testuser
PG_ROOT_PASSWORD=postgres
PG_PRIMARY_PORT=5432
EOF

cat << EOF > pgadmin-env.list
PGADMIN_SETUP_EMAIL=pgadmin@pgadmin.org
PGADMIN_SETUP_PASSWORD=pgadmin
SERVER_PORT=5050
EOF

docker volume create --driver local --name=pgvolume
docker volume create --driver local --name=pga4volume

docker network create --driver bridge pgnetwork

docker run --publish 5432:5432 \
  --volume=pgvolume:/pgdata \
  --env-file=pg-env.list \
  --name="postgres" \
  --hostname="postgres" \
  --network="pgnetwork" \
  --detach crunchydata/crunchy-postgres:centos7-10.5-2.1.0

docker run --publish 5050:5050 \
  --volume=pga4volume:/var/lib/pgadmin \
  --env-file=pgadmin-env.list \
  --name="pgadmin4" \
  --hostname="pgadmin4" \
  --network="pgnetwork" \
  --detach crunchydata/crunchy-pgadmin4:centos7-10.5-2.1.0
