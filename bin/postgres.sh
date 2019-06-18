#!/bin/bash

## CHMOD +X ${BASH_FILE_PATH}
## CHMOD -R 755 ${BACKUP_DIRECTORY}

###########################################################################
## AUTOMATED BACKUPS TO AWS S3
###########################################################################

sudo apt install s3cmd
s3cmd --configure ## ENCRYPTION PASSWORD: markey$24

## BACKUP DATABASE
PGPASSWORD='${PASSWORD}' pg_dump -Fc --no-acl -h localhost -U ${USERNAME} ${DATABASE} > ${BACKUP}.dump

## BACKUP DATABASE TO S3
s3cmd put backup.dump s3://luke-postgresql/${FOLDER}/ --encrypt

## BASH FILE
---
#!/bin/bash

APP=$1

DB_NAME=$2
DB_USER=$3
DB_PASS=$4

BUCKET_NAME=luke-postgresql

TIMESTAMP=$(date +%F_%T | tr ':' '-')
TEMP_FILE=$(mktemp tmp.XXXXXXXXXX)
S3_FILE="s3://$BUCKET_NAME/$APP/$APP-backup-$TIMESTAMP"

PGPASSWORD=$DB_PASS pg_dump -Fc --no-acl -h localhost -U $DB_USER $DB_NAME > $TEMP_FILE

s3cmd put $TEMP_FILE $S3_FILE --encrypt
rm "$TEMP_FILE"
---

## ADD CRONTAB TO RUN DAILY @ 11PM FOR EACH DATABASE
crontab -e
* 23 * * * /home/luke/bash/backup_postgresql.sh portfolio portfolio luke 'markey$24'

###########################################################################
## GOOGLE DRIVE BACKUPS
###########################################################################

## CONFIGURATION

BACKUP_DIRECTORY=/home/luke/backups/river/database
DATABASE=river
USER=luke

DRIVE_FOLDER_ID=1lFRBHQxtrDCDV3wJsOp8juCB3sg5bpFr

## VARIABLES

DAYS_TO_KEEP=14
FILE_SUFFIX=_database.sql

FILE=`date +"%Y%m%d%H%M"`${FILE_SUFFIX}
OUTPUT_FILE=${BACKUP_DIRECTORY}/${FILE}

## DUMP AND COMPRESS DATABASE BACKUP FILE

pg_dump -U ${USER} ${DATABASE} -F p -f ${OUTPUT_FILE}
gzip ${OUTPUT_FILE}

## BACKUP TO GOOGLE DRIVE ( GDRIVE )

drive upload --parent ${DRIVE_FOLDER_ID} --file ${OUTPUT_FILE}.gz

## REMOVE OLD ENTRIES PAST DAYS TO KEEP

find ${BACKUP_DIRECTORY} -maxdepth 1 -mtime ${DAYS_TO_KEEP} -name "*${FILE_SUFFIX}.gz" -exec rm -rf '{}' ';'
