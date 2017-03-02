#!/bin/bash
set -e

export PGUSER="$POSTGRES_USER"

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "postgres" <<-EOSQL
    CREATE EXTENSION postgis;
    CREATE EXTENSION postgis_topology;
    GRANT ALL ON geometry_columns TO PUBLIC;
    GRANT ALL ON spatial_ref_sys TO PUBLIC;
EOSQL

pg_restore 
pg_restore -U "$POSTGRES_USER" -d "postgres"  /backup/postgres_db.bak