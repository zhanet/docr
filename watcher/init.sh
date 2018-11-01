#!/bin/bash

is_rebuild() {
    while true; do
        read -p "Rebuild database (y/n)? " answer
        case $answer in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

confirm() {
    while true; do
        read -p "All data will be lost, continue (y/n)? " answer
        case $answer in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

count() {
    ../bin/postgres
    docker exec -it docr-postgres sh -c 'psql -U postgres -c "select count(id) from docr;"' > .count
    count=`cat .count | grep -m 1 -oE "\s+([0-9]+)\r" | grep -Eo "[0-9]+"`; rm .count;
    return $count
}

rebuild() {
    ../bin/postgres
    docker run -it --rm --link docr-postgres:postgres -e TZ=Asia/Shanghai \
    -v $PWD:/docr zhanet/docr sh -c 'PGPASSWORD=$POSTGRES_ENV_POSTGRES_PASSWORD psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres -f /docr/initdb.sql'
    echo 'https://github.com/zhanet/docr' > ~/.docr
}

while getopts ":y" flag; do
    case "${flag}" in
        "y") YES=$flag;;
        "?") echo "Unknown option $OPTARG"; exit 1;;
        # ":") echo "No argument value for option $OPTARG";;
        # *)   echo "Unknown error with option $OPTARG";;
    esac
done

cd `dirname $0`

if [ $YES ]; then
    rebuild
else
    count
    rows=$?
    # echo $rows
    if [ $rows -gt 0 ]; then
        if is_rebuild && confirm ; then
            rebuild
        fi
    else
        rebuild
    fi
fi
