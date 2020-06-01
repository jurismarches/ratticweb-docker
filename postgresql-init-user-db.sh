#!/bin/sh

set -e

# create rattic database
/usr/bin/psql -v ON_ERROR_STOP=1 --username "postgres" --set "dbname=$rattic_db_name" --set "dbuser=$rattic_db_user" --set "dbpwd='$rattic_db_password'" <<-EOSQL
    CREATE USER :dbuser WITH PASSWORD :dbpwd CREATEDB;
    CREATE DATABASE :dbname;
    GRANT ALL PRIVILEGES ON DATABASE :dbname TO :dbuser;
EOSQL
