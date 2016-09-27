FROM postgres:9.5

# Set environment variables.
ENV POSTGIS_MAJOR=2.2
ENV POSTGIS_VERSION=2.2.2+dfsg-4.pgdg80+1
ENV PGDATA=/var/lib/postgresql/data_docker

RUN apt-get update \
      && apt-get install -y --no-install-recommends \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
           postgis=$POSTGIS_VERSION \
      && rm -rf /var/lib/apt/lists/*

# Copy init command.
RUN mkdir -p /docker-entrypoint-initdb.d
COPY init_db.sh /docker-entrypoint-initdb.d/

# Normally docker-entrypoint.sh hangs at the end, here we pass --version as
# a kludge to keep it from hanging in the foreground during build time.
RUN /docker-entrypoint.sh postgres --version

# Since we already ran docker-entrypoint.sh at startup, it is redundant and
# slow to run it again, so override the ENTRYPOINT from Postgres Dockerfile
ENTRYPOINT []

# Start the service like the entrypoint does after it is done with init
CMD ["gosu", "postgres", "postgres"]
