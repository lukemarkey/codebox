###########################################################################
## INSTALL POSTGRES
###########################################################################

sudo apt install postgresql postgresql-contrib

## SSH TUNNEL TO LOCALHOST

ssh -L 2222:localhost:5432 ${USERNAME}@${IP_ADDRESS}

###########################################################################
## PSQL CONNECT TO RDS
###########################################################################

psql --host=djangodb.c7fgpafxpkvc.us-east-1.rds.amazonaws.com \
--port=5432 \
--username=luke \
--password \
--dbname=portfolio << EOT \
DROP DATABASE portfolio;
CREATE DATABASE portfolio;
GRANT ALL PRIVILEGES ON DATABASE portfolio TO luke;
EOT


## BACKUP POSTGRES DATABASE ( FROM BASH TERMINAL - DO NOT USE PGADMIN WITH PSQL RESTORE)

pg_dump -U ${DATABASE_USER} ${TARGET_DATABASE} -f ${DATABASE_BACKUP_FILENAME}.sql;
scp ${DATABASE_BACKUP_FILENAME}.sql ${USERNAME}@${IP_ADDRESS}:${DESTINATION_PATH}

## DATA DUMP DATABASE WITHOUT CREATING TABLES

pg_dump --column-inserts --data-only ${DATABASE} > ${DATABASE_BACKUP_FILENAME}.sql

## RESTORE POSTGRES DATABASE FROM SQL BACKUP

sudo -u postgres psql
DROP DATABASE ${TARGET_DATABASE};
CREATE DATABASE ${TARGET_DATABASE};
GRANT ALL PRIVILEGES ON DATABASE ${TARGET_DATABASE} TO ${USERNAME};
\q

## RESTORE SQL FILE TO DATABASE - REQUIRES PG_RESTORE IF EXPORTED AS A .BACKUP FILE

psql -U ${USERNAME} -d ${TARGET_DATABASE} -f ${DATABASE_BACKUP_FILENAME}.sql

sudo systemctl restart postgresql

## CREATE USER

sudo su postrgres psql
CREATE USER ${USERNAME} WITH PASSWORD '${PASSWORD}';
ALTER ROLE ${USERNAME} SET client_encoding TO 'utf8';
ALTER ROLE ${USERNAME} SET default_transaction_isolation TO 'read committed';
ALTER ROLE ${USERNAME} SET timezone TO 'utc';
