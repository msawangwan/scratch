## start the postgres database in container A:
# docker run --name f1db -e POSTGRES_PASSWORD=postgres -d postgres
## connect using container A:
# docker exec -it f1db psql postgres -U postgres
## connect using container B and mount a directory:
# docker run -it --rm -v $PWD:/f1db postgres /bin/bash
## connect using container B and mount pgpass:
# run --name=f1db-client -it --rm -v $PWD/.pgpass:/root/.pgpass postgres /bin/bash
# psql -h $CONTAINER_A_IP -p 5432 postgres -U postgres
# psql -h 172.17.0.2 -p 5432 postgres -U postgres
## create the f1db
# createdb -h 172.17.0.2 -p 5432 -U postgres f1db
## load dataset
# pgloader mysql://root@localhost/f1db pgsql:///f1db
# docker exec -it f1db "pgloader mysql://root@localhost/f1db pgsql:///f1db"
