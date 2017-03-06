FROM terranodo/postgis 

RUN mkdir -p /docker-entrypoint-initdb.d
COPY init_db.sh /docker-entrypoint-initdb.d/

RUN mkdir -p /backup/
COPY postgres.backup /backup/postgres.backup


# Normally docker-entrypoint.sh hangs at the end, here we pass --version as
# a kludge to keep it from hanging in the foreground during build time.
RUN /docker-entrypoint.sh postgres --version
# Since we already ran docker-entrypoint.sh at startup, it is redundant and
# slow to run it again, so override the ENTRYPOINT from Postgres Dockerfile
ENTRYPOINT []

# Start the service like the entrypoint does after it is done with init
CMD ["gosu", "postgres", "postgres"]
