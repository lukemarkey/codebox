#!/bin/bash

## crontab -e
## ADD CRONTAB TO RUN DAILY @ 11PM FOR EACH DATABASE
## * 23 * * * /home/luke/bash/backup_mongodb.sh django
## TEST AUTOMATIC BACKUP
## * * * * * /home/luke/bash/backup_mongodb.sh django

## CONFIGURATION

APP=$1

## VARIABLES

MONGODUMP_PATH="/usr/bin/mongodump"

BUCKET_NAME=luke-mongodb

OUTPUT=/home/luke/mongodb

TIMESTAMP=$(date +%F_%T | tr ':' '-')
## TEMP_FILE=$(mktemp tmp.XXXXXXXXXX)
S3_FILE="s3://$BUCKET_NAME/$APP/$APP-backup-$TIMESTAMP"

## DUMP AND COMPRESS DATABASE BACKUP FILE

${MONGODUMP_PATH} --out "${OUTPUT}"

tar -zcvf ${OUTPUT}.tgz ${OUTPUT}

s3cmd put ${OUTPUT}.tgz $S3_FILE --encrypt

rm -rf ${OUTPUT}
rm -rf ${OUTPUT}.tgz
