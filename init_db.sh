#!/bin/bash
set -e

export PGUSER="$POSTGRES_USER"


psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE worldmap OWNER postgres;
    CREATE DATABASE data OWNER postgres;
EOSQL
pg_restore -d worldmap -U postgres /backup/worldmap.bak
psql worldmap < /backup/users.bak
#pg_restore -d worldmap -U postgres -t people_profile /backup/users.bak
