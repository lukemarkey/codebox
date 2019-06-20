#!/bin/bash


# SCRIPT VARIABLES

OPTIND=1;
SCRIPT=$( basename "${BASH_SOURCE[0]}" ); # SCRIPT NAME
SCRIPTMOD=$( stat -c %Y "${SCRIPTPATH}"/"${SCRIPT}" ); # SCRIPT LAST MOD TIMESTAMP
NUMARGS=$#; # NUMBER OF ARGUMENTS PASS FROM CLI

DATE=`date +%Y-%m-%d`
TIMESTAMP=$(date +%F_%T | tr ':' '-')

## USER VARIABLES

FOLDER="$1"
FILENAME="$1-${DATE}.tar.gz"
BACKUP_FILE="/home/luke/backup/$FILENAME"
S3DIR="s3://luke.h.markey-backup/django"
DESTINATION="${S3DIR}/$FILENAME"

## TODO: RUN COMMAND AND GET FULL VARIABLE PRINTOUT
BASE64MD5="$(/usr/bin/openssl md5 -binary ${BACKUP_FILE} | base64)"

echo "$FOLDER"
echo "$FILENAME"
echo "$BASE64MD5"
echo "$BACKUP_FILE"
echo "$S3DIR"
echo "$DESTINATION"

## DEBUG MULTIPART UPLOAD FOR S3CMD
## s3cmd info s3://luke.h.markey-backup
## s3cmd ls s3://luke.h.markey-backup/django/
## TP1B5o9BG9VaBileUjGEGQ== test.gz
## wu5hl1w7UzWODqcDN7Ms4Q== django-2019-06-19.tar.gz
## /usr/bin/s3cmd multipart s3://luke.h.markey-backup/django/django-2019-06-19.tar.gz
## /usr/bin/s3cmd --upload-id=luke00 put /home/luke/backup/django-2019-06-19.tar.gz s3://luke.h.markey-backup/django/django-2019-06-19.tar.gz
## s3cmd put --add-header=content-md5:wu5hl1w7UzWODqcDN7Ms4Q== test.gz s3://luke.h.markey-backup/django/test.gz
/usr/bin/s3cmd --verbose --continue-put --add-header=content-md5:${BASE64MD5} put ${BACKUP_FILE} ${DESTINATION}
