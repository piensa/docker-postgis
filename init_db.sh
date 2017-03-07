#!/bin/bash
set -e

export PGUSER="$POSTGRES_USER"


psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
    CREATE DATABASE worldmap OWNER postgres;
EOSQL

# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "worldmap" <<-EOSQL
#     CREATE EXTENSION postgis;
#     CREATE EXTENSION postgis_topology;
#     GRANT ALL ON geometry_columns TO PUBLIC;
#     GRANT ALL ON spatial_ref_sys TO PUBLIC;
# EOSQL

# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "postgres" <<-EOSQL
#     CREATE EXTENSION postgis;
#     CREATE EXTENSION postgis_topology;
#     GRANT ALL ON geometry_columns TO PUBLIC;
#     GRANT ALL ON spatial_ref_sys TO PUBLIC;
# EOSQL
# psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "postgres" <<-EOSQL
#    SELECT pg_terminate_backend(procpid) FROM pg_stat_activity WHERE datname = 'postgres';
#    DROP DATABASE postgres;
#EOSQL
#psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "postgres" 
#psql --set ON_ERROR_STOP=off postgres < /backup/backup.dump
#dropdb -U postgres postgres 
#createdb -U postgres postgres
pg_restore -d worldmap -U postgres /backup/worldmap.bak