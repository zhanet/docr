#!/bin/bash
cd `dirname $0`
../bin/postgres
docker run -it --rm --link docr-postgres:postgres -e TZ=Asia/Shanghai \
-v $PWD:/docr zhanet/docr sh -c 'PGPASSWORD=$POSTGRES_ENV_POSTGRES_PASSWORD psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres -f /docr/initdb.sql'
