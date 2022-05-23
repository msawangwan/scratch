# syntax=docker/dockerfile:1.3-labs
FROM ubuntu:latest

RUN <<EOF
apt-get update
apt-get install -y \
        make \
        git \
        build-essential
apt-get install -y \
        postgresql-server-dev-all
        #postgresql-server-dev-NN
git clone https://github.com/edoceo/pg-ulid.git
git clone https://github.com/skeeto/ulid-c.git
mv ulid-c pg-ulid
cd pg-ulid
make
make install-strip
EOF

ENTRYPOINT ["/bin/bash"]

#
# See:
#
# https://github.com/edoceo/pg-ulid
# https://gist.github.com/kohenkatz/363eac0f4cef0da6c6d1690b96c4ab02
#
# Also see:
#
# https://github.com/geckoboard/pgulid
# https://github.com/sergeyprokhorenko/pg_ulid_comparison
# https://github.com/geckoboard/pgulid/issues/3
# https://github.com/RPG-18/pg_ulid
#
# For general extension building read:
#
# https://www.postgresql.org/docs/14/libpq-build.html#
#
# Usage:
#
# Copy the .so file to your PGHOME/xxx ..
#
# ..
#
# CREATE EXTENSION pg_ulid;
#
# ..
#
# SELECT ulid_create();
# SELECT ulid_create(now() - '37 days'::interval);
#
# ..
#
# CREATE TABLE ulid_pk_example (
#   id ulid not null default ulid_create(),
#   meta jsonb
# );
#
