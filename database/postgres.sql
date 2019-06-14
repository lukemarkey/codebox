###########################################################################
## COMMANDS
###########################################################################

## ENTER POSTGRES CONSOLE AS POSTGRES USER
sudo -u postgres psql

## DROP AND RECREATE POSTGRES DATABASE
sudo su postgres
dropdb ${DATABASE}
createdb ${DATABASE}
psql
GRANT ALL PRIVILEGES ON DATABASE ${DATABASE} TO ${USER};

###########################################################################
## SSH REMOTE POSTGRES DATABASE ON LOCALHOST
###########################################################################

ssh -L 2222:localhost:5432 ${USERNAME}@${SERVER}

###########################################################################
## CREATE DATABASE
###########################################################################

CREATE DATABASE ${DATABASE_NAME};
GRANT ALL PRIVILEGES ON DATABASE ${DATABASE_NAME} TO ${DATABASE_USER};
